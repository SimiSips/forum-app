package com.forum.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Database configuration class for managing database connections
 * Implements singleton pattern for efficient connection management
 *
 * @author Simphiwe Radebe
 * @version 1.2
 * @since 2025-06-03
 */
public class DatabaseConfig {

    /** Logger instance for database operations */
    private static final Logger LOGGER = Logger.getLogger(DatabaseConfig.class.getName());

    /** Database connection URL */
    private static final String DATABASE_URL = "jdbc:mysql://localhost:3306/forum_db";

    /** Database username */
    private static final String DATABASE_USERNAME = "forum_user";

    /** Database password */
    private static final String DATABASE_PASSWORD = "forum_password_2025";

    /** MySQL JDBC driver class name */
    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";

    /** Singleton instance */
    private static DatabaseConfig instance;

    /**
     * Private constructor to prevent direct instantiation
     * Loads the MySQL JDBC driver
     */
    private DatabaseConfig() {
        try {
            Class.forName(JDBC_DRIVER);
            LOGGER.info("MySQL JDBC Driver loaded successfully");
        } catch (ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Failed to load MySQL JDBC Driver", e);
            throw new RuntimeException("Database driver not found", e);
        }
    }

    /**
     * Gets the singleton instance of DatabaseConfig
     *
     * @return DatabaseConfig singleton instance
     */
    public static synchronized DatabaseConfig getInstance() {
        if (instance == null) {
            instance = new DatabaseConfig();
        }
        return instance;
    }

    /**
     * Establishes and returns a database connection
     *
     * @return Connection object to the database
     * @throws SQLException if connection cannot be established
     */
    public Connection getConnection() throws SQLException {
        try {
            Connection connection = DriverManager.getConnection(
                    DATABASE_URL, DATABASE_USERNAME, DATABASE_PASSWORD);
            LOGGER.info("Database connection established successfully");
            return connection;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Failed to establish database connection", e);
            throw e;
        }
    }

    /**
     * Safely closes a database connection
     *
     * @param connection Connection to close
     */
    public void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
                LOGGER.info("Database connection closed successfully");
            } catch (SQLException e) {
                LOGGER.log(Level.WARNING, "Error closing database connection", e);
            }
        }
    }

    /**
     * Tests the database connection
     *
     * @return true if connection is successful, false otherwise
     */
    public boolean testConnection() {
        try (Connection connection = getConnection()) {
            return connection != null && !connection.isClosed();
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "Database connection test failed", e);
            return false;
        }
    }
}