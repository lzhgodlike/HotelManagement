package servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.google.gson.Gson;
import bean.ReturnBean;

@WebServlet("/fileUpload")
public class FileUploadServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ReturnBean returnBean = new ReturnBean(500, "上传失败");
        //请求对象的请求方式需要是post，并且enctype="multipatr/form-data"才能进行文件上传
        if (ServletFileUpload.isMultipartContent(request)) {
            try {
                //实例化factory对象
                DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
                //实例化上传servletFileUpload对象
                ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);
                //将request对象中的数据转为list
                List<FileItem> fileItems = servletFileUpload.parseRequest(request);
                if (fileItems != null) {
                    for (FileItem fileItem : fileItems) {
                        //如果fileItem不是普通的表单元素，就可以将该元素写到后端数据库
                        if (!fileItem.isFormField()) {
                            //获取项目存储的磁盘地址,到项目文件夹为止
                        	System.out.println(getServletContext());
                            String realPath = getServletContext().getRealPath("/");
                            //获取上传的文件的文件名
                            String name = fileItem.getName();
                            //新建的文件相对项目文件夹的存储路径（项目文件夹下的img文件夹）
                            String filePath = "img/" + new Date().getTime() + name;
                            //新建文件，提供文件的绝对路径参数
                            File file = new File(realPath + "/" + filePath);
                            //将上传的文件复制给新建的file文件，write方法会自动关闭流。这个write方法是diskfileItem中的方法，自带关闭功能
                            fileItem.write(file);
                            //文件在后端保存成功则输入文件保存成功提示码和文件存储的相对路径
                            returnBean.setCode(200);
                            returnBean.setMessage(filePath);
                        }
                    }
                }
            } catch (FileUploadException e) {
                throw new RuntimeException(e);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
        Gson gson = new Gson();
        String s = gson.toJson(returnBean);
        PrintWriter out = response.getWriter();
        out.write(s);
    }
}
