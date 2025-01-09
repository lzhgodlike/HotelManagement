package servlet;

import bean.RentCase;

import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

@WebServlet("/ExportData")
public class ExportData extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /*
        * 将MySQL数据以Excel文件的形式导出
        * 1、从数据库获取数据
        * 2、创建Excel表的同时将数据写入至Excel文件内
        * 3、将Excel文件以流的形式输出
        * 4、关闭资源
        * 5、删除Excel文件(不确定能否删除,因为刚生成的文件,可能无法删除)
        * */

        /*
        * 1、从数据库获取数据
        * */
        List<RentCase> data;
        try {
            data = RentCase.getRentCase();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        /*
        * 2、创建Excel表的同时将数据写入至Excel文件内
        * */
        XSSFWorkbook excel = new XSSFWorkbook();  //创建工作簿对象
        XSSFSheet sheet = excel.createSheet("RentCase Data");  //创建工作表对象并命名为"RentCase Data"
        XSSFRow firstRow = sheet.createRow(0); //在"RentCase Data"中创建表头行

        //在表头行中创建列并设置值
        firstRow.createCell(0).setCellValue("Case ID");
        firstRow.createCell(1).setCellValue("Customer ID");
        firstRow.createCell(2).setCellValue("Customer ID Card");
        firstRow.createCell(3).setCellValue("Customer Name");
        firstRow.createCell(4).setCellValue("Customer Unit");
        firstRow.createCell(5).setCellValue("Customer Phone");
        firstRow.createCell(6).setCellValue("Pick Status");
        firstRow.createCell(7).setCellValue("Deposit");
        firstRow.createCell(8).setCellValue("Food Services");
        firstRow.createCell(9).setCellValue("Mobility Services");
        firstRow.createCell(10).setCellValue("Amount Spent");

        //循环往Excel文件中写入数据
        for (int i = 0; i < data.size(); i++) {
            RentCase rentCase = data.get(i);
            XSSFRow row = sheet.createRow(i + 1); //从第二行开始创建行

            //在当前行中创建列并设置值
            row.createCell(0).setCellValue(rentCase.getCase_id());
            row.createCell(1).setCellValue(rentCase.getCustomer_id());
            row.createCell(2).setCellValue(rentCase.getCustomer_idcard());
            row.createCell(3).setCellValue(rentCase.getCustomer_name());
            row.createCell(4).setCellValue(rentCase.getCustomer_unit());
            row.createCell(5).setCellValue(rentCase.getCustomer_phone());
            row.createCell(6).setCellValue(rentCase.getPick_status());
            row.createCell(7).setCellValue(rentCase.getDeposit());
            row.createCell(8).setCellValue(rentCase.isFood_services() ? "是" : "否");
            row.createCell(9).setCellValue(rentCase.isMobility_services() ? "是" : "否");
            row.createCell(10).setCellValue(rentCase.getAmount_spent());
        }

        //创建Excel文件对象
        String fileName = "RentCaseData.xlsx";  //设置导出Excel时的文件名
//        File file = new File("D:\\JavaProject\\hotel-management\\src\\main\\webapp\\Excel\\" + fileName);  //创建Excel文件对象
        File file = new File("E:\\大三上\\课程设计\\project3" + fileName);
        
        //创建一个文件输出流
        FileOutputStream fileOutputStream = new FileOutputStream(file);

        //将Excel表格对象写入到Excel文件中
        excel.write(fileOutputStream);
        fileOutputStream.close();  //关闭文件输出流

        // 3、将Excel文件以流的形式输出
        fileName = URLEncoder.encode(fileName,"UTF-8");  //设置导出Excel时的文件名(防止中文乱码)
        resp.setContentType("application/vnd.ms-excel;chartset=utf-8");  //设置响应头,告诉浏览器返回的是一个Excel文件
        resp.setHeader("Content-Disposition", "attachment;filename=" + fileName);  //设置响应头,告诉浏览器返回的文件名
        ServletOutputStream out = resp.getOutputStream();  //创建一个文件输出流
        excel.write(out);  //将Excel表格对象写入到Excel文件中

        //4、关闭资源
        out.flush();  //刷新输出流
        out.close();  //关闭输出流

        System.out.println("导出成功!");
        System.out.println("文件是否删除成功：" + file.delete());
    }
}