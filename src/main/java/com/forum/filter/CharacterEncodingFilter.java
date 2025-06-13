package com.forum.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import java.io.IOException;
import java.util.logging.Logger;

/**
 * Character encoding filter to ensure UTF-8 encoding for all requests and responses
 * Prevents character encoding issues with international characters
 *
 * @author Simphiwe Radebe
 * @version 1.0
 * @since 2025-06-03
 */
@WebFilter(
        filterName = "CharacterEncodingFilter",
        urlPatterns = {"/*"},
        initParams = {
                @WebInitParam(name = "encoding", value = "UTF-8"),
                @WebInitParam(name = "forceEncoding", value = "true")
        }
)
public class CharacterEncodingFilter implements Filter {

    /** Logger instance for filter operations */
    private static final Logger LOGGER = Logger.getLogger(CharacterEncodingFilter.class.getName());

    /** Default encoding to use */
    private String encoding = "UTF-8";

    /** Whether to force encoding even if request already has encoding */
    private boolean forceEncoding = false;

    /**
     * Initializes the filter with configuration parameters
     */
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        String encodingParam = filterConfig.getInitParameter("encoding");
        if (encodingParam != null && !encodingParam.trim().isEmpty()) {
            this.encoding = encodingParam;
        }

        String forceParam = filterConfig.getInitParameter("forceEncoding");
        if (forceParam != null) {
            this.forceEncoding = Boolean.parseBoolean(forceParam);
        }

        LOGGER.info("CharacterEncodingFilter initialized with encoding: " + encoding +
                ", forceEncoding: " + forceEncoding);
    }

    /**
     * Applies character encoding to request and response
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        // Set request encoding if not already set or if forcing
        if (request.getCharacterEncoding() == null || forceEncoding) {
            request.setCharacterEncoding(encoding);
        }

        // Set response encoding
        response.setCharacterEncoding(encoding);

        // Set content type for responses that don't have it
        if (response.getContentType() == null) {
            response.setContentType("text/html; charset=" + encoding);
        }

        // Continue with the filter chain
        chain.doFilter(request, response);
    }

    /**
     * Destroys the filter
     */
    @Override
    public void destroy() {
        LOGGER.info("CharacterEncodingFilter destroyed");
    }
}