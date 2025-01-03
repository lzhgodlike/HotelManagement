package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet Filter implementation class HeaderFilter
 */
@WebFilter("/*")
public class HeaderFilter implements Filter {

    /**
     * Default constructor. 
     */
    public HeaderFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
    public void doFilter(ServletRequest request, ServletResponse resp, FilterChain chain) throws IOException, ServletException  
    {  
    HttpServletResponse response = (HttpServletResponse) resp; response.setHeader("Access-Control-Allow-Origin", "*"); //解决跨域访问报错   
    response.setHeader("Access-Control-Allow-Methods", "POST, PUT, GET, OPTIONS, DELETE");   
    response.setHeader("Access-Control-Max-Age", "12000"); //设置过期时间 
    response.setHeader("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, client_id, uuid, Authorization");   
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // 支持HTTP 1.1.   
    response.setHeader("Pragma", "no-cache"); // 支持HTTP 1.0. response.setHeader("Expires", "0");
    response.setHeader("Access-Control-Allow-Origin", "*"); 
	response.setContentType("text/html");
    response.setCharacterEncoding("utf-8");
    request.setCharacterEncoding("utf-8");
    
//    System.out.println("完成了过滤");
    chain.doFilter(request, resp);   
    }   
    public void init(FilterConfig filterConfig) {}   
    public void destroy() {}

}
