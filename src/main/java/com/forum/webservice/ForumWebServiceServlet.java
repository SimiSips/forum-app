package com.forum.webservice;

import com.forum.service.ForumService;
import com.forum.service.UserService;
import com.forum.model.Topic;
import com.forum.model.Comment;
import com.forum.model.User;
import org.json.JSONObject;
import org.json.JSONArray;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.BufferedReader;
import java.util.List;
import java.util.logging.Logger;

/**
 * RESTful Web Service Servlet for Forum Application
 * Provides API endpoints for external integration
 *
 * @author Simphiwe Radebe
 * @version 1.0
 * @since 2025-06-03
 */

public class ForumWebServiceServlet extends HttpServlet {

    /** Serial version UID for serialization */
    private static final long serialVersionUID = 1L;

    /** Logger instance for web service operations */
    private static final Logger LOGGER = Logger.getLogger(ForumWebServiceServlet.class.getName());

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
        LOGGER.info("ForumWebServiceServlet initialized successfully");
    }

    /**
     * Handles GET requests for API endpoints
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo == null) {
                sendApiInfo(response);
                return;
            }

            String[] pathParts = pathInfo.split("/");

            if (pathParts.length < 2) {
                sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid API endpoint");
                return;
            }

            String resource = pathParts[1];

            switch (resource) {
                case "topics":
                    handleTopicsGet(request, response, pathParts);
                    break;
                case "comments":
                    handleCommentsGet(request, response, pathParts);
                    break;
                case "users":
                    handleUsersGet(request, response, pathParts);
                    break;
                case "health":
                    sendHealthCheck(response);
                    break;
                default:
                    sendError(response, HttpServletResponse.SC_NOT_FOUND, "Resource not found");
            }

        } catch (Exception e) {
            LOGGER.severe("Error handling GET request: " + e.getMessage());
            sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal server error");
        }
    }

    /**
     * Handles POST requests for API endpoints
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo == null) {
                sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid API endpoint");
                return;
            }

            String[] pathParts = pathInfo.split("/");

            if (pathParts.length < 2) {
                sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid API endpoint");
                return;
            }

            String resource = pathParts[1];

            switch (resource) {
                case "topics":
                    handleTopicsPost(request, response);
                    break;
                case "comments":
                    handleCommentsPost(request, response);
                    break;
                case "users":
                    handleUsersPost(request, response);
                    break;
                default:
                    sendError(response, HttpServletResponse.SC_NOT_FOUND, "Resource not found");
            }

        } catch (Exception e) {
            LOGGER.severe("Error handling POST request: " + e.getMessage());
            sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal server error");
        }
    }

    /**
     * Handles GET requests for topics
     */
    private void handleTopicsGet(HttpServletRequest request, HttpServletResponse response, String[] pathParts)
            throws IOException {

        if (pathParts.length == 2) {
            // GET /api/topics - Get all topics
            List<Topic> topics = forumService.getAllTopics();
            JSONArray jsonArray = new JSONArray();

            for (Topic topic : topics) {
                jsonArray.put(topicToJson(topic));
            }

            response.getWriter().write(jsonArray.toString());

        } else if (pathParts.length == 3) {
            // GET /api/topics/{id} - Get specific topic
            try {
                int topicId = Integer.parseInt(pathParts[2]);
                Topic topic = forumService.getTopicWithComments(topicId);

                if (topic != null) {
                    response.getWriter().write(topicToJson(topic).toString());
                } else {
                    sendError(response, HttpServletResponse.SC_NOT_FOUND, "Topic not found");
                }

            } catch (NumberFormatException e) {
                sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid topic ID");
            }
        } else {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid endpoint");
        }
    }

    /**
     * Handles POST requests for topics
     */
    private void handleTopicsPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String jsonString = getRequestBody(request);

        try {
            JSONObject jsonObject = new JSONObject(jsonString);

            String title = jsonObject.optString("title");
            String description = jsonObject.optString("description");
            int userId = jsonObject.optInt("userId");

            // Validate input
            String validationError = forumService.validateTopicData(title, description, userId);
            if (validationError != null) {
                sendError(response, HttpServletResponse.SC_BAD_REQUEST, validationError);
                return;
            }

            // Create topic
            Topic topic = forumService.createTopic(title, description, userId);

            if (topic != null) {
                response.setStatus(HttpServletResponse.SC_CREATED);
                response.getWriter().write(topicToJson(topic).toString());
            } else {
                sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to create topic");
            }

        } catch (Exception e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid JSON data");
        }
    }

    /**
     * Handles GET requests for comments
     */
    private void handleCommentsGet(HttpServletRequest request, HttpServletResponse response, String[] pathParts)
            throws IOException {

        String topicIdParam = request.getParameter("topicId");

        if (topicIdParam != null) {
            // GET /api/comments?topicId={id} - Get comments for topic
            try {
                int topicId = Integer.parseInt(topicIdParam);
                List<Comment> comments = forumService.getCommentsForTopic(topicId);
                JSONArray jsonArray = new JSONArray();

                for (Comment comment : comments) {
                    jsonArray.put(commentToJson(comment));
                }

                response.getWriter().write(jsonArray.toString());

            } catch (NumberFormatException e) {
                sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid topic ID");
            }
        } else {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Missing topicId parameter");
        }
    }

    /**
     * Handles POST requests for comments
     */
    private void handleCommentsPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String jsonString = getRequestBody(request);

        try {
            JSONObject jsonObject = new JSONObject(jsonString);

            int topicId = jsonObject.optInt("topicId");
            int userId = jsonObject.optInt("userId");
            String commentText = jsonObject.optString("commentText");

            // Validate input
            String validationError = forumService.validateCommentData(commentText, userId, topicId);
            if (validationError != null) {
                sendError(response, HttpServletResponse.SC_BAD_REQUEST, validationError);
                return;
            }

            // Create comment
            Comment comment = forumService.createComment(topicId, userId, commentText);

            if (comment != null) {
                response.setStatus(HttpServletResponse.SC_CREATED);
                response.getWriter().write(commentToJson(comment).toString());
            } else {
                sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to create comment");
            }

        } catch (Exception e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid JSON data");
        }
    }

    /**
     * Handles GET requests for users
     */
    private void handleUsersGet(HttpServletRequest request, HttpServletResponse response, String[] pathParts)
            throws IOException {

        if (pathParts.length == 2) {
            // GET /api/users - Get all users (limited info for security)
            List<User> users = userService.getAllUsers();
            JSONArray jsonArray = new JSONArray();

            for (User user : users) {
                JSONObject userJson = new JSONObject();
                userJson.put("userId", user.getUserId());
                userJson.put("firstName", user.getFirstName());
                userJson.put("lastName", user.getLastName());
                userJson.put("dateRegistered", user.getDateRegistered());
                jsonArray.put(userJson);
            }

            response.getWriter().write(jsonArray.toString());

        } else if (pathParts.length == 3) {
            // GET /api/users/{id} - Get specific user
            try {
                int userId = Integer.parseInt(pathParts[2]);
                User user = userService.getUserById(userId);

                if (user != null) {
                    JSONObject userJson = new JSONObject();
                    userJson.put("userId", user.getUserId());
                    userJson.put("firstName", user.getFirstName());
                    userJson.put("lastName", user.getLastName());
                    userJson.put("dateRegistered", user.getDateRegistered());

                    response.getWriter().write(userJson.toString());
                } else {
                    sendError(response, HttpServletResponse.SC_NOT_FOUND, "User not found");
                }

            } catch (NumberFormatException e) {
                sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID");
            }
        } else {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid endpoint");
        }
    }

    /**
     * Handles POST requests for users
     */
    private void handleUsersPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String jsonString = getRequestBody(request);

        try {
            JSONObject jsonObject = new JSONObject(jsonString);

            String email = jsonObject.optString("email");
            String password = jsonObject.optString("password");
            String firstName = jsonObject.optString("firstName");
            String lastName = jsonObject.optString("lastName");
            String phone = jsonObject.optString("phone");

            // Validate input
            String validationError = userService.validateRegistrationData(email, password, firstName, lastName, phone);
            if (validationError != null) {
                sendError(response, HttpServletResponse.SC_BAD_REQUEST, validationError);
                return;
            }

            // Create user
            User user = userService.registerUser(email, password, firstName, lastName, phone);

            if (user != null) {
                JSONObject userJson = new JSONObject();
                userJson.put("userId", user.getUserId());
                userJson.put("email", user.getEmail());
                userJson.put("firstName", user.getFirstName());
                userJson.put("lastName", user.getLastName());
                userJson.put("dateRegistered", user.getDateRegistered());

                response.setStatus(HttpServletResponse.SC_CREATED);
                response.getWriter().write(userJson.toString());
            } else {
                sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to create user");
            }

        } catch (Exception e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid JSON data");
        }
    }

    /**
     * Sends API information
     */
    private void sendApiInfo(HttpServletResponse response) throws IOException {
        JSONObject apiInfo = new JSONObject();
        apiInfo.put("name", "Forum Application API");
        apiInfo.put("version", "1.0.0");
        apiInfo.put("author", "Simphiwe Radebe");
        apiInfo.put("endpoints", new JSONArray()
                .put("/api/topics")
                .put("/api/comments")
                .put("/api/users")
                .put("/api/health"));

        response.getWriter().write(apiInfo.toString());
    }

    /**
     * Sends health check response
     */
    private void sendHealthCheck(HttpServletResponse response) throws IOException {
        JSONObject health = new JSONObject();
        health.put("status", "healthy");
        health.put("timestamp", System.currentTimeMillis());
        health.put("service", "Forum Application API");

        response.getWriter().write(health.toString());
    }

    /**
     * Sends error response
     */
    private void sendError(HttpServletResponse response, int statusCode, String message) throws IOException {
        response.setStatus(statusCode);
        JSONObject error = new JSONObject();
        error.put("error", true);
        error.put("message", message);
        error.put("statusCode", statusCode);

        response.getWriter().write(error.toString());
    }

    /**
     * Converts Topic object to JSON
     */
    private JSONObject topicToJson(Topic topic) {
        JSONObject json = new JSONObject();
        json.put("topicId", topic.getTopicId());
        json.put("title", topic.getTitle());
        json.put("description", topic.getDescription());
        json.put("userId", topic.getUserId());
        json.put("dateCreated", topic.getDateCreated());
        json.put("lastActivity", topic.getLastActivity());
        json.put("isActive", topic.isActive());

        if (topic.getUser() != null) {
            json.put("userFullName", topic.getUser().getFullName());
        }

        return json;
    }

    /**
     * Converts Comment object to JSON
     */
    private JSONObject commentToJson(Comment comment) {
        JSONObject json = new JSONObject();
        json.put("commentId", comment.getCommentId());
        json.put("topicId", comment.getTopicId());
        json.put("userId", comment.getUserId());
        json.put("commentText", comment.getCommentText());
        json.put("datePosted", comment.getDatePosted());
        json.put("isActive", comment.isActive());

        if (comment.getUser() != null) {
            json.put("userFullName", comment.getUser().getFullName());
        }

        return json;
    }

    /**
     * Gets request body as string
     */
    private String getRequestBody(HttpServletRequest request) throws IOException {
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;

        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        return sb.toString();
    }
}