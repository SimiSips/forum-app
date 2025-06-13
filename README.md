# Forum Application - User Documentation

## Overview

This Forum Application is a comprehensive distributed web application developed using Advanced Java Programming concepts. It provides a platform for users to create topics, post comments, and engage in discussions through a modern web interface.

**Developer:** Simphiwe Radebe  
**Course:** Advanced Java Programming Assessments  
**Module Code:** ITHCA0  
**Project:** Project 1 - Distributed Applications

## Features

### Core Functionality
- ✅ User Registration and Authentication
- ✅ Secure Login/Logout System
- ✅ Password Reset Functionality
- ✅ User Profile Management
- ✅ Topic Creation and Management
- ✅ Comment System with Replies
- ✅ Real-time Activity Logging
- ✅ Search Functionality
- ✅ Responsive Web Design

### Technical Implementation
- **Frontend:** JSP/Servlets with Bootstrap 5
- **Backend:** Java with DAO Pattern
- **Database:** MySQL with proper relationships
- **Web Services:** RESTful API endpoints
- **Security:** Password hashing, input validation
- **Logging:** Comprehensive activity logging

## Installation Guide

### Prerequisites
- Java 8 or higher
- Apache Tomcat 9.0 or higher
- MySQL 8.0 or higher
- Maven 3.6 or higher
- Web browser (Chrome, Firefox, Safari, Edge)

### Step 1: Database Setup

1. **Install MySQL** and create a new database:
```sql
CREATE DATABASE forum_db;
```

2. **Run the database schema** (database_schema.sql):
```bash
mysql -u root -p forum_db < database_schema.sql
```

3. **Update database configuration** in `DatabaseConfig.java`:
```java
private static final String DATABASE_URL = "jdbc:mysql://localhost:3306/forum_db";
private static final String DATABASE_USERNAME = "your_username";
private static final String DATABASE_PASSWORD = "your_password";
```

### Step 2: Application Deployment

1. **Clone or extract** the project files to your workspace

2. **Build the project** using Maven:
```bash
mvn clean compile package
```

3. **Deploy to Tomcat:**
    - Copy the generated WAR file to Tomcat's `webapps` directory
    - Or deploy directly through Tomcat Manager

4. **Start Tomcat server:**
```bash
./catalina.sh start  # Linux/Mac
catalina.bat start   # Windows
```

### Step 3: Database Driver Configuration

1. **Download MySQL Connector/J** (version 8.0 or higher)
2. **Place the JAR file** in:
    - `WEB-INF/lib/` directory of your application, OR
    - Tomcat's `lib` directory for server-wide availability

### Step 4: Application Configuration

1. **Verify web.xml configuration** matches your environment
2. **Check log directory permissions** (application creates `logs/` folder)
3. **Test database connection** by accessing the application

## Usage Guide

### Getting Started

1. **Access the application:**
   ```
   http://localhost:8080/forum-app/
   ```

2. **Register a new account:**
    - Click "Create one here" on the login page
    - Fill in all required information
    - Password must meet security requirements:
        - At least 8 characters
        - Contains uppercase and lowercase letters
        - Contains at least one digit
        - Contains at least one special character

3. **Login to your account:**
    - Use your email and password
    - Optional: Check "Remember me" for extended sessions

### Main Features

#### Topic Management
- **Creating Topics:**
    - Click "Create New Topic" button
    - Enter a descriptive title (max 255 characters)
    - Provide detailed description (max 5000 characters)
    - Submit to publish your topic

- **Viewing Topics:**
    - Browse topics on the main page
    - Click topic title to view full discussion
    - See comment count and last activity

- **Searching Topics:**
    - Use the search box in the navigation
    - Search by title or description content

#### Comments and Replies
- **Posting Comments:**
    - Open any topic
    - Scroll to comment section
    - Enter your comment (max 2000 characters)
    - Submit to post

- **Replying to Comments:**
    - Click "Reply" on any comment
    - Enter your reply (max 1000 characters)
    - Submit to post reply

#### User Profile
- **Updating Profile:**
    - Click your name in navigation → Profile
    - Update first name, last name, phone number
    - Save changes

- **Changing Password:**
    - Go to Profile page
    - Enter current password and new password
    - Confirm new password and save

#### Password Recovery
- **Forgot Password:**
    - Click "Forgot password?" on login page
    - Enter your email address
    - Follow reset instructions (token provided for demo)

### Navigation

#### Main Navigation Menu
- **Home:** Returns to main topic list
- **My Topics:** Shows topics you've created
- **Search:** Find topics by keywords
- **Profile:** Manage your account settings
- **Logout:** End your session securely

#### Topic Sorting Options
- **Latest:** Most recently active topics first
- **Popular:** Topics with most comments first
- **Oldest:** Oldest topics first

## Web Services API

The application provides RESTful web services for external integration:

### Base URL
```
http://localhost:8080/forum-app/api/
```

### Available Endpoints

#### User Management
- `POST /api/users` - Create new user
- `GET /api/users/{id}` - Get user by ID
- `PUT /api/users/{id}` - Update user information

#### Topic Management
- `GET /api/topics` - Get all topics
- `POST /api/topics` - Create new topic
- `GET /api/topics/{id}` - Get topic by ID
- `PUT /api/topics/{id}` - Update topic
- `DELETE /api/topics/{id}` - Delete topic

#### Comment Management
- `GET /api/comments/topic/{topicId}` - Get comments for topic
- `POST /api/comments` - Create new comment
- `PUT /api/comments/{id}` - Update comment
- `DELETE /api/comments/{id}` - Delete comment

#### Reply Management
- `GET /api/replies/comment/{commentId}` - Get replies for comment
- `POST /api/replies` - Create new reply
- `PUT /api/replies/{id}` - Update reply
- `DELETE /api/replies/{id}` - Delete reply

### Example API Usage

#### Create New Topic
```bash
curl -X POST http://localhost:8080/forum-app/api/topics \
  -H "Content-Type: application/json" \
  -d '{
    "title": "New Discussion Topic",
    "description": "This is a sample topic created via API",
    "userId": 1
  }'
```

#### Get All Topics
```bash
curl -X GET http://localhost:8080/forum-app/api/topics \
  -H "Accept: application/json"
```

## Security Features

### Authentication & Authorization
- **Session Management:** Secure session handling with timeouts
- **Password Security:** BCrypt hashing with salt
- **Input Validation:** XSS and injection attack prevention
- **Access Control:** Users can only modify their own content

### Data Protection
- **SQL Injection Prevention:** Prepared statements used throughout
- **Cross-Site Scripting (XSS) Protection:** Input sanitization
- **CSRF Protection:** Token-based form submissions
- **Secure Headers:** Proper HTTP security headers

## Logging System

The application maintains comprehensive logs for all activities:

### Log Files Location
```
logs/
├── comments.log    # Comment creation, updates, deletions
├── replies.log     # Reply creation, updates, deletions
├── users.log       # User registration, login activities
└── topics.log      # Topic creation and management
```

### Log Entry Format
```
[2025-06-03 14:30:25] EVENT_TYPE | EntityID: 123 | UserID: 45 | User: John Doe | Details...
```

### Example Log Entries
```
[2025-06-03 14:30:25] COMMENT_CREATED | CommentID: 15 | TopicID: 3 | UserID: 2 | User: Jane Smith | Text: Great discussion topic!
[2025-06-03 14:35:10] REPLY_CREATED | ReplyID: 8 | CommentID: 15 | UserID: 1 | User: John Doe | Text: I completely agree!
[2025-06-03 14:40:05] USER_LOGIN | UserID: 3 | Email: admin@forum.com
```

## Troubleshooting

### Common Issues

#### Database Connection Problems
**Symptom:** Application fails to start or shows database errors
**Solutions:**
1. Verify MySQL service is running
2. Check database credentials in `DatabaseConfig.java`
3. Ensure MySQL JDBC driver is in classpath
4. Verify database exists and schema is applied

#### Login Issues
**Symptom:** Cannot log in with correct credentials
**Solutions:**
1. Check if user account exists in database
2. Verify password meets strength requirements
3. Clear browser cookies and try again
4. Check server logs for authentication errors

#### File Upload/Logging Issues
**Symptom:** Cannot create topics or comments
**Solutions:**
1. Check write permissions on application directory
2. Verify `logs/` directory exists or can be created
3. Check disk space availability
4. Review application server logs

#### Session Timeout Problems
**Symptom:** Frequent logouts or session expired messages
**Solutions:**
1. Increase session timeout in `web.xml`
2. Check server memory allocation
3. Verify session configuration
4. Clear browser cache

### Performance Optimization

#### Database Performance
- **Indexing:** Ensure proper indexes on frequently queried columns
- **Connection Pooling:** Configure connection pool in application server
- **Query Optimization:** Review slow query logs

#### Application Performance
- **Memory Management:** Monitor heap usage and garbage collection
- **Caching:** Implement caching for frequently accessed data
- **Static Resources:** Use CDN for CSS/JS files in production

## Development Information

### Project Structure
```
src/
├── main/
│   ├── java/
│   │   └── com/forum/
│   │       ├── config/          # Database configuration
│   │       ├── dao/             # Data Access Objects
│   │       ├── filter/          # Servlet filters
│   │       ├── listener/        # Event listeners
│   │       ├── model/           # Data models
│   │       ├── service/         # Business logic
│   │       ├── servlet/         # Web controllers
│   │       ├── util/            # Utility classes
│   │       └── webservice/      # REST API endpoints
│   ├── resources/               # Configuration files
│   └── webapp/
│       ├── WEB-INF/
│       │   ├── jsp/             # JSP pages
│       │   └── web.xml          # Web configuration
│       ├── css/                 # Stylesheets
│       ├── js/                  # JavaScript files
│       └── images/              # Image assets
```

### Technology Stack
- **Java Version:** 8+
- **Servlet API:** 4.0
- **JSP Version:** 2.3
- **Database:** MySQL 8.0
- **Build Tool:** Maven 3.6+
- **Web Server:** Apache Tomcat 9.0+
- **Frontend:** Bootstrap 5, Font Awesome 6
- **Logging:** Java Util Logging

### Code Quality Standards
- **Documentation:** Comprehensive JavaDoc for all classes and methods
- **Naming Conventions:** JavaBeans naming standards followed
- **Error Handling:** Try-catch blocks for all database operations
- **Input Validation:** Server-side validation for all user inputs
- **Code Organization:** Proper separation of concerns (MVC pattern)

## Support and Maintenance

### Regular Maintenance Tasks
1. **Database Backup:** Schedule regular database backups
2. **Log Rotation:** Implement log file rotation to manage disk space
3. **Security Updates:** Keep all dependencies updated
4. **Performance Monitoring:** Monitor application performance metrics

### Backup Procedures
```bash
# Database backup
mysqldump -u username -p forum_db > forum_backup_$(date +%Y%m%d).sql

# Application backup
tar -czf forum_app_backup_$(date +%Y%m%d).tar.gz /path/to/forum-app/
```

### Monitoring
- **Application Logs:** Monitor application logs for errors
- **Database Performance:** Watch for slow queries and connection issues
- **User Activity:** Track user engagement and system usage
- **Security Events:** Monitor for suspicious activities

## Contact Information

**Developer:** Simphiwe Radebe  
**Institution:** Eduvos  
**Course:** Advanced Java Programming (ITHCA0)  
**Project Submission:** Week 6

For technical support or questions about this application, please refer to the source code documentation or contact the development team.

## License and Usage Rights

This application is developed as an academic project for educational purposes. All code and documentation are original work created specifically for the Advanced Java Programming course requirements.

**Note:** This application is designed for educational and demonstration purposes. For production deployment, additional security hardening and performance optimization should be implemented.

---

*Last Updated: June 3, 2025*  
*Version: 1.0.0*