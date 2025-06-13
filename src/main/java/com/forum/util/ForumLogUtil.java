package com.forum.util;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Utility class for logging forum activities to files
 * Logs comments and replies to separate log files as required
 *
 * @author Simphiwe Radebe
 * @version 1.0
 * @since 2025-06-03
 */
public class ForumLogUtil {

    /** Logger instance for logging operations */
    private static final Logger LOGGER = Logger.getLogger(ForumLogUtil.class.getName());

    /** Directory path for log files */
    private static final String LOG_DIRECTORY = "logs";

    /** Comment log file name */
    private static final String COMMENT_LOG_FILE = "comments.log";

    /** Reply log file name */
    private static final String REPLY_LOG_FILE = "replies.log";

    /** Date format for log entries */
    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    /** File separator for cross-platform compatibility */
    private static final String FILE_SEPARATOR = System.getProperty("file.separator");

    /**
     * Private constructor to prevent instantiation of utility class
     */
    private ForumLogUtil() {
        // Utility class should not be instantiated
    }

    /**
     * Initializes the log directory and files if they don't exist
     */
    private static void initializeLogDirectory() {
        File logDir = new File(LOG_DIRECTORY);
        if (!logDir.exists()) {
            boolean created = logDir.mkdirs();
            if (created) {
                LOGGER.info("Log directory created: " + LOG_DIRECTORY);
            } else {
                LOGGER.warning("Failed to create log directory: " + LOG_DIRECTORY);
            }
        }
    }

    /**
     * Logs a comment creation event to the comment log file
     *
     * @param commentId Comment ID
     * @param topicId Topic ID
     * @param userId User ID who posted the comment
     * @param userName User's full name
     * @param commentText Comment text content
     */
    public static void logComment(int commentId, int topicId, int userId,
                                  String userName, String commentText) {
        initializeLogDirectory();

        String logEntry = String.format("[%s] COMMENT_CREATED | CommentID: %d | TopicID: %d | UserID: %d | User: %s | Text: %s%n",
                DATE_FORMAT.format(new Date()), commentId, topicId, userId, userName,
                truncateText(commentText, 200));

        writeToLogFile(COMMENT_LOG_FILE, logEntry);
        LOGGER.info("Comment logged: ID " + commentId);
    }

    /**
     * Logs a reply creation event to the reply log file
     *
     * @param replyId Reply ID
     * @param commentId Comment ID
     * @param userId User ID who posted the reply
     * @param userName User's full name
     * @param replyText Reply text content
     */
    public static void logReply(int replyId, int commentId, int userId,
                                String userName, String replyText) {
        initializeLogDirectory();

        String logEntry = String.format("[%s] REPLY_CREATED | ReplyID: %d | CommentID: %d | UserID: %d | User: %s | Text: %s%n",
                DATE_FORMAT.format(new Date()), replyId, commentId, userId, userName,
                truncateText(replyText, 200));

        writeToLogFile(REPLY_LOG_FILE, logEntry);
        LOGGER.info("Reply logged: ID " + replyId);
    }

    /**
     * Logs a comment update event
     *
     * @param commentId Comment ID
     * @param userId User ID who updated the comment
     * @param userName User's full name
     * @param oldText Old comment text
     * @param newText New comment text
     */
    public static void logCommentUpdate(int commentId, int userId, String userName,
                                        String oldText, String newText) {
        initializeLogDirectory();

        String logEntry = String.format("[%s] COMMENT_UPDATED | CommentID: %d | UserID: %d | User: %s | OldText: %s | NewText: %s%n",
                DATE_FORMAT.format(new Date()), commentId, userId, userName,
                truncateText(oldText, 100), truncateText(newText, 100));

        writeToLogFile(COMMENT_LOG_FILE, logEntry);
        LOGGER.info("Comment update logged: ID " + commentId);
    }

    /**
     * Logs a reply update event
     *
     * @param replyId Reply ID
     * @param userId User ID who updated the reply
     * @param userName User's full name
     * @param oldText Old reply text
     * @param newText New reply text
     */
    public static void logReplyUpdate(int replyId, int userId, String userName,
                                      String oldText, String newText) {
        initializeLogDirectory();

        String logEntry = String.format("[%s] REPLY_UPDATED | ReplyID: %d | UserID: %d | User: %s | OldText: %s | NewText: %s%n",
                DATE_FORMAT.format(new Date()), replyId, userId, userName,
                truncateText(oldText, 100), truncateText(newText, 100));

        writeToLogFile(REPLY_LOG_FILE, logEntry);
        LOGGER.info("Reply update logged: ID " + replyId);
    }

    /**
     * Logs a comment deletion event
     *
     * @param commentId Comment ID
     * @param userId User ID who deleted the comment
     * @param userName User's full name
     */
    public static void logCommentDeletion(int commentId, int userId, String userName) {
        initializeLogDirectory();

        String logEntry = String.format("[%s] COMMENT_DELETED | CommentID: %d | UserID: %d | User: %s%n",
                DATE_FORMAT.format(new Date()), commentId, userId, userName);

        writeToLogFile(COMMENT_LOG_FILE, logEntry);
        LOGGER.info("Comment deletion logged: ID " + commentId);
    }

    /**
     * Logs a reply deletion event
     *
     * @param replyId Reply ID
     * @param userId User ID who deleted the reply
     * @param userName User's full name
     */
    public static void logReplyDeletion(int replyId, int userId, String userName) {
        initializeLogDirectory();

        String logEntry = String.format("[%s] REPLY_DELETED | ReplyID: %d | UserID: %d | User: %s%n",
                DATE_FORMAT.format(new Date()), replyId, userId, userName);

        writeToLogFile(REPLY_LOG_FILE, logEntry);
        LOGGER.info("Reply deletion logged: ID " + replyId);
    }

    /**
     * Logs a user registration event
     *
     * @param userId User ID
     * @param email User email
     * @param fullName User's full name
     */
    public static void logUserRegistration(int userId, String email, String fullName) {
        initializeLogDirectory();

        String logEntry = String.format("[%s] USER_REGISTERED | UserID: %d | Email: %s | Name: %s%n",
                DATE_FORMAT.format(new Date()), userId, email, fullName);

        writeToLogFile("users.log", logEntry);
        LOGGER.info("User registration logged: " + email);
    }

    /**
     * Logs a user login event
     *
     * @param userId User ID
     * @param email User email
     */
    public static void logUserLogin(int userId, String email) {
        initializeLogDirectory();

        String logEntry = String.format("[%s] USER_LOGIN | UserID: %d | Email: %s%n",
                DATE_FORMAT.format(new Date()), userId, email);

        writeToLogFile("users.log", logEntry);
        LOGGER.info("User login logged: " + email);
    }

    /**
     * Logs a topic creation event
     *
     * @param topicId Topic ID
     * @param userId User ID who created the topic
     * @param userName User's full name
     * @param title Topic title
     */
    public static void logTopicCreation(int topicId, int userId, String userName, String title) {
        initializeLogDirectory();

        String logEntry = String.format("[%s] TOPIC_CREATED | TopicID: %d | UserID: %d | User: %s | Title: %s%n",
                DATE_FORMAT.format(new Date()), topicId, userId, userName, truncateText(title, 100));

        writeToLogFile("topics.log", logEntry);
        LOGGER.info("Topic creation logged: ID " + topicId);
    }

    /**
     * Writes a log entry to the specified log file
     *
     * @param fileName Log file name
     * @param logEntry Log entry to write
     */
    private static void writeToLogFile(String fileName, String logEntry) {
        String filePath = LOG_DIRECTORY + FILE_SEPARATOR + fileName;

        try (FileWriter fileWriter = new FileWriter(filePath, true);
             BufferedWriter bufferedWriter = new BufferedWriter(fileWriter)) {

            bufferedWriter.write(logEntry);
            bufferedWriter.flush();

        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error writing to log file: " + filePath, e);
        }
    }

    /**
     * Truncates text to a specified maximum length for logging
     *
     * @param text Text to truncate
     * @param maxLength Maximum length
     * @return Truncated text
     */
    private static String truncateText(String text, int maxLength) {
        if (text == null) return "null";

        // Remove line breaks and extra spaces for cleaner logs
        String cleanText = text.replaceAll("\\r?\\n", " ").replaceAll("\\s+", " ").trim();

        if (cleanText.length() <= maxLength) {
            return cleanText;
        }

        return cleanText.substring(0, maxLength) + "...";
    }

    /**
     * Gets the log file path for a given log type
     *
     * @param logType Type of log (comment, reply, user, topic)
     * @return Full path to the log file
     */
    public static String getLogFilePath(String logType) {
        String fileName;
        switch (logType.toLowerCase()) {
            case "comment":
                fileName = COMMENT_LOG_FILE;
                break;
            case "reply":
                fileName = REPLY_LOG_FILE;
                break;
            case "user":
                fileName = "users.log";
                break;
            case "topic":
                fileName = "topics.log";
                break;
            default:
                fileName = "forum.log";
        }

        return LOG_DIRECTORY + FILE_SEPARATOR + fileName;
    }

    /**
     * Reads the last N lines from a log file
     *
     * @param logType Type of log to read
     * @param lineCount Number of lines to read
     * @return List of log entries
     */
    public static java.util.List<String> getRecentLogEntries(String logType, int lineCount) {
        java.util.List<String> entries = new java.util.ArrayList<>();
        String filePath = getLogFilePath(logType);

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            java.util.List<String> allLines = new java.util.ArrayList<>();
            String line;

            while ((line = reader.readLine()) != null) {
                allLines.add(line);
            }

            // Get the last N lines
            int startIndex = Math.max(0, allLines.size() - lineCount);
            for (int i = startIndex; i < allLines.size(); i++) {
                entries.add(allLines.get(i));
            }

        } catch (IOException e) {
            LOGGER.log(Level.WARNING, "Error reading log file: " + filePath, e);
        }

        return entries;
    }

    /**
     * Clears old log entries (older than specified days)
     *
     * @param logType Type of log to clean
     * @param daysToKeep Number of days to keep logs
     */
    public static void cleanOldLogEntries(String logType, int daysToKeep) {
        // Implementation for log rotation/cleanup
        // This would parse dates from log entries and remove old ones
        LOGGER.info("Log cleanup requested for " + logType + " (keeping " + daysToKeep + " days)");
        // Implementation details would go here
    }
}