package com.forum.webservice;

import com.forum.service.ForumService;
import com.forum.model.Topic;
import org.json.JSONObject;
import org.json.JSONArray;

import java.util.List;
import java.util.logging.Logger;

/**
 * Web Service class for Topic-related operations
 * Provides JSON-based API for topic management
 *
 * @author Simphiwe Radebe
 * @version 1.0
 * @since 2025-06-08
 */
public class TopicWebService {

    /** Logger instance for web service operations */
    private static final Logger LOGGER = Logger.getLogger(TopicWebService.class.getName());

    /** Forum service for business logic */
    private final ForumService forumService;

    /**
     * Constructor to initialize TopicWebService
     */
    public TopicWebService() {
        this.forumService = new ForumService();
    }

    /**
     * Gets all topics as JSON
     *
     * @return JSON string containing all topics
     */
    public String getAllTopicsJson() {
        try {
            List<Topic> topics = forumService.getAllTopics();
            JSONArray jsonArray = new JSONArray();

            for (Topic topic : topics) {
                jsonArray.put(topicToJson(topic));
            }

            JSONObject response = new JSONObject();
            response.put("success", true);
            response.put("data", jsonArray);
            response.put("total", topics.size());

            LOGGER.info("Retrieved " + topics.size() + " topics via web service");
            return response.toString();

        } catch (Exception e) {
            LOGGER.severe("Error getting all topics: " + e.getMessage());
            return createErrorResponse("Failed to retrieve topics");
        }
    }

    /**
     * Gets a specific topic by ID as JSON
     *
     * @param topicId Topic ID to retrieve
     * @return JSON string containing topic data
     */
    public String getTopicByIdJson(int topicId) {
        try {
            Topic topic = forumService.getTopicWithComments(topicId);

            if (topic != null) {
                JSONObject response = new JSONObject();
                response.put("success", true);
                response.put("data", topicToJson(topic));

                LOGGER.info("Retrieved topic " + topicId + " via web service");
                return response.toString();
            } else {
                return createErrorResponse("Topic not found");
            }

        } catch (Exception e) {
            LOGGER.severe("Error getting topic " + topicId + ": " + e.getMessage());
            return createErrorResponse("Failed to retrieve topic");
        }
    }

    /**
     * Creates a new topic via JSON
     *
     * @param jsonData JSON string containing topic data
     * @return JSON response string
     */
    public String createTopicJson(String jsonData) {
        try {
            JSONObject jsonObject = new JSONObject(jsonData);

            String title = jsonObject.optString("title");
            String description = jsonObject.optString("description");
            int userId = jsonObject.optInt("userId");

            // Validate input
            String validationError = forumService.validateTopicData(title, description, userId);
            if (validationError != null) {
                return createErrorResponse(validationError);
            }

            // Create topic
            Topic topic = forumService.createTopic(title, description, userId);

            if (topic != null) {
                JSONObject response = new JSONObject();
                response.put("success", true);
                response.put("message", "Topic created successfully");
                response.put("data", topicToJson(topic));

                LOGGER.info("Created topic via web service: " + topic.getTopicId());
                return response.toString();
            } else {
                return createErrorResponse("Failed to create topic");
            }

        } catch (Exception e) {
            LOGGER.severe("Error creating topic: " + e.getMessage());
            return createErrorResponse("Invalid topic data");
        }
    }

    /**
     * Updates a topic via JSON
     *
     * @param topicId Topic ID to update
     * @param jsonData JSON string containing updated topic data
     * @return JSON response string
     */
    public String updateTopicJson(int topicId, String jsonData) {
        try {
            JSONObject jsonObject = new JSONObject(jsonData);

            String title = jsonObject.optString("title");
            String description = jsonObject.optString("description");
            int userId = jsonObject.optInt("userId");

            // Validate input
            String validationError = forumService.validateTopicData(title, description, userId);
            if (validationError != null) {
                return createErrorResponse(validationError);
            }

            // Update topic
            boolean success = forumService.updateTopic(topicId, title, description, userId);

            if (success) {
                JSONObject response = new JSONObject();
                response.put("success", true);
                response.put("message", "Topic updated successfully");

                LOGGER.info("Updated topic via web service: " + topicId);
                return response.toString();
            } else {
                return createErrorResponse("Failed to update topic or unauthorized");
            }

        } catch (Exception e) {
            LOGGER.severe("Error updating topic " + topicId + ": " + e.getMessage());
            return createErrorResponse("Invalid topic data");
        }
    }

    /**
     * Searches topics by keyword
     *
     * @param searchTerm Search keyword
     * @return JSON string containing search results
     */
    public String searchTopicsJson(String searchTerm) {
        try {
            List<Topic> topics = forumService.searchTopics(searchTerm);
            JSONArray jsonArray = new JSONArray();

            for (Topic topic : topics) {
                jsonArray.put(topicToJson(topic));
            }

            JSONObject response = new JSONObject();
            response.put("success", true);
            response.put("data", jsonArray);
            response.put("total", topics.size());
            response.put("searchTerm", searchTerm);

            LOGGER.info("Search returned " + topics.size() + " topics for term: " + searchTerm);
            return response.toString();

        } catch (Exception e) {
            LOGGER.severe("Error searching topics: " + e.getMessage());
            return createErrorResponse("Search failed");
        }
    }

    /**
     * Gets topics by user ID
     *
     * @param userId User ID
     * @return JSON string containing user's topics
     */
    public String getTopicsByUserJson(int userId) {
        try {
            List<Topic> topics = forumService.getTopicsByUser(userId);
            JSONArray jsonArray = new JSONArray();

            for (Topic topic : topics) {
                jsonArray.put(topicToJson(topic));
            }

            JSONObject response = new JSONObject();
            response.put("success", true);
            response.put("data", jsonArray);
            response.put("total", topics.size());
            response.put("userId", userId);

            LOGGER.info("Retrieved " + topics.size() + " topics for user: " + userId);
            return response.toString();

        } catch (Exception e) {
            LOGGER.severe("Error getting topics for user " + userId + ": " + e.getMessage());
            return createErrorResponse("Failed to retrieve user topics");
        }
    }

    /**
     * Gets topic statistics
     *
     * @return JSON string containing topic statistics
     */
    public String getTopicStatisticsJson() {
        try {
            List<Topic> allTopics = forumService.getAllTopics();

            JSONObject stats = new JSONObject();
            stats.put("totalTopics", allTopics.size());
            stats.put("activeTopics", allTopics.stream().mapToInt(t -> t.isActive() ? 1 : 0).sum());

            // Calculate average comments per topic
            int totalComments = allTopics.stream().mapToInt(Topic::getCommentCount).sum();
            double avgComments = allTopics.isEmpty() ? 0 : (double) totalComments / allTopics.size();
            stats.put("averageCommentsPerTopic", Math.round(avgComments * 100.0) / 100.0);

            JSONObject response = new JSONObject();
            response.put("success", true);
            response.put("data", stats);

            LOGGER.info("Generated topic statistics via web service");
            return response.toString();

        } catch (Exception e) {
            LOGGER.severe("Error generating topic statistics: " + e.getMessage());
            return createErrorResponse("Failed to generate statistics");
        }
    }

    /**
     * Converts Topic object to JSON
     *
     * @param topic Topic object to convert
     * @return JSONObject representation of the topic
     */
    private JSONObject topicToJson(Topic topic) {
        JSONObject json = new JSONObject();

        json.put("topicId", topic.getTopicId());
        json.put("title", topic.getTitle());
        json.put("description", topic.getDescription());
        json.put("userId", topic.getUserId());
        json.put("dateCreated", topic.getDateCreated() != null ? topic.getDateCreated().toString() : null);
        json.put("lastActivity", topic.getLastActivity() != null ? topic.getLastActivity().toString() : null);
        json.put("isActive", topic.isActive());
        json.put("commentCount", topic.getCommentCount());

        // Add user information if available
        if (topic.getUser() != null) {
            JSONObject userJson = new JSONObject();
            userJson.put("userId", topic.getUser().getUserId());
            userJson.put("fullName", topic.getUser().getFullName());
            userJson.put("firstName", topic.getUser().getFirstName());
            userJson.put("lastName", topic.getUser().getLastName());
            json.put("user", userJson);
        }

        return json;
    }

    /**
     * Creates a standardized error response
     *
     * @param message Error message
     * @return JSON error response string
     */
    private String createErrorResponse(String message) {
        JSONObject error = new JSONObject();
        error.put("success", false);
        error.put("error", true);
        error.put("message", message);
        error.put("timestamp", System.currentTimeMillis());

        return error.toString();
    }

    /**
     * Validates topic data for web service operations
     *
     * @param title Topic title
     * @param description Topic description
     * @param userId User ID
     * @return Validation error message or null if valid
     */
    public String validateTopicData(String title, String description, int userId) {
        return forumService.validateTopicData(title, description, userId);
    }
}