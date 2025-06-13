package com.forum.dao;

import com.forum.config.DatabaseConfig;
import com.forum.model.User;
import com.forum.util.PasswordHashUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object (DAO) for User entity
 * Handles all database operations related to users
 *
 * @author Simphiwe Radebe
 * @version 1.0
 * @since 2025-06-03
 */
public class UserDAO {

    /** Logger instance for database operations */
    private static final Logger LOGGER = Logger.getLogger(UserDAO.class.getName());

    /** Database configuration instance */
    private final DatabaseConfig databaseConfig;

    /**
     * Constructor to initialize UserDAO with database configuration
     */
    public UserDAO() {
        this.databaseConfig = DatabaseConfig.getInstance();
    }

    /**
     * Creates a new user in the database
     *
     * @param user User object to create
     * @return true if user created successfully, false otherwise
     */
    public boolean createUser(User user) {
        String sql = "INSERT INTO users (email, password_hash, first_name, last_name, phone) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            // Hash the password before storing
            String hashedPassword = PasswordHashUtil.hashPassword(user.getPasswordHash());

            // Set parameters
            statement.setString(1, user.getEmail());
            statement.setString(2, hashedPassword);
            statement.setString(3, user.getFirstName());
            statement.setString(4, user.getLastName());
            statement.setString(5, user.getPhone());

            // Execute insert
            int rowsAffected = statement.executeUpdate();

            // Get generated user ID
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        user.setUserId(generatedKeys.getInt(1));
                        LOGGER.info("User created successfully with ID: " + user.getUserId());
                        return true;
                    }
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating user: " + user.getEmail(), e);
        }

        return false;
    }

    /**
     * Retrieves a user by email address
     *
     * @param email Email address to search for
     * @return User object if found, null otherwise
     */
    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ? AND is_active = TRUE";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapResultSetToUser(resultSet);
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving user by email: " + email, e);
        }

        return null;
    }

    /**
     * Retrieves a user by user ID
     *
     * @param userId User ID to search for
     * @return User object if found, null otherwise
     */
    public User getUserById(int userId) {
        String sql = "SELECT * FROM users WHERE user_id = ? AND is_active = TRUE";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapResultSetToUser(resultSet);
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving user by ID: " + userId, e);
        }

        return null;
    }

    /**
     * Updates user information in the database
     *
     * @param user User object with updated information
     * @return true if update successful, false otherwise
     */
    public boolean updateUser(User user) {
        String sql = "UPDATE users SET first_name = ?, last_name = ?, phone = ? WHERE user_id = ?";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, user.getFirstName());
            statement.setString(2, user.getLastName());
            statement.setString(3, user.getPhone());
            statement.setInt(4, user.getUserId());

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                LOGGER.info("User updated successfully: " + user.getUserId());
                return true;
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating user: " + user.getUserId(), e);
        }

        return false;
    }

    /**
     * Updates user password in the database
     *
     * @param userId User ID
     * @param newPassword New password (will be hashed)
     * @return true if password updated successfully, false otherwise
     */
    public boolean updatePassword(int userId, String newPassword) {
        String sql = "UPDATE users SET password_hash = ? WHERE user_id = ?";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            // Hash the new password
            String hashedPassword = PasswordHashUtil.hashPassword(newPassword);

            statement.setString(1, hashedPassword);
            statement.setInt(2, userId);

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                LOGGER.info("Password updated successfully for user: " + userId);
                return true;
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating password for user: " + userId, e);
        }

        return false;
    }

    /**
     * Validates user login credentials
     *
     * @param email User email
     * @param password User password
     * @return User object if credentials valid, null otherwise
     */
    public User validateLogin(String email, String password) {
        User user = getUserByEmail(email);

        if (user != null) {
            // Verify password
            if (PasswordHashUtil.verifyPassword(password, user.getPasswordHash())) {
                // Update last login timestamp
                updateLastLogin(user.getUserId());
                LOGGER.info("User login successful: " + email);
                return user;
            } else {
                LOGGER.warning("Invalid password for user: " + email);
            }
        } else {
            LOGGER.warning("User not found: " + email);
        }

        return null;
    }

    /**
     * Updates the last login timestamp for a user
     *
     * @param userId User ID
     */
    private void updateLastLogin(int userId) {
        String sql = "UPDATE users SET last_login = CURRENT_TIMESTAMP WHERE user_id = ?";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);
            statement.executeUpdate();

        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "Error updating last login for user: " + userId, e);
        }
    }

    /**
     * Sets password reset token for a user
     *
     * @param email User email
     * @param token Reset token
     * @param expiryTime Token expiry time
     * @return true if token set successfully, false otherwise
     */
    public boolean setPasswordResetToken(String email, String token, Timestamp expiryTime) {
        String sql = "UPDATE users SET password_reset_token = ?, password_reset_expires = ? WHERE email = ?";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, token);
            statement.setTimestamp(2, expiryTime);
            statement.setString(3, email);

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                LOGGER.info("Password reset token set for user: " + email);
                return true;
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error setting password reset token for user: " + email, e);
        }

        return false;
    }

    /**
     * Validates password reset token
     *
     * @param token Reset token
     * @return User object if token valid, null otherwise
     */
    public User validatePasswordResetToken(String token) {
        String sql = "SELECT * FROM users WHERE password_reset_token = ? AND password_reset_expires > CURRENT_TIMESTAMP";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, token);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapResultSetToUser(resultSet);
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error validating password reset token", e);
        }

        return null;
    }

    /**
     * Clears password reset token after use
     *
     * @param userId User ID
     * @return true if token cleared successfully, false otherwise
     */
    public boolean clearPasswordResetToken(int userId) {
        String sql = "UPDATE users SET password_reset_token = NULL, password_reset_expires = NULL WHERE user_id = ?";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                LOGGER.info("Password reset token cleared for user: " + userId);
                return true;
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error clearing password reset token for user: " + userId, e);
        }

        return false;
    }

    /**
     * Checks if email already exists in the database
     *
     * @param email Email to check
     * @return true if email exists, false otherwise
     */
    public boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt(1) > 0;
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error checking if email exists: " + email, e);
        }

        return false;
    }

    /**
     * Retrieves all active users from the database
     *
     * @return List of User objects
     */
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE is_active = TRUE ORDER BY first_name, last_name";

        try (Connection connection = databaseConfig.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                users.add(mapResultSetToUser(resultSet));
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving all users", e);
        }

        return users;
    }

    /**
     * Maps ResultSet to User object
     *
     * @param resultSet ResultSet from database query
     * @return User object
     * @throws SQLException if error occurs during mapping
     */
    private User mapResultSetToUser(ResultSet resultSet) throws SQLException {
        User user = new User();

        user.setUserId(resultSet.getInt("user_id"));
        user.setEmail(resultSet.getString("email"));
        user.setPasswordHash(resultSet.getString("password_hash"));
        user.setFirstName(resultSet.getString("first_name"));
        user.setLastName(resultSet.getString("last_name"));
        user.setPhone(resultSet.getString("phone"));
        user.setDateRegistered(resultSet.getTimestamp("date_registered"));
        user.setLastLogin(resultSet.getTimestamp("last_login"));
        user.setActive(resultSet.getBoolean("is_active"));
        user.setPasswordResetToken(resultSet.getString("password_reset_token"));
        user.setPasswordResetExpires(resultSet.getTimestamp("password_reset_expires"));

        return user;
    }
}