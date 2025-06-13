package com.forum.model;

import java.sql.Timestamp;
import java.io.Serializable;

/**
 * Topic model class representing a forum topic
 * Follows JavaBeans naming conventions with proper getter/setter methods
 *
 * @author Simphiwe Radebe
 * @version 1.0
 * @since 2025-06-03
 */
public class Topic implements Serializable {

    /** Serial version UID for serialization */
    private static final long serialVersionUID = 1L;

    /** Unique topic identifier */
    private int topicId;

    /** Topic title */
    private String title;

    /** Topic description */
    private String description;

    /** User ID who created the topic */
    private int userId;

    /** Date when topic was created */
    private Timestamp dateCreated;

    /** Last activity timestamp */
    private Timestamp lastActivity;

    /** Topic active status */
    private boolean isActive;

    /** User object (for display purposes) */
    private User user;

    /** Comment count for this topic */
    private int commentCount;

    /**
     * Default constructor
     */
    public Topic() {
        // Default constructor for JavaBean compliance
    }

    /**
     * Parameterized constructor for topic creation
     *
     * @param title Topic title
     * @param description Topic description
     * @param userId User ID who created the topic
     */
    public Topic(String title, String description, int userId) {
        this.title = title;
        this.description = description;
        this.userId = userId;
        this.isActive = true;
    }

    /**
     * Gets the topic ID
     *
     * @return topic ID
     */
    public int getTopicId() {
        return topicId;
    }

    /**
     * Sets the topic ID
     *
     * @param topicId the topic ID to set
     */
    public void setTopicId(int topicId) {
        this.topicId = topicId;
    }

    /**
     * Gets the topic title
     *
     * @return topic title
     */
    public String getTitle() {
        return title;
    }

    /**
     * Sets the topic title
     *
     * @param title the title to set
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * Gets the topic description
     *
     * @return topic description
     */
    public String getDescription() {
        return description;
    }

    /**
     * Sets the topic description
     *
     * @param description the description to set
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * Gets the user ID who created the topic
     *
     * @return user ID
     */
    public int getUserId() {
        return userId;
    }

    /**
     * Sets the user ID who created the topic
     *
     * @param userId the user ID to set
     */
    public void setUserId(int userId) {
        this.userId = userId;
    }

    /**
     * Gets the topic creation date
     *
     * @return creation date
     */
    public Timestamp getDateCreated() {
        return dateCreated;
    }

    /**
     * Sets the topic creation date
     *
     * @param dateCreated the creation date to set
     */
    public void setDateCreated(Timestamp dateCreated) {
        this.dateCreated = dateCreated;
    }

    /**
     * Gets the last activity timestamp
     *
     * @return last activity timestamp
     */
    public Timestamp getLastActivity() {
        return lastActivity;
    }

    /**
     * Sets the last activity timestamp
     *
     * @param lastActivity the last activity timestamp to set
     */
    public void setLastActivity(Timestamp lastActivity) {
        this.lastActivity = lastActivity;
    }

    /**
     * Checks if topic is active
     *
     * @return true if active, false otherwise
     */
    public boolean isActive() {
        return isActive;
    }

    /**
     * Sets the topic active status
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
     * Gets the comment count for this topic
     *
     * @return comment count
     */
    public int getCommentCount() {
        return commentCount;
    }

    /**
     * Sets the comment count for this topic
     *
     * @param commentCount the comment count to set
     */
    public void setCommentCount(int commentCount) {
        this.commentCount = commentCount;
    }

    /**
     * Gets a truncated version of the description for display
     *
     * @param maxLength maximum length of the truncated description
     * @return truncated description
     */
    public String getTruncatedDescription(int maxLength) {
        if (description == null) return "";
        if (description.length() <= maxLength) return description;
        return description.substring(0, maxLength) + "...";
    }

    /**
     * String representation of the Topic object
     *
     * @return string representation
     */
    @Override
    public String toString() {
        return "Topic{" +
                "topicId=" + topicId +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", userId=" + userId +
                ", dateCreated=" + dateCreated +
                ", lastActivity=" + lastActivity +
                ", isActive=" + isActive +
                ", commentCount=" + commentCount +
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
        Topic topic = (Topic) obj;
        return topicId == topic.topicId;
    }

    /**
     * Hash code for the object
     *
     * @return hash code
     */
    @Override
    public int hashCode() {
        return Integer.hashCode(topicId);
    }
}