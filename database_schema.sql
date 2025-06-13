-- Forum Database Schema
-- Creates all required tables with proper relationships and constraints

CREATE DATABASE IF NOT EXISTS forum_db;
USE forum_db;

-- Users table to store user registration information
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    date_registered TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    is_active BOOLEAN DEFAULT TRUE,
    password_reset_token VARCHAR(255) NULL,
    password_reset_expires TIMESTAMP NULL
);

-- Topics table to store forum topics
CREATE TABLE topics (
    topic_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    user_id INT NOT NULL,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_activity TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Comments table to store comments on topics
CREATE TABLE comments (
    comment_id INT PRIMARY KEY AUTO_INCREMENT,
    topic_id INT NOT NULL,
    user_id INT NOT NULL,
    comment_text TEXT NOT NULL,
    date_posted TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (topic_id) REFERENCES topics(topic_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Replies table to store replies to comments
CREATE TABLE replies (
    reply_id INT PRIMARY KEY AUTO_INCREMENT,
    comment_id INT NOT NULL,
    user_id INT NOT NULL,
    reply_text TEXT NOT NULL,
    date_posted TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (comment_id) REFERENCES comments(comment_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Create indexes for better performance
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_topics_user ON topics(user_id);
CREATE INDEX idx_comments_topic ON comments(topic_id);
CREATE INDEX idx_comments_user ON comments(user_id);
CREATE INDEX idx_replies_comment ON replies(comment_id);
CREATE INDEX idx_replies_user ON replies(user_id);

-- Insert sample data for testing
INSERT INTO users (email, password_hash, first_name, last_name, phone) VALUES
('admin@forum.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBfBx9rE4w8H2i', 'Admin', 'User', '0123456789'),
('john.doe@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBfBx9rE4w8H2i', 'John', 'Doe', '0987654321'),
('jane.smith@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBfBx9rE4w8H2i', 'Jane', 'Smith', '0555123456');

INSERT INTO topics (title, description, user_id) VALUES
('Welcome to the Forum', 'This is a welcome topic for new users to introduce themselves.', 1),
('Java Programming Tips', 'Share your best Java programming tips and tricks here.', 2),
('Database Design Best Practices', 'Discuss database design patterns and best practices.', 1);

INSERT INTO comments (topic_id, user_id, comment_text) VALUES
(1, 2, 'Hello everyone! Happy to be part of this community.'),
(1, 3, 'Welcome John! Looking forward to your contributions.'),
(2, 1, 'Always remember to use meaningful variable names in your code.'),
(3, 2, 'Normalization is key to good database design.');

INSERT INTO replies (comment_id, user_id, reply_text) VALUES
(1, 1, 'Welcome to the forum John! Feel free to ask any questions.'),
(2, 2, 'Thank you Jane! I appreciate the warm welcome.'),
(3, 3, 'Great tip! Also important to follow naming conventions.'),
(4, 1, 'Absolutely! And don\'t forget about proper indexing.');