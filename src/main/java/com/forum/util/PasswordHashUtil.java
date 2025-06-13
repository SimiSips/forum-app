package com.forum.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Utility class for password hashing and verification
 * Uses SHA-256 with salt for secure password storage
 *
 * @author Simphiwe Radebe
 * @version 1.0
 * @since 2025-06-03
 */
public class PasswordHashUtil {

    /** Logger instance for password operations */
    private static final Logger LOGGER = Logger.getLogger(PasswordHashUtil.class.getName());

    /** Hash algorithm to use */
    private static final String HASH_ALGORITHM = "SHA-256";

    /** Salt length in bytes */
    private static final int SALT_LENGTH = 16;

    /** Separator for salt and hash */
    private static final String SEPARATOR = ":";

    /**
     * Private constructor to prevent instantiation of utility class
     */
    private PasswordHashUtil() {
        // Utility class should not be instantiated
    }

    /**
     * Hashes a password using SHA-256 with a random salt
     *
     * @param password Plain text password to hash
     * @return Salted hash string in format "salt:hash"
     */
    public static String hashPassword(String password) {
        try {
            // Generate random salt
            SecureRandom secureRandom = new SecureRandom();
            byte[] salt = new byte[SALT_LENGTH];
            secureRandom.nextBytes(salt);

            // Hash password with salt
            MessageDigest messageDigest = MessageDigest.getInstance(HASH_ALGORITHM);
            messageDigest.update(salt);
            byte[] hashedPassword = messageDigest.digest(password.getBytes());

            // Encode salt and hash as Base64
            String saltString = Base64.getEncoder().encodeToString(salt);
            String hashString = Base64.getEncoder().encodeToString(hashedPassword);

            // Return combined salt:hash string
            String result = saltString + SEPARATOR + hashString;
            LOGGER.info("Password hashed successfully");
            return result;

        } catch (NoSuchAlgorithmException e) {
            LOGGER.log(Level.SEVERE, "Hash algorithm not available: " + HASH_ALGORITHM, e);
            throw new RuntimeException("Password hashing failed", e);
        }
    }

    /**
     * Verifies a password against a stored hash
     *
     * @param password Plain text password to verify
     * @param storedHash Stored hash in format "salt:hash"
     * @return true if password matches, false otherwise
     */
    public static boolean verifyPassword(String password, String storedHash) {
        try {
            // Split stored hash into salt and hash components
            String[] parts = storedHash.split(SEPARATOR);
            if (parts.length != 2) {
                LOGGER.warning("Invalid stored hash format");
                return false;
            }

            // Decode salt and hash from Base64
            byte[] salt = Base64.getDecoder().decode(parts[0]);
            byte[] storedPasswordHash = Base64.getDecoder().decode(parts[1]);

            // Hash the provided password with the same salt
            MessageDigest messageDigest = MessageDigest.getInstance(HASH_ALGORITHM);
            messageDigest.update(salt);
            byte[] hashedPassword = messageDigest.digest(password.getBytes());

            // Compare the hashes
            boolean isValid = MessageDigest.isEqual(hashedPassword, storedPasswordHash);

            if (isValid) {
                LOGGER.info("Password verification successful");
            } else {
                LOGGER.warning("Password verification failed");
            }

            return isValid;

        } catch (NoSuchAlgorithmException e) {
            LOGGER.log(Level.SEVERE, "Hash algorithm not available: " + HASH_ALGORITHM, e);
            return false;
        } catch (IllegalArgumentException e) {
            LOGGER.log(Level.WARNING, "Invalid Base64 encoding in stored hash", e);
            return false;
        }
    }

    /**
     * Validates password strength
     *
     * @param password Password to validate
     * @return true if password meets strength requirements, false otherwise
     */
    public static boolean isPasswordStrong(String password) {
        if (password == null || password.length() < 8) {
            return false;
        }

        boolean hasUppercase = false;
        boolean hasLowercase = false;
        boolean hasDigit = false;
        boolean hasSpecialChar = false;

        for (char c : password.toCharArray()) {
            if (Character.isUpperCase(c)) {
                hasUppercase = true;
            } else if (Character.isLowerCase(c)) {
                hasLowercase = true;
            } else if (Character.isDigit(c)) {
                hasDigit = true;
            } else if (!Character.isWhitespace(c)) {
                hasSpecialChar = true;
            }
        }

        return hasUppercase && hasLowercase && hasDigit && hasSpecialChar;
    }

    /**
     * Generates a random password reset token
     *
     * @return Random token string
     */
    public static String generateResetToken() {
        SecureRandom secureRandom = new SecureRandom();
        byte[] tokenBytes = new byte[32];
        secureRandom.nextBytes(tokenBytes);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(tokenBytes);
    }

    /**
     * Gets password strength requirements as a string
     *
     * @return String describing password requirements
     */
    public static String getPasswordRequirements() {
        return "Password must be at least 8 characters long and contain at least one uppercase letter, " +
                "one lowercase letter, one digit, and one special character.";
    }
}