package com.forum.servlet;

import com.forum.service.ForumService;
import com.forum.service.UserService;
import com.forum.model.Topic;
import com.forum.model.Comment;
import com.forum.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

/**
 * Servlet for handling forum-related HTTP requests
 * Manages topics, comments, and forum navigation
 *
 * @author Simphiwe Radebe
 * @version 1.0
 * @since 2025-06-03
 */

public class ForumServlet extends HttpServlet {

    /** Serial version UID for serialization */
    private static final long serialVersionUID = 1L;

    /** Logger instance for servlet operations */
    private static final Logger LOGGER = Logger.getLogger(ForumServlet.class.getName());

    /** Forum service for business logic */
    private ForumService forumService;

    /** User service for user operations */
    private UserService userService;

    /**
     * Initializes the servlet and services
     */
    @Override
    public void init() throws ServletException {
        super.init();
        forumService = new ForumService();
        userService = new UserService();
        LOGGER.info("ForumServlet initialized successfully");
    }

    /**
     * Handles GET requests for forum operations
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                handleForumIndex(request, response);
            } else {
                switch (pathInfo) {
                    case "/create-topic":
                        handleCreateTopicPage(request, response);
                        break;
                    case "/my-topics":
                        handleMyTopics(request, response);
                        break;
                    case "/search":
                        handleSearch(request, response);
                        break;
                    default:
                        if (pathInfo.startsWith("/topic/")) {
                            handleTopicView(request, response);
                        } else {
                            response.sendError(HttpServletResponse.SC_NOT_FOUND);
                        }
                }
            }
        } catch (Exception e) {
            LOGGER.severe("Error handling GET request: " + e.getMessage());
            request.setAttribute("error", "An error occurred while processing your request");
            request.getRequestDispatcher("/WEB-INF/jsp/error/general.jsp").forward(request, response);
        }
    }

    /**
     * Handles POST requests for forum operations
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            switch (pathInfo) {
                case "/create-topic":
                    handleCreateTopic(request, response);
                    break;
                case "/add-comment":
                    handleAddComment(request, response);
                    break;
                case "/add-reply":
                    handleAddReply(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            LOGGER.severe("Error handling POST request: " + e.getMessage());
            request.setAttribute("error", "An error occurred while processing your request");
            request.getRequestDispatcher("/WEB-INF/jsp/error/general.jsp").forward(request, response);
        }
    }

    /**
     * Handles forum index page display
     */
    private void handleForumIndex(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get all topics
        List<Topic> topics = forumService.getAllTopics();
        request.setAttribute("topics", topics);

        // Get basic statistics
        request.setAttribute("totalTopics", topics.size());
        request.setAttribute("totalUsers", userService.getAllUsers().size());

        request.getRequestDispatcher("/WEB-INF/jsp/forum-index.jsp").forward(request, response);
    }

    /**
     * Handles topic creation page display
     */
    private void handleCreateTopicPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        Integer userId = getUserIdFromSession(request);
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/user/login?redirectTo=" +
                    request.getRequestURI());
            return;
        }

        request.getRequestDispatcher("/WEB-INF/jsp/create-topic.jsp").forward(request, response);
    }

    /**
     * Handles topic creation processing
     */
    private void handleCreateTopic(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        Integer userId = getUserIdFromSession(request);
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }

        String title = request.getParameter("title");
        String description = request.getParameter("description");

        // Validate input
        String validationError = forumService.validateTopicData(title, description, userId);
        if (validationError != null) {
            request.setAttribute("error", validationError);
            request.setAttribute("title", title);
            request.setAttribute("description", description);
            request.getRequestDispatcher("/WEB-INF/jsp/create-topic.jsp").forward(request, response);
            return;
        }

        // Create topic
        Topic topic = forumService.createTopic(title, description, userId);

        if (topic != null) {
            response.sendRedirect(request.getContextPath() + "/forum/topic/" + topic.getTopicId());
        } else {
            request.setAttribute("error", "Failed to create topic. Please try again.");
            request.setAttribute("title", title);
            request.setAttribute("description", description);
            request.getRequestDispatcher("/WEB-INF/jsp/create-topic.jsp").forward(request, response);
        }
    }

    /**
     * Handles topic view with comments
     */
    private void handleTopicView(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        String topicIdStr = pathInfo.substring("/topic/".length());

        try {
            int topicId = Integer.parseInt(topicIdStr);

            // Get topic with comments
            Topic topic = forumService.getTopicWithComments(topicId);
            if (topic == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            // Get comments for topic
            List<Comment> comments = forumService.getCommentsForTopic(topicId);

            request.setAttribute("topic", topic);
            request.setAttribute("comments", comments);
            request.getRequestDispatcher("/WEB-INF/jsp/topic-view.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    /**
     * Handles user's topics display
     */
    private void handleMyTopics(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        Integer userId = getUserIdFromSession(request);
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }

        // Get user's topics
        List<Topic> topics = forumService.getTopicsByUser(userId);
        request.setAttribute("topics", topics);

        request.getRequestDispatcher("/WEB-INF/jsp/my-topics.jsp").forward(request, response);
    }

    /**
     * Handles search functionality
     */
    private void handleSearch(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String searchTerm = request.getParameter("q");

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            List<Topic> topics = forumService.searchTopics(searchTerm);
            request.setAttribute("topics", topics);
            request.setAttribute("searchTerm", searchTerm);
        }

        request.getRequestDispatcher("/WEB-INF/jsp/search-results.jsp").forward(request, response);
    }

    /**
     * Handles comment addition
     */
    private void handleAddComment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        Integer userId = getUserIdFromSession(request);
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }

        String topicIdStr = request.getParameter("topicId");
        String commentText = request.getParameter("commentText");

        try {
            int topicId = Integer.parseInt(topicIdStr);

            // Validate input
            String validationError = forumService.validateCommentData(commentText, userId, topicId);
            if (validationError != null) {
                request.setAttribute("error", validationError);
                // Redirect back to topic view
                response.sendRedirect(request.getContextPath() + "/forum/topic/" + topicId + "?error=" + validationError);
                return;
            }

            // Create comment
            Comment comment = forumService.createComment(topicId, userId, commentText);

            if (comment != null) {
                response.sendRedirect(request.getContextPath() + "/forum/topic/" + topicId + "#comment-" + comment.getCommentId());
            } else {
                response.sendRedirect(request.getContextPath() + "/forum/topic/" + topicId + "?error=Failed to post comment");
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    /**
     * Handles reply addition
     */
    private void handleAddReply(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        Integer userId = getUserIdFromSession(request);
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }

        String commentIdStr = request.getParameter("commentId");
        String topicIdStr = request.getParameter("topicId");
        String replyText = request.getParameter("replyText");

        try {
            int commentId = Integer.parseInt(commentIdStr);
            int topicId = Integer.parseInt(topicIdStr);

            // Validate input
            String validationError = forumService.validateReplyData(replyText, userId, commentId);
            if (validationError != null) {
                response.sendRedirect(request.getContextPath() + "/forum/topic/" + topicId + "?error=" + validationError);
                return;
            }

            // Create reply
            var reply = forumService.createReply(commentId, userId, replyText);

            if (reply != null) {
                response.sendRedirect(request.getContextPath() + "/forum/topic/" + topicId + "#reply-" + reply.getReplyId());
            } else {
                response.sendRedirect(request.getContextPath() + "/forum/topic/" + topicId + "?error=Failed to post reply");
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    /**
     * Gets user ID from session
     */
    private Integer getUserIdFromSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (Integer) session.getAttribute("userId");
        }
        return null;
    }
}