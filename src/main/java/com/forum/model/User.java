package com.forum.model;

import java.sql.Timestamp;
import java.io.Serializable;

/**
 * User model class representing a forum user
 * Follows JavaBeans naming conventions with proper getter/setter methods
 *
 * @author Simphiwe Radebe
 * @version 1.0
 * @since 2025-06-03
 */
public class User implements Serializable {

    /** Serial version UID for serialization */
    private static final long serialVersionUID = 1L;

    /** Unique user identifier */
    private int userId;

    /** User's email address (unique) */
    private String email;

    /** User's password hash */
    private String passwordHash;

    /** User's first name */
    private String firstName;

    /** User's last name */
    private String lastName;

    /** User's phone number */
    private String phone;

    /** Date when user registered */
    private Timestamp dateRegistered;

    /** Last login timestamp */
    private Timestamp lastLogin;

    /** User account active status */
    private boolean isActive;

    /** Password reset token */
    private String passwordResetToken;

    /** Password reset token expiration */
    private Timestamp passwordResetExpires;

    /**
     * Default constructor
     */
    public User() {
        // Default constructor for JavaBean compliance
    }

    /**
     * Parameterized constructor for user creation
     *
     * @param email User's email address
     * @param passwordHash User's hashed password
     * @param firstName User's first name
     * @param lastName User's last name
     * @param phone User's phone number
     */
    public User(String email, String passwordHash, String firstName,
                String lastName, String phone) {
        this.email = email;
        this.passwordHash = passwordHash;
        this.firstName = firstName;
        this.lastName = lastName;
        this.phone = phone;
        this.isActive = true;
    }

    /**
     * Gets the user ID
     *
     * @return user ID
     */
    public int getUserId() {
        return userId;
    }

    /**
     * Sets the user ID
     *
     * @param userId the user ID to set
     */
    public void setUserId(int userId) {
        this.userId = userId;
    }

    /**
     * Gets the user's email address
     *
     * @return email address
     */
    public String getEmail() {
        return email;
    }

    /**
     * Sets the user's email address
     *
     * @param email the email address to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * Gets the user's password hash
     *
     * @return password hash
     */
    public String getPasswordHash() {
        return passwordHash;
    }

    /**
     * Sets the user's password hash
     *
     * @param passwordHash the password hash to set
     */
    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    /**
     * Gets the user's first name
     *
     * @return first name
     */
    public String getFirstName() {
        return firstName;
    }

    /**
     * Sets the user's first name
     *
     * @param firstName the first name to set
     */
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    /**
     * Gets the user's last name
     *
     * @return last name
     */
    public String getLastName() {
        return lastName;
    }

    /**
     * Sets the user's last name
     *
     * @param lastName the last name to set
     */
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    /**
     * Gets the user's phone number
     *
     * @return phone number
     */
    public String getPhone() {
        return phone;
    }

    /**
     * Sets the user's phone number
     *
     * @param phone the phone number to set
     */
    public void setPhone(String phone) {
        this.phone = phone;
    }

    /**
     * Gets the registration date
     *
     * @return registration date
     */
    public Timestamp getDateRegistered() {
        return dateRegistered;
    }

    /**
     * Sets the registration date
     *
     * @param dateRegistered the registration date to set
     */
    public void setDateRegistered(Timestamp dateRegistered) {
        this.dateRegistered = dateRegistered;
    }

    /**
     * Gets the last login timestamp
     *
     * @return last login timestamp
     */
    public Timestamp getLastLogin() {
        return lastLogin;
    }

    /**
     * Sets the last login timestamp
     *
     * @param lastLogin the last login timestamp to set
     */
    public void setLastLogin(Timestamp lastLogin) {
        this.lastLogin = lastLogin;
    }

    /**
     * Checks if user account is active
     *
     * @return true if active, false otherwise
     */
    public boolean isActive() {
        return isActive;
    }

    /**
     * Sets the user account active status
     *
     * @param isActive the active status to set
     */
    public void setActive(boolean isActive) {
        this.isActive = isActive;
    }

    /**
     * Gets the password reset token
     *
     * @return password reset token
     */
    public String getPasswordResetToken() {
        return passwordResetToken;
    }

    /**
     * Sets the password reset token
     *
     * @param passwordResetToken the password reset token to set
     */
    public void setPasswordResetToken(String passwordResetToken) {
        this.passwordResetToken = passwordResetToken;
    }

    /**
     * Gets the password reset token expiration
     *
     * @return password reset token expiration
     */
    public Timestamp getPasswordResetExpires() {
        return passwordResetExpires;
    }

    /**
     * Sets the password reset token expiration
     *
     * @param passwordResetExpires the password reset token expiration to set
     */
    public void setPasswordResetExpires(Timestamp passwordResetExpires) {
        this.passwordResetExpires = passwordResetExpires;
    }

    /**
     * Gets the user's full name
     *
     * @return full name (first name + last name)
     */
    public String getFullName() {
        return (firstName != null ? firstName : "") + " " +
                (lastName != null ? lastName : "");
    }

    /**
     * String representation of the User object
     *
     * @return string representation
     */
    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", email='" + email + '\'' +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", phone='" + phone + '\'' +
                ", dateRegistered=" + dateRegistered +
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
        User user = (User) obj;
        return userId == user.userId;
    }

    /**
     * Hash code for the object
     *
     * @return hash code
     */
    @Override
    public int hashCode() {
        return Integer.hashCode(userId);
    }
}