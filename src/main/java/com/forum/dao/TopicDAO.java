package com.forum.dao;

import com.forum.config.DatabaseConfig;
import com.forum.model.Topic;
import com.forum.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object (DAO) for Topic entity
 * Handles all database operations related to topics
 *
 * @author Simphiwe Radebe
 * @version 1.0
 * @since 2025-06-03
 */
public class TopicDAO {

    /** Logger instance for database operations */
    private static final Logger LOGGER = Logger.getLogger(TopicDAO.class.getName());

    /** Database configuration instance */
    private final DatabaseConfig databaseConfig;

    /** User DAO for user-related operations */
    private final UserDAO userDAO;

    /**
     * Constructor to initialize TopicDAO with database configuration
     */
    public TopicDAO() {
        this.databaseConfig = DatabaseConfig.getInstance();
        this.userDAO = new UserDAO();
    }

    /**
     * Creates a new topic in the database
     *
     * @param topic Topic object to create
     * @return true if topic created successfully, false otherwise
     */
    public boolean createTopic(Topic topic) {
        String sql = "INSERT INTO topics (title, description, user_id) VALUES (?, ?, ?)";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            // Set parameters
            statement.setString(1, topic.getTitle());
            statement.setString(2, topic.getDescription());
            statement.setInt(3, topic.getUserId());

            // Execute insert
            int rowsAffected = statement.executeUpdate();

            // Get generated topic ID
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        topic.setTopicId(generatedKeys.getInt(1));
                        LOGGER.info("Topic created successfully with ID: " + topic.getTopicId());
                        return true;
                    }
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating topic: " + topic.getTitle(), e);
        }

        return false;
    }

    /**
     * Retrieves a topic by ID with user information
     *
     * @param topicId Topic ID to search for
     * @return Topic object if found, null otherwise
     */
    public Topic getTopicById(int topicId) {
        String sql = "SELECT t.*, u.first_name, u.last_name, u.email " +
                "FROM topics t " +
                "LEFT JOIN users u ON t.user_id = u.user_id " +
                "WHERE t.topic_id = ? AND t.is_active = TRUE";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, topicId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapResultSetToTopic(resultSet);
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving topic by ID: " + topicId, e);
        }

        return null;
    }

    /**
     * Retrieves all active topics with user information and comment counts
     *
     * @return List of Topic objects
     */
    public List<Topic> getAllTopics() {
        List<Topic> topics = new ArrayList<>();
        String sql = "SELECT t.*, u.first_name, u.last_name, u.email, " +
                "COUNT(c.comment_id) as comment_count " +
                "FROM topics t " +
                "LEFT JOIN users u ON t.user_id = u.user_id " +
                "LEFT JOIN comments c ON t.topic_id = c.topic_id AND c.is_active = TRUE " +
                "WHERE t.is_active = TRUE " +
                "GROUP BY t.topic_id " +
                "ORDER BY t.last_activity DESC";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Topic topic = mapResultSetToTopic(resultSet);
                topic.setCommentCount(resultSet.getInt("comment_count"));
                topics.add(topic);
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving all topics", e);
        }

        return topics;
    }

    /**
     * Retrieves topics created by a specific user
     *
     * @param userId User ID to search for
     * @return List of Topic objects created by the user
     */
    public List<Topic> getTopicsByUserId(int userId) {
        List<Topic> topics = new ArrayList<>();
        String sql = "SELECT t.*, u.first_name, u.last_name, u.email, " +
                "COUNT(c.comment_id) as comment_count " +
                "FROM topics t " +
                "LEFT JOIN users u ON t.user_id = u.user_id " +
                "LEFT JOIN comments c ON t.topic_id = c.topic_id AND c.is_active = TRUE " +
                "WHERE t.user_id = ? AND t.is_active = TRUE " +
                "GROUP BY t.topic_id " +
                "ORDER BY t.date_created DESC";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Topic topic = mapResultSetToTopic(resultSet);
                    topic.setCommentCount(resultSet.getInt("comment_count"));
                    topics.add(topic);
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving topics for user: " + userId, e);
        }

        return topics;
    }

    /**
     * Updates topic information in the database
     *
     * @param topic Topic object with updated information
     * @return true if update successful, false otherwise
     */
    public boolean updateTopic(Topic topic) {
        String sql = "UPDATE topics SET title = ?, description = ?, last_activity = CURRENT_TIMESTAMP " +
                "WHERE topic_id = ? AND user_id = ?";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, topic.getTitle());
            statement.setString(2, topic.getDescription());
            statement.setInt(3, topic.getTopicId());
            statement.setInt(4, topic.getUserId());

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                LOGGER.info("Topic updated successfully: " + topic.getTopicId());
                return true;
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating topic: " + topic.getTopicId(), e);
        }

        return false;
    }

    /**
     * Updates the last activity timestamp for a topic
     *
     * @param topicId Topic ID
     * @return true if update successful, false otherwise
     */
    public boolean updateLastActivity(int topicId) {
        String sql = "UPDATE topics SET last_activity = CURRENT_TIMESTAMP WHERE topic_id = ?";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, topicId);

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                LOGGER.info("Topic last activity updated: " + topicId);
                return true;
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating topic last activity: " + topicId, e);
        }

        return false;
    }

    /**
     * Deactivates a topic (soft delete)
     *
     * @param topicId Topic ID to deactivate
     * @param userId User ID requesting the deactivation (must be topic owner)
     * @return true if deactivation successful, false otherwise
     */
    public boolean deactivateTopic(int topicId, int userId) {
        String sql = "UPDATE topics SET is_active = FALSE WHERE topic_id = ? AND user_id = ?";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, topicId);
            statement.setInt(2, userId);

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                LOGGER.info("Topic deactivated successfully: " + topicId);
                return true;
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deactivating topic: " + topicId, e);
        }

        return false;
    }

    /**
     * Searches topics by title or description
     *
     * @param searchTerm Search term to look for
     * @return List of matching Topic objects
     */
    public List<Topic> searchTopics(String searchTerm) {
        List<Topic> topics = new ArrayList<>();
        String sql = "SELECT t.*, u.first_name, u.last_name, u.email, " +
                "COUNT(c.comment_id) as comment_count " +
                "FROM topics t " +
                "LEFT JOIN users u ON t.user_id = u.user_id " +
                "LEFT JOIN comments c ON t.topic_id = c.topic_id AND c.is_active = TRUE " +
                "WHERE (t.title LIKE ? OR t.description LIKE ?) AND t.is_active = TRUE " +
                "GROUP BY t.topic_id " +
                "ORDER BY t.last_activity DESC";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            String searchPattern = "%" + searchTerm + "%";
            statement.setString(1, searchPattern);
            statement.setString(2, searchPattern);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Topic topic = mapResultSetToTopic(resultSet);
                    topic.setCommentCount(resultSet.getInt("comment_count"));
                    topics.add(topic);
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error searching topics with term: " + searchTerm, e);
        }

        return topics;
    }

    /**
     * Gets the total number of active topics
     *
     * @return Total number of topics
     */
    public int getTotalTopicCount() {
        String sql = "SELECT COUNT(*) FROM topics WHERE is_active = TRUE";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            if (resultSet.next()) {
                return resultSet.getInt(1);
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting total topic count", e);
        }

        return 0;
    }

    /**
     * Gets topics with pagination support
     *
     * @param offset Starting position
     * @param limit Number of records to fetch
     * @return List of Topic objects
     */
    public List<Topic> getTopicsWithPagination(int offset, int limit) {
        List<Topic> topics = new ArrayList<>();
        String sql = "SELECT t.*, u.first_name, u.last_name, u.email, " +
                "COUNT(c.comment_id) as comment_count " +
                "FROM topics t " +
                "LEFT JOIN users u ON t.user_id = u.user_id " +
                "LEFT JOIN comments c ON t.topic_id = c.topic_id AND c.is_active = TRUE " +
                "WHERE t.is_active = TRUE " +
                "GROUP BY t.topic_id " +
                "ORDER BY t.last_activity DESC " +
                "LIMIT ? OFFSET ?";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, limit);
            statement.setInt(2, offset);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Topic topic = mapResultSetToTopic(resultSet);
                    topic.setCommentCount(resultSet.getInt("comment_count"));
                    topics.add(topic);
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving topics with pagination", e);
        }

        return topics;
    }

    /**
     * Maps ResultSet to Topic object with User information
     *
     * @param resultSet ResultSet from database query
     * @return Topic object
     * @throws SQLException if error occurs during mapping
     */
    private Topic mapResultSetToTopic(ResultSet resultSet) throws SQLException {
        Topic topic = new Topic();

        topic.setTopicId(resultSet.getInt("topic_id"));
        topic.setTitle(resultSet.getString("title"));
        topic.setDescription(resultSet.getString("description"));
        topic.setUserId(resultSet.getInt("user_id"));
        topic.setDateCreated(resultSet.getTimestamp("date_created"));
        topic.setLastActivity(resultSet.getTimestamp("last_activity"));
        topic.setActive(resultSet.getBoolean("is_active"));

        // Create and set user object if user data is available
        String firstName = resultSet.getString("first_name");
        if (firstName != null) {
            User user = new User();
            user.setUserId(resultSet.getInt("user_id"));
            user.setFirstName(firstName);
            user.setLastName(resultSet.getString("last_name"));
            user.setEmail(resultSet.getString("email"));
            topic.setUser(user);
        }

        return topic;
    }
}