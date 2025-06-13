package com.forum.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Logger;

/**
 * Authentication filter to protect secured pages
 * Ensures users are logged in before accessing protected resources
 *
 * @author Simphiwe Radebe
 * @version 1.2
 * @since 2025-06-04
 */
@WebFilter(filterName = "AuthenticationFilter", urlPatterns = {
        "/forum/*",
        "/user/profile",
        "/user/update-profile",
        "/user/change-password"
})
public class AuthenticationFilter implements Filter {

    /** Logger instance for filter operations */
    private static final Logger LOGGER = Logger.getLogger(AuthenticationFilter.class.getName());

    /**
     * Initializes the filter
     */
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        LOGGER.info("AuthenticationFilter initialized");
    }

    /**
     * Performs the filtering logic
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();

        // Allow access to login, register, and public forum browsing
        if (requestURI.endsWith("/login") ||
                requestURI.endsWith("/register") ||
                requestURI.endsWith("/forgot-password") ||
                requestURI.endsWith("/reset-password") ||
                (requestURI.equals(contextPath + "/forum") &&
                        httpRequest.getMethod().equals("GET"))) {
            chain.doFilter(request, response);
            return;
        }

        // Check if user is authenticated
        HttpSession session = httpRequest.getSession(false);
        Integer userId = null;

        if (session != null) {
            userId = (Integer) session.getAttribute("userId");
        }

        if (userId == null) {
            // User not authenticated, redirect to login
            String redirectTo = httpRequest.getRequestURI();
            if (httpRequest.getQueryString() != null) {
                redirectTo += "?" + httpRequest.getQueryString();
            }

            httpResponse.sendRedirect(contextPath + "/user/login?redirectTo=" +
                    java.net.URLEncoder.encode(redirectTo, "UTF-8"));
            return;
        }

        // User is authenticated, continue with request
        chain.doFilter(request, response);
    }

    /**
     * Destroys the filter
     */
    @Override
    public void destroy() {
        LOGGER.info("AuthenticationFilter destroyed");
    }
}