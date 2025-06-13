package com.forum.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Logger;

/**
 * CORS (Cross-Origin Resource Sharing) filter for web service endpoints
 * Allows API access from different domains for external integration
 *
 * @author Simphiwe Radebe
 * @version 1.0
 * @since 2025-06-04
 */
@WebFilter(filterName = "CORSFilter", urlPatterns = {"/api/*"})
public class CORSFilter implements Filter {

    /** Logger instance for filter operations */
    private static final Logger LOGGER = Logger.getLogger(CORSFilter.class.getName());

    /**
     * Initializes the CORS filter
     */
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        LOGGER.info("CORSFilter initialized");
    }

    /**
     * Adds CORS headers to the response
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Get origin from request
        String origin = httpRequest.getHeader("Origin");

        // Set CORS headers
        if (origin != null && isAllowedOrigin(origin)) {
            httpResponse.setHeader("Access-Control-Allow-Origin", origin);
        } else {
            // Allow localhost for development
            httpResponse.setHeader("Access-Control-Allow-Origin", "*");
        }

        httpResponse.setHeader("Access-Control-Allow-Methods",
                "GET, POST, PUT, DELETE, OPTIONS, HEAD");

        httpResponse.setHeader("Access-Control-Allow-Headers",
                "Origin, X-Requested-With, Content-Type, Accept, Authorization, " +
                        "X-CSRF-Token, X-Requested-With");

        httpResponse.setHeader("Access-Control-Allow-Credentials", "true");

        httpResponse.setHeader("Access-Control-Max-Age", "3600");

        // Handle preflight OPTIONS requests
        if ("OPTIONS".equalsIgnoreCase(httpRequest.getMethod())) {
            httpResponse.setStatus(HttpServletResponse.SC_OK);
            return;
        }

        // Continue with the filter chain
        chain.doFilter(request, response);
    }

    /**
     * Checks if the origin is allowed
     *
     * @param origin The origin to check
     * @return true if allowed, false otherwise
     */
    private boolean isAllowedOrigin(String origin) {
        // Define allowed origins for production
        String[] allowedOrigins = {
                "http://localhost:3000",
                "http://localhost:8080",
                "http://localhost:8081",
                "http://127.0.0.1:3000",
                "http://127.0.0.1:8080"
        };

        for (String allowedOrigin : allowedOrigins) {
            if (allowedOrigin.equals(origin)) {
                return true;
            }
        }

        return false;
    }

    /**
     * Destroys the filter
     */
    @Override
    public void destroy() {
        LOGGER.info("CORSFilter destroyed");
    }
}