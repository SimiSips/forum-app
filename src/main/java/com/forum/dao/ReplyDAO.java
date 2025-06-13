package com.forum.dao;

import com.forum.config.DatabaseConfig;
import com.forum.model.Reply;
import com.forum.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object (DAO) for Reply entity
 * Handles all database operations related to replies
 *
 * @author Simphiwe Radebe
 * @version 1.2
 * @since 2025-06-04
 */
public class ReplyDAO {

    /** Logger instance for database operations */
    private static final Logger LOGGER = Logger.getLogger(ReplyDAO.class.getName());

    /** Database configuration instance */
    private final DatabaseConfig databaseConfig;

    /**
     * Constructor to initialize ReplyDAO with database configuration
     */
    public ReplyDAO() {
        this.databaseConfig = DatabaseConfig.getInstance();
    }

    /**
     * Creates a new reply in the database
     *
     * @param reply Reply object to create
     * @return true if reply created successfully, false otherwise
     */
    public boolean createReply(Reply reply) {
        String sql = "INSERT INTO replies (comment_id, user_id, reply_text) VALUES (?, ?, ?)";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            // Set parameters
            statement.setInt(1, reply.getCommentId());
            statement.setInt(2, reply.getUserId());
            statement.setString(3, reply.getReplyText());

            // Execute insert
            int rowsAffected = statement.executeUpdate();

            // Get generated reply ID
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        reply.setReplyId(generatedKeys.getInt(1));
                        LOGGER.info("Reply created successfully with ID: " + reply.getReplyId());

                        // Update topic last activity
                        updateTopicLastActivityFromReply(reply.getCommentId());

                        return true;
                    }
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating reply for comment: " + reply.getCommentId(), e);
        }

        return false;
    }

    /**
     * Retrieves a reply by ID with user information
     *
     * @param replyId Reply ID to search for
     * @return Reply object if found, null otherwise
     */
    public Reply getReplyById(int replyId) {
        String sql = "SELECT r.*, u.first_name, u.last_name, u.email " +
                "FROM replies r " +
                "LEFT JOIN users u ON r.user_id = u.user_id " +
                "WHERE r.reply_id = ? AND r.is_active = TRUE";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, replyId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapResultSetToReply(resultSet);
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving reply by ID: " + replyId, e);
        }

        return null;
    }

    /**
     * Retrieves all replies for a specific comment with user information
     *
     * @param commentId Comment ID to get replies for
     * @return List of Reply objects
     */
    public List<Reply> getRepliesByCommentId(int commentId) {
        List<Reply> replies = new ArrayList<>();
        String sql = "SELECT r.*, u.first_name, u.last_name, u.email " +
                "FROM replies r " +
                "LEFT JOIN users u ON r.user_id = u.user_id " +
                "WHERE r.comment_id = ? AND r.is_active = TRUE " +
                "ORDER BY r.date_posted ASC";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, commentId);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    replies.add(mapResultSetToReply(resultSet));
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving replies for comment: " + commentId, e);
        }

        return replies;
    }

    /**
     * Retrieves replies posted by a specific user
     *
     * @param userId User ID to get replies for
     * @return List of Reply objects
     */
    public List<Reply> getRepliesByUserId(int userId) {
        List<Reply> replies = new ArrayList<>();
        String sql = "SELECT r.*, u.first_name, u.last_name, u.email, " +
                "c.comment_text, t.title as topic_title " +
                "FROM replies r " +
                "LEFT JOIN users u ON r.user_id = u.user_id " +
                "LEFT JOIN comments c ON r.comment_id = c.comment_id " +
                "LEFT JOIN topics t ON c.topic_id = t.topic_id " +
                "WHERE r.user_id = ? AND r.is_active = TRUE " +
                "ORDER BY r.date_posted DESC";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    replies.add(mapResultSetToReply(resultSet));
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving replies for user: " + userId, e);
        }

        return replies;
    }

    /**
     * Updates reply text in the database
     *
     * @param replyId Reply ID to update
     * @param newText New reply text
     * @param userId User ID requesting the update (must be reply owner)
     * @return true if update successful, false otherwise
     */
    public boolean updateReply(int replyId, String newText, int userId) {
        String sql = "UPDATE replies SET reply_text = ? WHERE reply_id = ? AND user_id = ?";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, newText);
            statement.setInt(2, replyId);
            statement.setInt(3, userId);

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                LOGGER.info("Reply updated successfully: " + replyId);
                return true;
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating reply: " + replyId, e);
        }

        return false;
    }

    /**
     * Deactivates a reply (soft delete)
     *
     * @param replyId Reply ID to deactivate
     * @param userId User ID requesting the deactivation (must be reply owner)
     * @return true if deactivation successful, false otherwise
     */
    public boolean deactivateReply(int replyId, int userId) {
        String sql = "UPDATE replies SET is_active = FALSE WHERE reply_id = ? AND user_id = ?";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, replyId);
            statement.setInt(2, userId);

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                LOGGER.info("Reply deactivated successfully: " + replyId);
                return true;
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deactivating reply: " + replyId, e);
        }

        return false;
    }

    /**
     * Gets the total number of replies for a comment
     *
     * @param commentId Comment ID
     * @return Number of replies
     */
    public int getReplyCountByCommentId(int commentId) {
        String sql = "SELECT COUNT(*) FROM replies WHERE comment_id = ? AND is_active = TRUE";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, commentId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting reply count for comment: " + commentId, e);
        }

        return 0;
    }

    /**
     * Gets the total number of replies posted by a user
     *
     * @param userId User ID
     * @return Number of replies
     */
    public int getReplyCountByUserId(int userId) {
        String sql = "SELECT COUNT(*) FROM replies WHERE user_id = ? AND is_active = TRUE";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting reply count for user: " + userId, e);
        }

        return 0;
    }

    /**
     * Searches replies by text content
     *
     * @param searchTerm Search term to look for
     * @return List of matching Reply objects
     */
    public List<Reply> searchReplies(String searchTerm) {
        List<Reply> replies = new ArrayList<>();
        String sql = "SELECT r.*, u.first_name, u.last_name, u.email, " +
                "c.comment_text, t.title as topic_title " +
                "FROM replies r " +
                "LEFT JOIN users u ON r.user_id = u.user_id " +
                "LEFT JOIN comments c ON r.comment_id = c.comment_id " +
                "LEFT JOIN topics t ON c.topic_id = t.topic_id " +
                "WHERE r.reply_text LIKE ? AND r.is_active = TRUE " +
                "ORDER BY r.date_posted DESC";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            String searchPattern = "%" + searchTerm + "%";
            statement.setString(1, searchPattern);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    replies.add(mapResultSetToReply(resultSet));
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error searching replies with term: " + searchTerm, e);
        }

        return replies;
    }

    /**
     * Gets recent replies across all comments
     *
     * @param limit Maximum number of replies to retrieve
     * @return List of recent Reply objects
     */
    public List<Reply> getRecentReplies(int limit) {
        List<Reply> replies = new ArrayList<>();
        String sql = "SELECT r.*, u.first_name, u.last_name, u.email, " +
                "c.comment_text, t.title as topic_title " +
                "FROM replies r " +
                "LEFT JOIN users u ON r.user_id = u.user_id " +
                "LEFT JOIN comments c ON r.comment_id = c.comment_id " +
                "LEFT JOIN topics t ON c.topic_id = t.topic_id " +
                "WHERE r.is_active = TRUE AND c.is_active = TRUE AND t.is_active = TRUE " +
                "ORDER BY r.date_posted DESC " +
                "LIMIT ?";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, limit);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    replies.add(mapResultSetToReply(resultSet));
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving recent replies", e);
        }

        return replies;
    }

    /**
     * Updates the last activity timestamp for a topic when a reply is added
     *
     * @param commentId Comment ID to get topic from
     */
    private void updateTopicLastActivityFromReply(int commentId) {
        String sql = "UPDATE topics t " +
                "JOIN comments c ON t.topic_id = c.topic_id " +
                "SET t.last_activity = CURRENT_TIMESTAMP " +
                "WHERE c.comment_id = ?";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, commentId);
            statement.executeUpdate();

        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "Error updating topic last activity from reply", e);
        }
    }

    /**
     * Maps ResultSet to Reply object with User information
     *
     * @param resultSet ResultSet from database query
     * @return Reply object
     * @throws SQLException if error occurs during mapping
     */
    private Reply mapResultSetToReply(ResultSet resultSet) throws SQLException {
        Reply reply = new Reply();

        reply.setReplyId(resultSet.getInt("reply_id"));
        reply.setCommentId(resultSet.getInt("comment_id"));
        reply.setUserId(resultSet.getInt("user_id"));
        reply.setReplyText(resultSet.getString("reply_text"));
        reply.setDatePosted(resultSet.getTimestamp("date_posted"));
        reply.setActive(resultSet.getBoolean("is_active"));

        // Create and set user object if user data is available
        String firstName = resultSet.getString("first_name");
        if (firstName != null) {
            User user = new User();
            user.setUserId(resultSet.getInt("user_id"));
            user.setFirstName(firstName);
            user.setLastName(resultSet.getString("last_name"));
            user.setEmail(resultSet.getString("email"));
            reply.setUser(user);
        }

        return reply;
    }
}