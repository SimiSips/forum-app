package com.forum.listener;

import com.forum.config.DatabaseConfig;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.logging.Logger;

/**
 * Application context listener for initialization and cleanup
 * Handles application startup and shutdown events
 *
 * @author Simphiwe Radebe
 * @version 1.0
 * @since 2025-06-03
 */
@WebListener
public class ApplicationContextListener implements ServletContextListener {

    /** Logger instance for listener operations */
    private static final Logger LOGGER = Logger.getLogger(ApplicationContextListener.class.getName());

    /**
     * Called when the web application is being deployed
     */
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        LOGGER.info("Forum Application is starting up...");

        try {
            // Initialize database configuration
            DatabaseConfig dbConfig = DatabaseConfig.getInstance();

            // Test database connection
            if (dbConfig.testConnection()) {
                LOGGER.info("Database connection test successful");
                sce.getServletContext().setAttribute("dbStatus", "connected");
            } else {
                LOGGER.severe("Database connection test failed");
                sce.getServletContext().setAttribute("dbStatus", "disconnected");
            }

            // Set application attributes
            sce.getServletContext().setAttribute("appName", "Forum Application");
            sce.getServletContext().setAttribute("appVersion", "1.0.0");
            sce.getServletContext().setAttribute("appAuthor", "Simphiwe Radebe");
            sce.getServletContext().setAttribute("startupTime", System.currentTimeMillis());

            // Create logs directory if it doesn't exist
            java.io.File logsDir = new java.io.File("logs");
            if (!logsDir.exists()) {
                boolean created = logsDir.mkdirs();
                if (created) {
                    LOGGER.info("Logs directory created successfully");
                } else {
                    LOGGER.warning("Failed to create logs directory");
                }
            }

            LOGGER.info("Forum Application startup completed successfully");

        } catch (Exception e) {
            LOGGER.severe("Error during application startup: " + e.getMessage());
            sce.getServletContext().setAttribute("startupError", e.getMessage());
        }
    }

    /**
     * Called when the web application is being undeployed
     */
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        LOGGER.info("Forum Application is shutting down...");

        try {
            // Clean up resources
            Long startupTime = (Long) sce.getServletContext().getAttribute("startupTime");
            if (startupTime != null) {
                long uptime = System.currentTimeMillis() - startupTime;
                LOGGER.info("Application uptime: " + formatUptime(uptime));
            }

            // Clear application attributes
            sce.getServletContext().removeAttribute("dbStatus");
            sce.getServletContext().removeAttribute("appName");
            sce.getServletContext().removeAttribute("appVersion");
            sce.getServletContext().removeAttribute("appAuthor");
            sce.getServletContext().removeAttribute("startupTime");

            LOGGER.info("Forum Application shutdown completed successfully");

        } catch (Exception e) {
            LOGGER.severe("Error during application shutdown: " + e.getMessage());
        }
    }

    /**
     * Formats uptime in a human-readable format
     *
     * @param uptimeMillis Uptime in milliseconds
     * @return Formatted uptime string
     */
    private String formatUptime(long uptimeMillis) {
        long seconds = uptimeMillis / 1000;
        long minutes = seconds / 60;
        long hours = minutes / 60;
        long days = hours / 24;

        if (days > 0) {
            return String.format("%d days, %d hours, %d minutes",
                    days, hours % 24, minutes % 60);
        } else if (hours > 0) {
            return String.format("%d hours, %d minutes", hours, minutes % 60);
        } else if (minutes > 0) {
            return String.format("%d minutes, %d seconds", minutes, seconds % 60);
        } else {
            return String.format("%d seconds", seconds);
        }
    }
}