package com.forum.dao;

import com.forum.config.DatabaseConfig;
import com.forum.model.Comment;
import com.forum.model.User;
import com.forum.model.Reply;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object (DAO) for Comment entity
 * Handles all database operations related to comments
 *
 * @author Simphiwe Radebe
 * @version 1.0
 * @since 2025-06-03
 */
public class CommentDAO {

    /** Logger instance for database operations */
    private static final Logger LOGGER = Logger.getLogger(CommentDAO.class.getName());

    /** Database configuration instance */
    private final DatabaseConfig databaseConfig;

    /** Reply DAO for reply-related operations */
    private final ReplyDAO replyDAO;

    /**
     * Constructor to initialize CommentDAO with database configuration
     */
    public CommentDAO() {
        this.databaseConfig = DatabaseConfig.getInstance();
        this.replyDAO = new ReplyDAO();
    }

    /**
     * Creates a new comment in the database
     *
     * @param comment Comment object to create
     * @return true if comment created successfully, false otherwise
     */
    public boolean createComment(Comment comment) {
        String sql = "INSERT INTO comments (topic_id, user_id, comment_text) VALUES (?, ?, ?)";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            // Set parameters
            statement.setInt(1, comment.getTopicId());
            statement.setInt(2, comment.getUserId());
            statement.setString(3, comment.getCommentText());

            // Execute insert
            int rowsAffected = statement.executeUpdate();

            // Get generated comment ID
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        comment.setCommentId(generatedKeys.getInt(1));
                        LOGGER.info("Comment created successfully with ID: " + comment.getCommentId());

                        // Update topic last activity
                        updateTopicLastActivity(comment.getTopicId());

                        return true;
                    }
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating comment for topic: " + comment.getTopicId(), e);
        }

        return false;
    }

    /**
     * Retrieves a comment by ID with user information
     *
     * @param commentId Comment ID to search for
     * @return Comment object if found, null otherwise
     */
    public Comment getCommentById(int commentId) {
        String sql = "SELECT c.*, u.first_name, u.last_name, u.email " +
                "FROM comments c " +
                "LEFT JOIN users u ON c.user_id = u.user_id " +
                "WHERE c.comment_id = ? AND c.is_active = TRUE";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, commentId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    Comment comment = mapResultSetToComment(resultSet);
                    // Load replies for this comment
                    comment.setReplies(replyDAO.getRepliesByCommentId(commentId));
                    return comment;
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving comment by ID: " + commentId, e);
        }

        return null;
    }

    /**
     * Retrieves all comments for a specific topic with user information and replies
     *
     * @param topicId Topic ID to get comments for
     * @return List of Comment objects
     */
    public List<Comment> getCommentsByTopicId(int topicId) {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT c.*, u.first_name, u.last_name, u.email " +
                "FROM comments c " +
                "LEFT JOIN users u ON c.user_id = u.user_id " +
                "WHERE c.topic_id = ? AND c.is_active = TRUE " +
                "ORDER BY c.date_posted ASC";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, topicId);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Comment comment = mapResultSetToComment(resultSet);
                    // Load replies for each comment
                    comment.setReplies(replyDAO.getRepliesByCommentId(comment.getCommentId()));
                    comments.add(comment);
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving comments for topic: " + topicId, e);
        }

        return comments;
    }

    /**
     * Retrieves comments posted by a specific user
     *
     * @param userId User ID to get comments for
     * @return List of Comment objects
     */
    public List<Comment> getCommentsByUserId(int userId) {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT c.*, u.first_name, u.last_name, u.email, " +
                "t.title as topic_title " +
                "FROM comments c " +
                "LEFT JOIN users u ON c.user_id = u.user_id " +
                "LEFT JOIN topics t ON c.topic_id = t.topic_id " +
                "WHERE c.user_id = ? AND c.is_active = TRUE " +
                "ORDER BY c.date_posted DESC";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Comment comment = mapResultSetToComment(resultSet);
                    // Load replies for each comment
                    comment.setReplies(replyDAO.getRepliesByCommentId(comment.getCommentId()));
                    comments.add(comment);
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving comments for user: " + userId, e);
        }

        return comments;
    }

    /**
     * Updates comment text in the database
     *
     * @param commentId Comment ID to update
     * @param newText New comment text
     * @param userId User ID requesting the update (must be comment owner)
     * @return true if update successful, false otherwise
     */
    public boolean updateComment(int commentId, String newText, int userId) {
        String sql = "UPDATE comments SET comment_text = ? WHERE comment_id = ? AND user_id = ?";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, newText);
            statement.setInt(2, commentId);
            statement.setInt(3, userId);

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                LOGGER.info("Comment updated successfully: " + commentId);
                return true;
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating comment: " + commentId, e);
        }

        return false;
    }

    /**
     * Deactivates a comment (soft delete)
     *
     * @param commentId Comment ID to deactivate
     * @param userId User ID requesting the deactivation (must be comment owner)
     * @return true if deactivation successful, false otherwise
     */
    public boolean deactivateComment(int commentId, int userId) {
        String sql = "UPDATE comments SET is_active = FALSE WHERE comment_id = ? AND user_id = ?";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, commentId);
            statement.setInt(2, userId);

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                LOGGER.info("Comment deactivated successfully: " + commentId);
                return true;
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deactivating comment: " + commentId, e);
        }

        return false;
    }

    /**
     * Gets the total number of comments for a topic
     *
     * @param topicId Topic ID
     * @return Number of comments
     */
    public int getCommentCountByTopicId(int topicId) {
        String sql = "SELECT COUNT(*) FROM comments WHERE topic_id = ? AND is_active = TRUE";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, topicId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting comment count for topic: " + topicId, e);
        }

        return 0;
    }

    /**
     * Gets the total number of comments posted by a user
     *
     * @param userId User ID
     * @return Number of comments
     */
    public int getCommentCountByUserId(int userId) {
        String sql = "SELECT COUNT(*) FROM comments WHERE user_id = ? AND is_active = TRUE";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting comment count for user: " + userId, e);
        }

        return 0;
    }

    /**
     * Searches comments by text content
     *
     * @param searchTerm Search term to look for
     * @return List of matching Comment objects
     */
    public List<Comment> searchComments(String searchTerm) {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT c.*, u.first_name, u.last_name, u.email, " +
                "t.title as topic_title " +
                "FROM comments c " +
                "LEFT JOIN users u ON c.user_id = u.user_id " +
                "LEFT JOIN topics t ON c.topic_id = t.topic_id " +
                "WHERE c.comment_text LIKE ? AND c.is_active = TRUE " +
                "ORDER BY c.date_posted DESC";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            String searchPattern = "%" + searchTerm + "%";
            statement.setString(1, searchPattern);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Comment comment = mapResultSetToComment(resultSet);
                    // Load replies for each comment
                    comment.setReplies(replyDAO.getRepliesByCommentId(comment.getCommentId()));
                    comments.add(comment);
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error searching comments with term: " + searchTerm, e);
        }

        return comments;
    }

    /**
     * Gets recent comments across all topics
     *
     * @param limit Maximum number of comments to retrieve
     * @return List of recent Comment objects
     */
    public List<Comment> getRecentComments(int limit) {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT c.*, u.first_name, u.last_name, u.email, " +
                "t.title as topic_title " +
                "FROM comments c " +
                "LEFT JOIN users u ON c.user_id = u.user_id " +
                "LEFT JOIN topics t ON c.topic_id = t.topic_id " +
                "WHERE c.is_active = TRUE AND t.is_active = TRUE " +
                "ORDER BY c.date_posted DESC " +
                "LIMIT ?";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, limit);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Comment comment = mapResultSetToComment(resultSet);
                    comments.add(comment);
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving recent comments", e);
        }

        return comments;
    }

    /**
     * Updates the last activity timestamp for a topic when a comment is added
     *
     * @param topicId Topic ID to update
     */
    private void updateTopicLastActivity(int topicId) {
        String sql = "UPDATE topics SET last_activity = CURRENT_TIMESTAMP WHERE topic_id = ?";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, topicId);
            statement.executeUpdate();

        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "Error updating topic last activity: " + topicId, e);
        }
    }

    /**
     * Maps ResultSet to Comment object with User information
     *
     * @param resultSet ResultSet from database query
     * @return Comment object
     * @throws SQLException if error occurs during mapping
     */
    private Comment mapResultSetToComment(ResultSet resultSet) throws SQLException {
        Comment comment = new Comment();

        comment.setCommentId(resultSet.getInt("comment_id"));
        comment.setTopicId(resultSet.getInt("topic_id"));
        comment.setUserId(resultSet.getInt("user_id"));
        comment.setCommentText(resultSet.getString("comment_text"));
        comment.setDatePosted(resultSet.getTimestamp("date_posted"));
        comment.setActive(resultSet.getBoolean("is_active"));

        // Create and set user object if user data is available
        String firstName = resultSet.getString("first_name");
        if (firstName != null) {
            User user = new User();
            user.setUserId(resultSet.getInt("user_id"));
            user.setFirstName(firstName);
            user.setLastName(resultSet.getString("last_name"));
            user.setEmail(resultSet.getString("email"));
            comment.setUser(user);
        }

        return comment;
    }
}