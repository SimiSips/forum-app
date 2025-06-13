package com.forum.model;

import java.sql.Timestamp;
import java.io.Serializable;

/**
 * Reply model class representing a reply to a comment in the forum
 * Follows JavaBeans naming conventions with proper getter/setter methods
 *
 * @author Simphiwe Radebe
 * @version 1.0
 * @since 2025-06-04
 */
public class Reply implements Serializable {

    /** Serial version UID for serialization */
    private static final long serialVersionUID = 1L;

    /** Unique reply identifier */
    private int replyId;

    /** Comment ID this reply belongs to */
    private int commentId;

    /** User ID who posted the reply */
    private int userId;

    /** Reply text content */
    private String replyText;

    /** Date when reply was posted */
    private Timestamp datePosted;

    /** Reply active status */
    private boolean isActive;

    /** User object (for display purposes) */
    private User user;

    /** Comment object (for display purposes) */
    private Comment comment;

    /**
     * Default constructor
     */
    public Reply() {
        // Default constructor for JavaBean compliance
    }

    /**
     * Parameterized constructor for reply creation
     *
     * @param commentId Comment ID this reply belongs to
     * @param userId User ID who posted the reply
     * @param replyText Reply text content
     */
    public Reply(int commentId, int userId, String replyText) {
        this.commentId = commentId;
        this.userId = userId;
        this.replyText = replyText;
        this.isActive = true;
    }

    /**
     * Gets the reply ID
     *
     * @return reply ID
     */
    public int getReplyId() {
        return replyId;
    }

    /**
     * Sets the reply ID
     *
     * @param replyId the reply ID to set
     */
    public void setReplyId(int replyId) {
        this.replyId = replyId;
    }

    /**
     * Gets the comment ID this reply belongs to
     *
     * @return comment ID
     */
    public int getCommentId() {
        return commentId;
    }

    /**
     * Sets the comment ID this reply belongs to
     *
     * @param commentId the comment ID to set
     */
    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    /**
     * Gets the user ID who posted the reply
     *
     * @return user ID
     */
    public int getUserId() {
        return userId;
    }

    /**
     * Sets the user ID who posted the reply
     *
     * @param userId the user ID to set
     */
    public void setUserId(int userId) {
        this.userId = userId;
    }

    /**
     * Gets the reply text content
     *
     * @return reply text
     */
    public String getReplyText() {
        return replyText;
    }

    /**
     * Sets the reply text content
     *
     * @param replyText the reply text to set
     */
    public void setReplyText(String replyText) {
        this.replyText = replyText;
    }

    /**
     * Gets the date when reply was posted
     *
     * @return date posted
     */
    public Timestamp getDatePosted() {
        return datePosted;
    }

    /**
     * Sets the date when reply was posted
     *
     * @param datePosted the date posted to set
     */
    public void setDatePosted(Timestamp datePosted) {
        this.datePosted = datePosted;
    }

    /**
     * Checks if reply is active
     *
     * @return true if active, false otherwise
     */
    public boolean isActive() {
        return isActive;
    }

    /**
     * Sets the reply active status
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
     * Gets the comment object
     *
     * @return comment object
     */
    public Comment getComment() {
        return comment;
    }

    /**
     * Sets the comment object
     *
     * @param comment the comment object to set
     */
    public void setComment(Comment comment) {
        this.comment = comment;
    }

    /**
     * Gets a truncated version of the reply text for display
     *
     * @param maxLength maximum length of the truncated text
     * @return truncated reply text
     */
    public String getTruncatedText(int maxLength) {
        if (replyText == null) return "";
        if (replyText.length() <= maxLength) return replyText;
        return replyText.substring(0, maxLength) + "...";
    }

    /**
     * String representation of the Reply object
     *
     * @return string representation
     */
    @Override
    public String toString() {
        return "Reply{" +
                "replyId=" + replyId +
                ", commentId=" + commentId +
                ", userId=" + userId +
                ", replyText='" + replyText + '\'' +
                ", datePosted=" + datePosted +
                ", isActive=" + isActive +
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
        Reply reply = (Reply) obj;
        return replyId == reply.replyId;
    }

    /**
     * Hash code for the object
     *
     * @return hash code
     */
    @Override
    public int hashCode() {
        return Integer.hashCode(replyId);
    }
}