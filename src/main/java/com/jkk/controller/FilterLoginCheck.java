package com.jkk.controller;

import com.jkk.service.AttrToken;
import com.jkk.service.ErrorPath;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "FilterLoginCheck",urlPatterns = "/file/*")
public class FilterLoginCheck implements Filter {
	public void destroy() {
	}

	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
		HttpSession session = ((HttpServletRequest)req).getSession();
		if (session.getAttribute(AttrToken.USER) == null) {
			((HttpServletResponse)resp).sendRedirect(((HttpServletRequest)req).getContextPath()+ ErrorPath.html500);
		}
		chain.doFilter(req, resp);
	}

	public void init(FilterConfig config) throws ServletException {

	}

}
