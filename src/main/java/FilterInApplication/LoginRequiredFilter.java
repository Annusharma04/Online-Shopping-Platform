package FilterInApplication;
import java.io.IOException;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

@WebFilter(urlPatterns="*.do")
public class LoginRequiredFilter implements Filter {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpServletRequest request=(HttpServletRequest)servletRequest;
		System.out.println(request.getRequestURI());

		if(request.getSession().getAttribute("name")!=null)
		{
			chain.doFilter(servletRequest, servletResponse);
		}else
		{
			request.getRequestDispatcher("Login.jsp").forward(servletRequest, servletResponse);;
		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
