package com.forum.listener;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.logging.Logger;

/**
 * Session listener for tracking user sessions and activity
 * Monitors session creation, destruction, and attribute changes
 *
 * @author Simphiwe Radebe
 * @version 1.0
 * @since 2025-06-04
 */
@WebListener
public class SessionListener implements HttpSessionListener, HttpSessionAttributeListener {

    /** Logger instance for session operations */
    private static final Logger LOGGER = Logger.getLogger(SessionListener.class.getName());

    /** Counter for active sessions */
    private static final AtomicInteger activeSessions = new AtomicInteger(0);

    /** Counter for total sessions created */
    private static final AtomicInteger totalSessions = new AtomicInteger(0);

    /**
     * Called when a session is created
     */
    @Override
    public void sessionCreated(HttpSessionEvent se) {
        int activeCount = activeSessions.incrementAndGet();
        int totalCount = totalSessions.incrementAndGet();

        String sessionId = se.getSession().getId();

        LOGGER.info("Session created: " + sessionId +
                " | Active sessions: " + activeCount +
                " | Total sessions: " + totalCount);

        // Set session attributes
        se.getSession().setAttribute("sessionCreated", System.currentTimeMillis());

        // Store session statistics in servlet context
        se.getSession().getServletContext().setAttribute("activeSessions", activeCount);
        se.getSession().getServletContext().setAttribute("totalSessions", totalCount);
    }

    /**
     * Called when a session is destroyed
     */
    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        int activeCount = activeSessions.decrementAndGet();

        String sessionId = se.getSession().getId();
        Long sessionCreated = (Long) se.getSession().getAttribute("sessionCreated");
        Integer userId = (Integer) se.getSession().getAttribute("userId");
        String userEmail = (String) se.getSession().getAttribute("userEmail");

        if (sessionCreated != null) {
            long sessionDuration = System.currentTimeMillis() - sessionCreated;
            LOGGER.info("Session destroyed: " + sessionId +
                    " | Duration: " + formatDuration(sessionDuration) +
                    " | User: " + (userEmail != null ? userEmail : "anonymous") +
                    " | Active sessions: " + activeCount);
        } else {
            LOGGER.info("Session destroyed: " + sessionId +
                    " | Active sessions: " + activeCount);
        }

        // Update session statistics in servlet context
        se.getSession().getServletContext().setAttribute("activeSessions", activeCount);
    }

    /**
     * Called when an attribute is added to a session
     */
    @Override
    public void attributeAdded(HttpSessionBindingEvent se) {
        String attributeName = se.getName();
        Object attributeValue = se.getValue();

        // Log important session attributes
        if ("userId".equals(attributeName)) {
            LOGGER.info("User logged in - Session: " + se.getSession().getId() +
                    " | UserID: " + attributeValue);
        } else if ("userEmail".equals(attributeName)) {
            LOGGER.info("User email set - Session: " + se.getSession().getId() +
                    " | Email: " + attributeValue);
        }
    }

    /**
     * Called when an attribute is removed from a session
     */
    @Override
    public void attributeRemoved(HttpSessionBindingEvent se) {
        String attributeName = se.getName();
        Object attributeValue = se.getValue();

        // Log important session attribute removals
        if ("userId".equals(attributeName)) {
            LOGGER.info("User logged out - Session: " + se.getSession().getId() +
                    " | UserID: " + attributeValue);
        }
    }

    /**
     * Called when an attribute is replaced in a session
     */
    @Override
    public void attributeReplaced(HttpSessionBindingEvent se) {
        String attributeName = se.getName();
        Object oldValue = se.getValue();
        Object newValue = se.getSession().getAttribute(attributeName);

        // Log important session attribute changes
        if ("userId".equals(attributeName)) {
            LOGGER.info("User changed - Session: " + se.getSession().getId() +
                    " | Old UserID: " + oldValue +
                    " | New UserID: " + newValue);
        }
    }

    /**
     * Gets the current number of active sessions
     *
     * @return Number of active sessions
     */
    public static int getActiveSessionCount() {
        return activeSessions.get();
    }

    /**
     * Gets the total number of sessions created
     *
     * @return Total number of sessions
     */
    public static int getTotalSessionCount() {
        return totalSessions.get();
    }

    /**
     * Formats duration in a human-readable format
     *
     * @param durationMillis Duration in milliseconds
     * @return Formatted duration string
     */
    private String formatDuration(long durationMillis) {
        long seconds = durationMillis / 1000;
        long minutes = seconds / 60;
        long hours = minutes / 60;

        if (hours > 0) {
            return String.format("%d hours, %d minutes", hours, minutes % 60);
        } else if (minutes > 0) {
            return String.format("%d minutes, %d seconds", minutes, seconds % 60);
        } else {
            return String.format("%d seconds", seconds);
        }
    }
}