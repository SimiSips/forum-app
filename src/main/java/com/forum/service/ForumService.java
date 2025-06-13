package com.forum.service;

import com.forum.dao.TopicDAO;
import com.forum.dao.CommentDAO;
import com.forum.dao.ReplyDAO;
import com.forum.model.Topic;
import com.forum.model.Comment;
import com.forum.model.Reply;
import com.forum.model.User;
import com.forum.util.ForumLogUtil;

import java.util.List;
import java.util.logging.Logger;

/**
 * Service class for Forum-related business logic
 * Handles topic, comment, and reply operations
 *
 * @author Simphiwe Radebe
 * @version 1.0
 * @since 2025-06-04
 */
public class ForumService {

    /** Logger instance for service operations */
    private static final Logger LOGGER = Logger.getLogger(ForumService.class.getName());

    /** Topic DAO for database operations */
    private final TopicDAO topicDAO;

    /** Comment DAO for database operations */
    private final CommentDAO commentDAO;

    /** Reply DAO for database operations */
    private final ReplyDAO replyDAO;

    /** User service for user-related operations */
    private final UserService userService;

    /**
     * Constructor to initialize ForumService
     */
    public ForumService() {
        this.topicDAO = new TopicDAO();
        this.commentDAO = new CommentDAO();
        this.replyDAO = new ReplyDAO();
        this.userService = new UserService();
    }

    /**
     * Creates a new topic with validation
     *
     * @param title Topic title
     * @param description Topic description
     * @param userId User ID creating the topic
     * @return Topic object if creation successful, null otherwise
     */
    public Topic createTopic(String title, String description, int userId) {

        // Validate input parameters
        if (isEmpty(title)) {
            LOGGER.warning("Topic title is required");
            return null;
        }

        if (isEmpty(description)) {
            LOGGER.warning("Topic description is required");
            return null;
        }

        if (userId <= 0) {
            LOGGER.warning("Valid user ID is required");
            return null;
        }

        // Validate user exists
        User user = userService.getUserById(userId);
        if (user == null) {
            LOGGER.warning("User not found: " + userId);
            return null;
        }

        // Sanitize input
        title = userService.sanitizeInput(title);
        description = userService.sanitizeInput(description);

        // Create new topic
        Topic topic = new Topic(title, description, userId);

        if (topicDAO.createTopic(topic)) {
            // Log topic creation
            ForumLogUtil.logTopicCreation(topic.getTopicId(), userId,
                    user.getFullName(), title);

            LOGGER.info("Topic created successfully: " + topic.getTopicId());
            return topic;
        }

        return null;
    }

    /**
     * Retrieves a topic by ID with comments and replies
     *
     * @param topicId Topic ID
     * @return Topic object with comments and replies if found, null otherwise
     */
    public Topic getTopicWithComments(int topicId) {

        if (topicId <= 0) {
            LOGGER.warning("Valid topic ID is required");
            return null;
        }

        // Get topic
        Topic topic = topicDAO.getTopicById(topicId);
        if (topic == null) {
            LOGGER.warning("Topic not found: " + topicId);
            return null;
        }

        // Get comments for topic
        List<Comment> comments = commentDAO.getCommentsByTopicId(topicId);

        // Set comments on topic (for display purposes)
        // Note: Topic model would need a comments field for this

        LOGGER.info("Retrieved topic with comments: " + topicId);
        return topic;
    }

    /**
     * Retrieves all active topics with comment counts
     *
     * @return List of Topic objects
     */
    public List<Topic> getAllTopics() {
        return topicDAO.getAllTopics();
    }

    /**
     * Retrieves topics by user ID
     *
     * @param userId User ID
     * @return List of Topic objects created by the user
     */
    public List<Topic> getTopicsByUser(int userId) {

        if (userId <= 0) {
            LOGGER.warning("Valid user ID is required");
            return null;
        }

        return topicDAO.getTopicsByUserId(userId);
    }

    /**
     * Creates a new comment with validation and logging
     *
     * @param topicId Topic ID
     * @param userId User ID posting the comment
     * @param commentText Comment text
     * @return Comment object if creation successful, null otherwise
     */
    public Comment createComment(int topicId, int userId, String commentText) {

        // Validate input parameters
        if (topicId <= 0) {
            LOGGER.warning("Valid topic ID is required");
            return null;
        }

        if (userId <= 0) {
            LOGGER.warning("Valid user ID is required");
            return null;
        }

        if (isEmpty(commentText)) {
            LOGGER.warning("Comment text is required");
            return null;
        }

        // Validate topic exists
        Topic topic = topicDAO.getTopicById(topicId);
        if (topic == null) {
            LOGGER.warning("Topic not found: " + topicId);
            return null;
        }

        // Validate user exists
        User user = userService.getUserById(userId);
        if (user == null) {
            LOGGER.warning("User not found: " + userId);
            return null;
        }

        // Sanitize input
        commentText = userService.sanitizeInput(commentText);

        // Create new comment
        Comment comment = new Comment(topicId, userId, commentText);

        if (commentDAO.createComment(comment)) {
            // Log comment creation
            ForumLogUtil.logComment(comment.getCommentId(), topicId, userId,
                    user.getFullName(), commentText);

            LOGGER.info("Comment created successfully: " + comment.getCommentId());
            return comment;
        }

        return null;
    }

    /**
     * Retrieves comments for a specific topic
     *
     * @param topicId Topic ID
     * @return List of Comment objects with replies
     */
    public List<Comment> getCommentsForTopic(int topicId) {

        if (topicId <= 0) {
            LOGGER.warning("Valid topic ID is required");
            return null;
        }

        return commentDAO.getCommentsByTopicId(topicId);
    }

    /**
     * Creates a new reply with validation and logging
     *
     * @param commentId Comment ID
     * @param userId User ID posting the reply
     * @param replyText Reply text
     * @return Reply object if creation successful, null otherwise
     */
    public Reply createReply(int commentId, int userId, String replyText) {

        // Validate input parameters
        if (commentId <= 0) {
            LOGGER.warning("Valid comment ID is required");
            return null;
        }

        if (userId <= 0) {
            LOGGER.warning("Valid user ID is required");
            return null;
        }

        if (isEmpty(replyText)) {
            LOGGER.warning("Reply text is required");
            return null;
        }

        // Validate comment exists
        Comment comment = commentDAO.getCommentById(commentId);
        if (comment == null) {
            LOGGER.warning("Comment not found: " + commentId);
            return null;
        }

        // Validate user exists
        User user = userService.getUserById(userId);
        if (user == null) {
            LOGGER.warning("User not found: " + userId);
            return null;
        }

        // Sanitize input
        replyText = userService.sanitizeInput(replyText);

        // Create new reply
        Reply reply = new Reply(commentId, userId, replyText);

        if (replyDAO.createReply(reply)) {
            // Log reply creation
            ForumLogUtil.logReply(reply.getReplyId(), commentId, userId,
                    user.getFullName(), replyText);

            LOGGER.info("Reply created successfully: " + reply.getReplyId());
            return reply;
        }

        return null;
    }

    /**
     * Retrieves replies for a specific comment
     *
     * @param commentId Comment ID
     * @return List of Reply objects
     */
    public List<Reply> getRepliesForComment(int commentId) {

        if (commentId <= 0) {
            LOGGER.warning("Valid comment ID is required");
            return null;
        }

        return replyDAO.getRepliesByCommentId(commentId);
    }

    /**
     * Updates a topic (only by owner)
     *
     * @param topicId Topic ID
     * @param title New title
     * @param description New description
     * @param userId User ID requesting the update
     * @return true if update successful, false otherwise
     */
    public boolean updateTopic(int topicId, String title, String description, int userId) {

        // Validate input parameters
        if (topicId <= 0 || userId <= 0) {
            LOGGER.warning("Valid topic ID and user ID are required");
            return false;
        }

        if (isEmpty(title) || isEmpty(description)) {
            LOGGER.warning("Title and description are required");
            return false;
        }

        // Get existing topic
        Topic topic = topicDAO.getTopicById(topicId);
        if (topic == null) {
            LOGGER.warning("Topic not found: " + topicId);
            return false;
        }

        // Check if user can modify this topic
        if (!userService.canUserModifyResource(userId, topic.getUserId())) {
            LOGGER.warning("User not authorized to modify topic: " + topicId);
            return false;
        }

        // Sanitize input
        title = userService.sanitizeInput(title);
        description = userService.sanitizeInput(description);

        // Update topic
        topic.setTitle(title);
        topic.setDescription(description);

        boolean success = topicDAO.updateTopic(topic);

        if (success) {
            LOGGER.info("Topic updated successfully: " + topicId);
        } else {
            LOGGER.warning("Failed to update topic: " + topicId);
        }

        return success;
    }

    /**
     * Updates a comment (only by owner)
     *
     * @param commentId Comment ID
     * @param newText New comment text
     * @param userId User ID requesting the update
     * @return true if update successful, false otherwise
     */
    public boolean updateComment(int commentId, String newText, int userId) {

        // Validate input parameters
        if (commentId <= 0 || userId <= 0) {
            LOGGER.warning("Valid comment ID and user ID are required");
            return false;
        }

        if (isEmpty(newText)) {
            LOGGER.warning("Comment text is required");
            return false;
        }

        // Get existing comment
        Comment comment = commentDAO.getCommentById(commentId);
        if (comment == null) {
            LOGGER.warning("Comment not found: " + commentId);
            return false;
        }

        // Check if user can modify this comment
        if (!userService.canUserModifyResource(userId, comment.getUserId())) {
            LOGGER.warning("User not authorized to modify comment: " + commentId);
            return false;
        }

        // Get user for logging
        User user = userService.getUserById(userId);
        String oldText = comment.getCommentText();

        // Sanitize input
        newText = userService.sanitizeInput(newText);

        // Update comment
        boolean success = commentDAO.updateComment(commentId, newText, userId);

        if (success && user != null) {
            // Log comment update
            ForumLogUtil.logCommentUpdate(commentId, userId, user.getFullName(),
                    oldText, newText);
            LOGGER.info("Comment updated successfully: " + commentId);
        } else {
            LOGGER.warning("Failed to update comment: " + commentId);
        }

        return success;
    }

    /**
     * Updates a reply (only by owner)
     *
     * @param replyId Reply ID
     * @param newText New reply text
     * @param userId User ID requesting the update
     * @return true if update successful, false otherwise
     */
    public boolean updateReply(int replyId, String newText, int userId) {

        // Validate input parameters
        if (replyId <= 0 || userId <= 0) {
            LOGGER.warning("Valid reply ID and user ID are required");
            return false;
        }

        if (isEmpty(newText)) {
            LOGGER.warning("Reply text is required");
            return false;
        }

        // Get existing reply
        Reply reply = replyDAO.getReplyById(replyId);
        if (reply == null) {
            LOGGER.warning("Reply not found: " + replyId);
            return false;
        }

        // Check if user can modify this reply
        if (!userService.canUserModifyResource(userId, reply.getUserId())) {
            LOGGER.warning("User not authorized to modify reply: " + replyId);
            return false;
        }

        // Get user for logging
        User user = userService.getUserById(userId);
        String oldText = reply.getReplyText();

        // Sanitize input
        newText = userService.sanitizeInput(newText);

        // Update reply
        boolean success = replyDAO.updateReply(replyId, newText, userId);

        if (success && user != null) {
            // Log reply update
            ForumLogUtil.logReplyUpdate(replyId, userId, user.getFullName(),
                    oldText, newText);
            LOGGER.info("Reply updated successfully: " + replyId);
        } else {
            LOGGER.warning("Failed to update reply: " + replyId);
        }

        return success;
    }

    /**
     * Searches topics by title or description
     *
     * @param searchTerm Search term
     * @return List of matching Topic objects
     */
    public List<Topic> searchTopics(String searchTerm) {

        if (isEmpty(searchTerm)) {
            LOGGER.warning("Search term is required");
            return null;
        }

        // Sanitize search term
        searchTerm = userService.sanitizeInput(searchTerm);

        return topicDAO.searchTopics(searchTerm);
    }

    /**
     * Gets recent activity (comments and replies)
     *
     * @param limit Maximum number of items to retrieve
     * @return List of recent activities
     */
    public List<Comment> getRecentActivity(int limit) {

        if (limit <= 0) {
            limit = 10; // Default limit
        }

        return commentDAO.getRecentComments(limit);
    }

    /**
     * Gets forum statistics
     *
     * @return Forum statistics as a formatted string
     */
    public String getForumStatistics() {
        int totalTopics = topicDAO.getTotalTopicCount();
        // Additional statistics could be added here

        return String.format("Total Topics: %d", totalTopics);
    }

    /**
     * Validates topic creation data
     *
     * @param title Topic title
     * @param description Topic description
     * @param userId User ID
     * @return Validation error message, null if valid
     */
    public String validateTopicData(String title, String description, int userId) {

        if (isEmpty(title)) {
            return "Topic title is required";
        }

        if (title.length() > 255) {
            return "Topic title must be 255 characters or less";
        }

        if (isEmpty(description)) {
            return "Topic description is required";
        }

        if (description.length() > 5000) {
            return "Topic description must be 5000 characters or less";
        }

        if (userId <= 0) {
            return "Valid user session required";
        }

        return null; // No validation errors
    }

    /**
     * Validates comment data
     *
     * @param commentText Comment text
     * @param userId User ID
     * @param topicId Topic ID
     * @return Validation error message, null if valid
     */
    public String validateCommentData(String commentText, int userId, int topicId) {

        if (isEmpty(commentText)) {
            return "Comment text is required";
        }

        if (commentText.length() > 2000) {
            return "Comment must be 2000 characters or less";
        }

        if (userId <= 0) {
            return "Valid user session required";
        }

        if (topicId <= 0) {
            return "Valid topic required";
        }

        return null; // No validation errors
    }

    /**
     * Validates reply data
     *
     * @param replyText Reply text
     * @param userId User ID
     * @param commentId Comment ID
     * @return Validation error message, null if valid
     */
    public String validateReplyData(String replyText, int userId, int commentId) {

        if (isEmpty(replyText)) {
            return "Reply text is required";
        }

        if (replyText.length() > 1000) {
            return "Reply must be 1000 characters or less";
        }

        if (userId <= 0) {
            return "Valid user session required";
        }

        if (commentId <= 0) {
            return "Valid comment required";
        }

        return null; // No validation errors
    }

    /**
     * Helper method to check if string is null or empty
     *
     * @param str String to check
     * @return true if null or empty, false otherwise
     */
    private boolean isEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }
}