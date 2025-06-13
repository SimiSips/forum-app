package com.forum.webservice;

import com.forum.service.UserService;
import com.forum.model.User;
import org.json.JSONObject;
import org.json.JSONArray;

import java.util.List;
import java.util.logging.Logger;

/**
 * Web Service class for User-related operations
 * Provides JSON-based API for user management
 *
 * @author Simphiwe Radebe
 * @version 1.0
 * @since 2025-06-08
 */
public class UserWebService {

    /** Logger instance for web service operations */
    private static final Logger LOGGER = Logger.getLogger(UserWebService.class.getName());

    /** User service for business logic */
    private final UserService userService;

    /**
     * Constructor to initialize UserWebService
     */
    public UserWebService() {
        this.userService = new UserService();
    }

    /**
     * Registers a new user via JSON
     *
     * @param jsonData JSON string containing user registration data
     * @return JSON response string
     */
    public String registerUserJson(String jsonData) {
        try {
            JSONObject jsonObject = new JSONObject(jsonData);

            String email = jsonObject.optString("email");
            String password = jsonObject.optString("password");
            String firstName = jsonObject.optString("firstName");
            String lastName = jsonObject.optString("lastName");
            String phone = jsonObject.optString("phone");

            // Validate input
            String validationError = userService.validateRegistrationData(email, password, firstName, lastName, phone);
            if (validationError != null) {
                return createErrorResponse(validationError);
            }

            // Register user
            User user = userService.registerUser(email, password, firstName, lastName, phone);

            if (user != null) {
                JSONObject response = new JSONObject();
                response.put("success", true);
                response.put("message", "User registered successfully");
                response.put("data", userToJson(user, false)); // Don't include sensitive data

                LOGGER.info("User registered via web service: " + user.getEmail());
                return response.toString();
            } else {
                return createErrorResponse("Failed to register user");
            }

        } catch (Exception e) {
            LOGGER.severe("Error registering user: " + e.getMessage());
            return createErrorResponse("Invalid user data");
        }
    }

    /**
     * Authenticates user via JSON
     *
     * @param jsonData JSON string containing login credentials
     * @return JSON response string
     */
    public String authenticateUserJson(String jsonData) {
        try {
            JSONObject jsonObject = new JSONObject(jsonData);

            String email = jsonObject.optString("email");
            String password = jsonObject.optString("password");

            // Validate input
            String validationError = userService.validateLoginData(email, password);
            if (validationError != null) {
                return createErrorResponse(validationError);
            }

            // Authenticate user
            User user = userService.authenticateUser(email, password);

            if (user != null) {
                JSONObject response = new JSONObject();
                response.put("success", true);
                response.put("message", "Authentication successful");
                response.put("data", userToJson(user, false)); // Don't include sensitive data

                LOGGER.info("User authenticated via web service: " + user.getEmail());
                return response.toString();
            } else {
                return createErrorResponse("Invalid email or password");
            }

        } catch (Exception e) {
            LOGGER.severe("Error authenticating user: " + e.getMessage());
            return createErrorResponse("Authentication failed");
        }
    }

    /**
     * Gets user by ID as JSON
     *
     * @param userId User ID to retrieve
     * @return JSON string containing user data
     */
    public String getUserByIdJson(int userId) {
        try {
            User user = userService.getUserById(userId);

            if (user != null) {
                JSONObject response = new JSONObject();
                response.put("success", true);
                response.put("data", userToJson(user, false)); // Don't include sensitive data

                LOGGER.info("Retrieved user " + userId + " via web service");
                return response.toString();
            } else {
                return createErrorResponse("User not found");
            }

        } catch (Exception e) {
            LOGGER.severe("Error getting user " + userId + ": " + e.getMessage());
            return createErrorResponse("Failed to retrieve user");
        }
    }

    /**
     * Gets all users as JSON (limited information for security)
     *
     * @return JSON string containing all users
     */
    public String getAllUsersJson() {
        try {
            List<User> users = userService.getAllUsers();
            JSONArray jsonArray = new JSONArray();

            for (User user : users) {
                jsonArray.put(userToJson(user, false)); // Don't include sensitive data
            }

            JSONObject response = new JSONObject();
            response.put("success", true);
            response.put("data", jsonArray);
            response.put("total", users.size());

            LOGGER.info("Retrieved " + users.size() + " users via web service");
            return response.toString();

        } catch (Exception e) {
            LOGGER.severe("Error getting all users: " + e.getMessage());
            return createErrorResponse("Failed to retrieve users");
        }
    }

    /**
     * Updates user profile via JSON
     *
     * @param userId User ID to update
     * @param jsonData JSON string containing updated user data
     * @return JSON response string
     */
    public String updateUserProfileJson(int userId, String jsonData) {
        try {
            JSONObject jsonObject = new JSONObject(jsonData);

            String firstName = jsonObject.optString("firstName");
            String lastName = jsonObject.optString("lastName");
            String phone = jsonObject.optString("phone");

            // Update user profile
            boolean success = userService.updateUserProfile(userId, firstName, lastName, phone);

            if (success) {
                JSONObject response = new JSONObject();
                response.put("success", true);
                response.put("message", "User profile updated successfully");

                // Get updated user data
                User updatedUser = userService.getUserById(userId);
                if (updatedUser != null) {
                    response.put("data", userToJson(updatedUser, false));
                }

                LOGGER.info("Updated user profile via web service: " + userId);
                return response.toString();
            } else {
                return createErrorResponse("Failed to update user profile");
            }

        } catch (Exception e) {
            LOGGER.severe("Error updating user profile " + userId + ": " + e.getMessage());
            return createErrorResponse("Invalid user data");
        }
    }

    /**
     * Changes user password via JSON
     *
     * @param userId User ID
     * @param jsonData JSON string containing password change data
     * @return JSON response string
     */
    public String changePasswordJson(int userId, String jsonData) {
        try {
            JSONObject jsonObject = new JSONObject(jsonData);

            String currentPassword = jsonObject.optString("currentPassword");
            String newPassword = jsonObject.optString("newPassword");

            // Change password
            boolean success = userService.changePassword(userId, currentPassword, newPassword);

            if (success) {
                JSONObject response = new JSONObject();
                response.put("success", true);
                response.put("message", "Password changed successfully");

                LOGGER.info("Changed password via web service for user: " + userId);
                return response.toString();
            } else {
                return createErrorResponse("Failed to change password. Check current password.");
            }

        } catch (Exception e) {
            LOGGER.severe("Error changing password for user " + userId + ": " + e.getMessage());
            return createErrorResponse("Password change failed");
        }
    }

    /**
     * Initiates password reset via JSON
     *
     * @param jsonData JSON string containing email
     * @return JSON response string
     */
    public String initiatePasswordResetJson(String jsonData) {
        try {
            JSONObject jsonObject = new JSONObject(jsonData);
            String email = jsonObject.optString("email");

            String resetToken = userService.initiatePasswordReset(email);

            if (resetToken != null) {
                JSONObject response = new JSONObject();
                response.put("success", true);
                response.put("message", "Password reset initiated successfully");
                response.put("resetToken", resetToken); // In production, send via email

                LOGGER.info("Password reset initiated via web service for: " + email);
                return response.toString();
            } else {
                return createErrorResponse("Email not found or reset failed");
            }

        } catch (Exception e) {
            LOGGER.severe("Error initiating password reset: " + e.getMessage());
            return createErrorResponse("Password reset failed");
        }
    }

    /**
     * Completes password reset via JSON
     *
     * @param jsonData JSON string containing reset token and new password
     * @return JSON response string
     */
    public String completePasswordResetJson(String jsonData) {
        try {
            JSONObject jsonObject = new JSONObject(jsonData);

            String token = jsonObject.optString("token");
            String newPassword = jsonObject.optString("newPassword");

            boolean success = userService.completePasswordReset(token, newPassword);

            if (success) {
                JSONObject response = new JSONObject();
                response.put("success", true);
                response.put("message", "Password reset completed successfully");

                LOGGER.info("Password reset completed via web service");
                return response.toString();
            } else {
                return createErrorResponse("Invalid or expired reset token");
            }

        } catch (Exception e) {
            LOGGER.severe("Error completing password reset: " + e.getMessage());
            return createErrorResponse("Password reset failed");
        }
    }

    /**
     * Checks if email exists
     *
     * @param email Email to check
     * @return JSON response string
     */
    public String checkEmailExistsJson(String email) {
        try {
            boolean exists = userService.userExists(email);

            JSONObject response = new JSONObject();
            response.put("success", true);
            response.put("exists", exists);
            response.put("email", email);

            return response.toString();

        } catch (Exception e) {
            LOGGER.severe("Error checking email existence: " + e.getMessage());
            return createErrorResponse("Failed to check email");
        }
    }

    /**
     * Gets user statistics
     *
     * @return JSON string containing user statistics
     */
    public String getUserStatisticsJson() {
        try {
            List<User> allUsers = userService.getAllUsers();

            JSONObject stats = new JSONObject();
            stats.put("totalUsers", allUsers.size());
            stats.put("activeUsers", allUsers.stream().mapToInt(u -> u.isActive() ? 1 : 0).sum());

            JSONObject response = new JSONObject();
            response.put("success", true);
            response.put("data", stats);

            LOGGER.info("Generated user statistics via web service");
            return response.toString();

        } catch (Exception e) {
            LOGGER.severe("Error generating user statistics: " + e.getMessage());
            return createErrorResponse("Failed to generate statistics");
        }
    }

    /**
     * Converts User object to JSON
     *
     * @param user User object to convert
     * @param includeSensitive Whether to include sensitive information
     * @return JSONObject representation of the user
     */
    private JSONObject userToJson(User user, boolean includeSensitive) {
        JSONObject json = new JSONObject();

        json.put("userId", user.getUserId());
        json.put("email", user.getEmail());
        json.put("firstName", user.getFirstName());
        json.put("lastName", user.getLastName());
        json.put("fullName", user.getFullName());
        json.put("phone", user.getPhone());
        json.put("dateRegistered", user.getDateRegistered() != null ? user.getDateRegistered().toString() : null);
        json.put("isActive", user.isActive());

        if (includeSensitive) {
            json.put("lastLogin", user.getLastLogin() != null ? user.getLastLogin().toString() : null);
            // Note: Never include password hash in JSON responses
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
     * Validates user registration data
     *
     * @param email User email
     * @param password User password
     * @param firstName User first name
     * @param lastName User last name
     * @param phone User phone number
     * @return Validation error message or null if valid
     */
    public String validateRegistrationData(String email, String password, String firstName,
                                           String lastName, String phone) {
        return userService.validateRegistrationData(email, password, firstName, lastName, phone);
    }

    /**
     * Validates user login data
     *
     * @param email User email
     * @param password User password
     * @return Validation error message or null if valid
     */
    public String validateLoginData(String email, String password) {
        return userService.validateLoginData(email, password);
    }
}