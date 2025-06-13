package com.forum.service;

import com.forum.dao.UserDAO;
import com.forum.model.User;
import com.forum.util.PasswordHashUtil;
import com.forum.util.ForumLogUtil;

import java.sql.Timestamp;
import java.util.List;
import java.util.UUID;
import java.util.logging.Logger;

/**
 * Service class for User-related business logic
 * Handles user operations and validation
 *
 * @author Simphiwe Radebe
 * @version 1.0
 * @since 2025-06-03
 */
public class UserService {

    /** Logger instance for service operations */
    private static final Logger LOGGER = Logger.getLogger(UserService.class.getName());

    /** User DAO for database operations */
    private final UserDAO userDAO;

    /**
     * Constructor to initialize UserService
     */
    public UserService() {
        this.userDAO = new UserDAO();
    }

    /**
     * Registers a new user with validation
     *
     * @param email User email
     * @param password User password
     * @param firstName User first name
     * @param lastName User last name
     * @param phone User phone number
     * @return User object if registration successful, null otherwise
     */
    public User registerUser(String email, String password, String firstName,
                             String lastName, String phone) {

        // Validate input parameters
        if (!isValidEmail(email)) {
            LOGGER.warning("Invalid email format: " + email);
            return null;
        }

        if (!PasswordHashUtil.isPasswordStrong(password)) {
            LOGGER.warning("Password does not meet strength requirements");
            return null;
        }

        if (isEmpty(firstName) || isEmpty(lastName)) {
            LOGGER.warning("First name and last name are required");
            return null;
        }

        // Check if email already exists
        if (userDAO.emailExists(email)) {
            LOGGER.warning("Email already exists: " + email);
            return null;
        }

        // Create new user
        User user = new User(email, password, firstName, lastName, phone);

        if (userDAO.createUser(user)) {
            // Log user registration
            ForumLogUtil.logUserRegistration(user.getUserId(), user.getEmail(),
                    user.getFullName());

            LOGGER.info("User registered successfully: " + email);
            return user;
        }

        return null;
    }

    /**
     * Authenticates user login
     *
     * @param email User email
     * @param password User password
     * @return User object if login successful, null otherwise
     */
    public User authenticateUser(String email, String password) {

        // Validate input parameters
        if (isEmpty(email) || isEmpty(password)) {
            LOGGER.warning("Email and password are required for login");
            return null;
        }

        // Validate login credentials
        User user = userDAO.validateLogin(email, password);

        if (user != null) {
            // Log successful login
            ForumLogUtil.logUserLogin(user.getUserId(), user.getEmail());
            LOGGER.info("User login successful: " + email);
        } else {
            LOGGER.warning("Login failed for user: " + email);
        }

        return user;
    }

    /**
     * Updates user profile information
     *
     * @param userId User ID
     * @param firstName New first name
     * @param lastName New last name
     * @param phone New phone number
     * @return true if update successful, false otherwise
     */
    public boolean updateUserProfile(int userId, String firstName, String lastName, String phone) {

        // Validate input parameters
        if (isEmpty(firstName) || isEmpty(lastName)) {
            LOGGER.warning("First name and last name are required");
            return false;
        }

        // Get existing user
        User user = userDAO.getUserById(userId);
        if (user == null) {
            LOGGER.warning("User not found: " + userId);
            return false;
        }

        // Update user information
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setPhone(phone);

        boolean success = userDAO.updateUser(user);

        if (success) {
            LOGGER.info("User profile updated successfully: " + userId);
        } else {
            LOGGER.warning("Failed to update user profile: " + userId);
        }

        return success;
    }

    /**
     * Changes user password
     *
     * @param userId User ID
     * @param currentPassword Current password
     * @param newPassword New password
     * @return true if password changed successfully, false otherwise
     */
    public boolean changePassword(int userId, String currentPassword, String newPassword) {

        // Validate input parameters
        if (isEmpty(currentPassword) || isEmpty(newPassword)) {
            LOGGER.warning("Current and new passwords are required");
            return false;
        }

        if (!PasswordHashUtil.isPasswordStrong(newPassword)) {
            LOGGER.warning("New password does not meet strength requirements");
            return false;
        }

        // Get user and verify current password
        User user = userDAO.getUserById(userId);
        if (user == null) {
            LOGGER.warning("User not found: " + userId);
            return false;
        }

        if (!PasswordHashUtil.verifyPassword(currentPassword, user.getPasswordHash())) {
            LOGGER.warning("Current password verification failed for user: " + userId);
            return false;
        }

        // Update password
        boolean success = userDAO.updatePassword(userId, newPassword);

        if (success) {
            LOGGER.info("Password changed successfully for user: " + userId);
        } else {
            LOGGER.warning("Failed to change password for user: " + userId);
        }

        return success;
    }

    /**
     * Initiates password reset process
     *
     * @param email User email
     * @return Reset token if successful, null otherwise
     */
    public String initiatePasswordReset(String email) {

        // Validate email
        if (!isValidEmail(email)) {
            LOGGER.warning("Invalid email format for password reset: " + email);
            return null;
        }

        // Check if user exists
        User user = userDAO.getUserByEmail(email);
        if (user == null) {
            LOGGER.warning("User not found for password reset: " + email);
            return null;
        }

        // Generate reset token
        String resetToken = PasswordHashUtil.generateResetToken();

        // Set token expiry (24 hours from now)
        Timestamp expiryTime = new Timestamp(System.currentTimeMillis() + (24 * 60 * 60 * 1000));

        // Save token to database
        boolean success = userDAO.setPasswordResetToken(email, resetToken, expiryTime);

        if (success) {
            LOGGER.info("Password reset token generated for user: " + email);
            return resetToken;
        } else {
            LOGGER.warning("Failed to generate password reset token for user: " + email);
            return null;
        }
    }

    /**
     * Completes password reset process
     *
     * @param token Reset token
     * @param newPassword New password
     * @return true if reset successful, false otherwise
     */
    public boolean completePasswordReset(String token, String newPassword) {

        // Validate input parameters
        if (isEmpty(token) || isEmpty(newPassword)) {
            LOGGER.warning("Token and new password are required for password reset");
            return false;
        }

        if (!PasswordHashUtil.isPasswordStrong(newPassword)) {
            LOGGER.warning("New password does not meet strength requirements");
            return false;
        }

        // Validate reset token
        User user = userDAO.validatePasswordResetToken(token);
        if (user == null) {
            LOGGER.warning("Invalid or expired password reset token");
            return false;
        }

        // Update password
        boolean passwordUpdated = userDAO.updatePassword(user.getUserId(), newPassword);

        if (passwordUpdated) {
            // Clear reset token
            userDAO.clearPasswordResetToken(user.getUserId());
            LOGGER.info("Password reset completed for user: " + user.getEmail());
            return true;
        } else {
            LOGGER.warning("Failed to update password during reset for user: " + user.getEmail());
            return false;
        }
    }

    /**
     * Retrieves user by ID
     *
     * @param userId User ID
     * @return User object if found, null otherwise
     */
    public User getUserById(int userId) {
        return userDAO.getUserById(userId);
    }

    /**
     * Retrieves user by email
     *
     * @param email User email
     * @return User object if found, null otherwise
     */
    public User getUserByEmail(String email) {
        if (!isValidEmail(email)) {
            return null;
        }
        return userDAO.getUserByEmail(email);
    }

    /**
     * Retrieves all active users
     *
     * @return List of User objects
     */
    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    /**
     * Validates email format
     *
     * @param email Email to validate
     * @return true if valid, false otherwise
     */
    public boolean isValidEmail(String email) {
        if (isEmpty(email)) {
            return false;
        }

        // Basic email regex pattern
        String emailPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
        return email.matches(emailPattern);
    }

    /**
     * Validates phone number format
     *
     * @param phone Phone number to validate
     * @return true if valid, false otherwise
     */
    public boolean isValidPhone(String phone) {
        if (isEmpty(phone)) {
            return true; // Phone is optional
        }

        // Basic phone number pattern (allowing digits, spaces, dashes, parentheses)
        String phonePattern = "^[\\d\\s\\-\\(\\)\\+]{10,15}$";
        return phone.matches(phonePattern);
    }

    /**
     * Checks if user exists by email
     *
     * @param email Email to check
     * @return true if exists, false otherwise
     */
    public boolean userExists(String email) {
        return userDAO.emailExists(email);
    }

    /**
     * Validates user session
     *
     * @param userId User ID from session
     * @return true if valid session, false otherwise
     */
    public boolean isValidSession(Integer userId) {
        if (userId == null || userId <= 0) {
            return false;
        }

        User user = userDAO.getUserById(userId);
        return user != null && user.isActive();
    }

    /**
     * Gets password strength requirements
     *
     * @return String describing password requirements
     */
    public String getPasswordRequirements() {
        return PasswordHashUtil.getPasswordRequirements();
    }

    /**
     * Validates user input for XSS and injection attacks
     *
     * @param input Input string to validate
     * @return Sanitized input string
     */
    public String sanitizeInput(String input) {
        if (input == null) {
            return null;
        }

        // Basic XSS protection - remove script tags and suspicious characters
        return input.replaceAll("<script.*?>.*?</script>", "")
                .replaceAll("<.*?>", "")
                .replaceAll("javascript:", "")
                .replaceAll("vbscript:", "")
                .replaceAll("onload", "")
                .replaceAll("onerror", "")
                .replaceAll("onclick", "")
                .trim();
    }

    /**
     * Validates if user can perform action on resource
     *
     * @param userId User ID
     * @param resourceOwnerId Resource owner ID
     * @return true if user can perform action, false otherwise
     */
    public boolean canUserModifyResource(int userId, int resourceOwnerId) {
        return userId == resourceOwnerId;
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

    /**
     * Validates user registration data
     *
     * @param email User email
     * @param password User password
     * @param firstName User first name
     * @param lastName User last name
     * @param phone User phone number
     * @return Validation error message, null if valid
     */
    public String validateRegistrationData(String email, String password, String firstName,
                                           String lastName, String phone) {

        if (isEmpty(email)) {
            return "Email is required";
        }

        if (!isValidEmail(email)) {
            return "Invalid email format";
        }

        if (userExists(email)) {
            return "Email already exists";
        }

        if (isEmpty(password)) {
            return "Password is required";
        }

        if (!PasswordHashUtil.isPasswordStrong(password)) {
            return getPasswordRequirements();
        }

        if (isEmpty(firstName)) {
            return "First name is required";
        }

        if (isEmpty(lastName)) {
            return "Last name is required";
        }

        if (!isValidPhone(phone)) {
            return "Invalid phone number format";
        }

        return null; // No validation errors
    }

    /**
     * Validates user login data
     *
     * @param email User email
     * @param password User password
     * @return Validation error message, null if valid
     */
    public String validateLoginData(String email, String password) {

        if (isEmpty(email)) {
            return "Email is required";
        }

        if (!isValidEmail(email)) {
            return "Invalid email format";
        }

        if (isEmpty(password)) {
            return "Password is required";
        }

        return null; // No validation errors
    }
}