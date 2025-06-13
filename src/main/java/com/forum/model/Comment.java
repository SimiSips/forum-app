package com.forum.model;

import java.sql.Timestamp;
import java.io.Serializable;
import java.util.List;
import java.util.ArrayList;

/**
 * Comment model class representing a comment on a forum topic
 * Follows JavaBeans naming conventions with proper getter/setter methods
 *
 * @author Simphiwe Radebe
 * @version 1.0
 * @since 2025-06-03
 */
public class Comment implements Serializable {

    /** Serial version UID for serialization */
    private static final long serialVersionUID = 1L;

    /** Unique comment identifier */
    private int commentId;

    /** Topic ID this comment belongs to */
    private int topicId;

    /** User ID who posted the comment */
    private int userId;

    /** Comment text content */
    private String commentText;

    /** Date when comment was posted */
    private Timestamp datePosted;

    /** Comment active status */
    private boolean isActive;

    /** User object (for display purposes) */
    private User user;

    /** Topic object (for display purposes) */
    private Topic topic;

    /** List of replies to this comment */
    private List<Reply> replies;

    /**
     * Default constructor
     */
    public Comment() {
        // Default constructor for JavaBean compliance
        this.replies = new ArrayList<>();
    }

    /**
     * Parameterized constructor for comment creation
     *
     * @param topicId Topic ID this comment belongs to
     * @param userId User ID who posted the comment
     * @param commentText Comment text content
     */
    public Comment(int topicId, int userId, String commentText) {
        this.topicId = topicId;
        this.userId = userId;
        this.commentText = commentText;
        this.isActive = true;
        this.replies = new ArrayList<>();
    }

    /**
     * Gets the comment ID
     *
     * @return comment ID
     */
    public int getCommentId() {
        return commentId;
    }

    /**
     * Sets the comment ID
     *
     * @param commentId the comment ID to set
     */
    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    /**
     * Gets the topic ID this comment belongs to
     *
     * @return topic ID
     */
    public int getTopicId() {
        return topicId;
    }

    /**
     * Sets the topic ID this comment belongs to
     *
     * @param topicId the topic ID to set
     */
    public void setTopicId(int topicId) {
        this.topicId = topicId;
    }

    /**
     * Gets the user ID who posted the comment
     *
     * @return user ID
     */
    public int getUserId() {
        return userId;
    }

    /**
     * Sets the user ID who posted the comment
     *
     * @param userId the user ID to set
     */
    public void setUserId(int userId) {
        this.userId = userId;
    }

    /**
     * Gets the comment text content
     *
     * @return comment text
     */
    public String getCommentText() {
        return commentText;
    }

    /**
     * Sets the comment text content
     *
     * @param commentText the comment text to set
     */
    public void setCommentText(String commentText) {
        this.commentText = commentText;
    }

    /**
     * Gets the date when comment was posted
     *
     * @return date posted
     */
    public Timestamp getDatePosted() {
        return datePosted;
    }

    /**
     * Sets the date when comment was posted
     *
     * @param datePosted the date posted to set
     */
    public void setDatePosted(Timestamp datePosted) {
        this.datePosted = datePosted;
    }

    /**
     * Checks if comment is active
     *
     * @return true if active, false otherwise
     */
    public boolean isActive() {
        return isActive;
    }

    /**
     * Sets the comment active status
     *
     * @param isActive the active status to set
     */
    public void setActive(boolean isActive) {
        this.isActive = isActive;
    }

    /**
     * Gets the user object
     *
     * @return user object
     */
    public User getUser() {
        return user;
    }

    /**
     * Sets the user object
     *
     * @param user the user object to set
     */
    public void setUser(User user) {
        this.user = user;
    }

    /**
     * Gets the topic object
     *
     * @return topic object
     */
    public Topic getTopic() {
        return topic;
    }

    /**
     * Sets the topic object
     *
     * @param topic the topic object to set
     */
    public void setTopic(Topic topic) {
        this.topic = topic;
    }

    /**
     * Gets the list of replies to this comment
     *
     * @return list of replies
     */
    public List<Reply> getReplies() {
        return replies;
    }

    /**
     * Sets the list of replies to this comment
     *
     * @param replies the list of replies to set
     */
    public void setReplies(List<Reply> replies) {
        this.replies = replies;
    }

    /**
     * Adds a reply to this comment
     *
     * @param reply the reply to add
     */
    public void addReply(Reply reply) {
        if (this.replies == null) {
            this.replies = new ArrayList<>();
        }
        this.replies.add(reply);
    }

    /**
     * Gets the number of replies to this comment
     *
     * @return number of replies
     */
    public int getReplyCount() {
        return replies != null ? replies.size() : 0;
    }

    /**
     * Gets a truncated version of the comment text for display
     *
     * @param maxLength maximum length of the truncated text
     * @return truncated comment text
     */
    public String getTruncatedText(int maxLength) {
        if (commentText == null) return "";
        if (commentText.length() <= maxLength) return commentText;
        return commentText.substring(0, maxLength) + "...";
    }

    /**
     * String representation of the Comment object
     *
     * @return string representation
     */
    @Override
    public String toString() {
        return "Comment{" +
                "commentId=" + commentId +
                ", topicId=" + topicId +
                ", userId=" + userId +
                ", commentText='" + commentText + '\'' +
                ", datePosted=" + datePosted +
                ", isActive=" + isActive +
                ", replyCount=" + getReplyCount() +
                '}';
    }

    /**
     * Equals method for object comparison
     *
     * @param obj object to compare
     * @return true if equal, false otherwise
     */
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Comment comment = (Comment) obj;
        return commentId == comment.commentId;
    }

    /**
     * Hash code for the object
     *
     * @return hash code
     */
    @Override
    public int hashCode() {
        return Integer.hashCode(commentId);
    }
}