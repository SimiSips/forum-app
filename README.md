# Forum Application

[![Java](https://img.shields.io/badge/Java-11+-blue.svg)](https://www.oracle.com/java/)
[![Maven](https://img.shields.io/badge/Maven-3.6+-red.svg)](https://maven.apache.org/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0+-orange.svg)](https://www.mysql.com/)
[![Tomcat](https://img.shields.io/badge/Tomcat-9.0+-yellow.svg)](https://tomcat.apache.org/)

## Overview

The Forum Application is a comprehensive distributed web application developed using Advanced Java Programming concepts. It provides a robust platform for users to create topics, post comments, engage in discussions, and share knowledge through a modern, responsive web interface.

**Developer:** Simphiwe Radebe  
**Course:** Advanced Java Programming (ITHCA0)  
**Institution:** Eduvos  
**Project:** Project 1 - Distributed Applications  
**Version:** 1.0.0

## 🚀 Quick Start

### Prerequisites
- Java 11 or higher
- Apache Maven 3.6+
- MySQL 8.0+
- Apache Tomcat 9.0+

### Automated Deployment
```bash
# Clone the repository
git clone <repository-url> forum-app
cd forum-app

# Set up environment variable
export CATALINA_HOME=/path/to/your/tomcat

# Run the automated deployment script
chmod +x deploy.sh
./deploy.sh
```

### Manual Build and Deploy
```bash
# Build the project
mvn clean compile package

# Deploy to Tomcat
rm -rf $CATALINA_HOME/webapps/forum-app*
cp target/forum-app.war $CATALINA_HOME/webapps/

# Start Tomcat and view logs
$CATALINA_HOME/bin/catalina.sh start
tail -f $CATALINA_HOME/logs/catalina.out
```

**Access the application:** http://localhost:8080/forum-app/

## 📚 Documentation

### Complete Guides
- **[Installation Guide](INSTALLATION_GUIDE.md)** - Comprehensive setup instructions
- **[User Guide](USER_GUIDE.md)** - Complete user documentation and tutorials
- **[API Documentation](http://localhost:8080/forum-app/api)** - RESTful API reference

### Quick Links
- [Database Setup](#database-setup)
- [Features Overview](#features)
- [Technology Stack](#technology-stack)
- [Project Structure](#project-structure)

## ✨ Features

### Core Functionality
- ✅ **User Management**
    - Secure registration and authentication
    - Password reset functionality
    - Profile management and updates
    - Session management with "Remember Me"

- ✅ **Forum Features**
    - Topic creation and management
    - Nested comment system with replies
    - Real-time search functionality
    - Activity logging and tracking

- ✅ **Technical Features**
    - RESTful API endpoints
    - Responsive Bootstrap 5 UI
    - MySQL database with proper relationships
    - Input validation and security measures
    - Comprehensive error handling

### Advanced Capabilities
- **Web Services Integration:** RESTful API for all major operations
- **Security:** Password hashing, input sanitization, SQL injection prevention
- **Logging:** Comprehensive activity logging for all user actions
- **Responsive Design:** Mobile-friendly interface that adapts to all screen sizes
- **Search:** Full-text search across topics and descriptions

## 🛠 Technology Stack

### Backend
- **Java 11+** - Core programming language
- **Servlets & JSP** - Web framework
- **Maven** - Build tool and dependency management
- **MySQL 8.0** - Database management system
- **JDBC** - Database connectivity

### Frontend
- **Bootstrap 5** - CSS framework for responsive design
- **Font Awesome 6** - Icon library
- **JavaScript/jQuery** - Client-side interactivity
- **JSP/JSTL** - Server-side templating

### Infrastructure
- **Apache Tomcat 9.0+** - Application server
- **MySQL Connector/J** - Database driver
- **Java Util Logging** - Application logging

## 📁 Project Structure

```
forum-app/
├── src/
│   ├── main/
│   │   ├── java/com/forum/
│   │   │   ├── config/          # Database configuration
│   │   │   ├── dao/             # Data Access Objects
│   │   │   ├── filter/          # Security and request filters
│   │   │   ├── listener/        # Application event listeners
│   │   │   ├── model/           # Data models and entities
│   │   │   ├── service/         # Business logic layer
│   │   │   ├── servlet/         # Web controllers
│   │   │   ├── util/            # Utility classes
│   │   │   └── webservice/      # REST API endpoints
│   │   ├── resources/           # Configuration files
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   ├── jsp/         # JSP pages and templates
│   │       │   └── web.xml      # Web application configuration
│   │       ├── css/             # Custom stylesheets
│   │       ├── js/              # JavaScript files
│   │       └── images/          # Static image assets
│   └── test/                    # Unit and integration tests
├── database_schema.sql          # Database creation script
├── deploy.sh                    # Automated deployment script
├── pom.xml                      # Maven project configuration
├── INSTALLATION_GUIDE.md        # Comprehensive installation guide
├── USER_GUIDE.md               # Complete user documentation
└── README.md                   # This file
```

## 🗄 Database Setup

### Quick Database Setup
```sql
-- Create database and user
CREATE DATABASE forum_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'forum_user'@'localhost' IDENTIFIED BY 'forum_password_2025';
GRANT ALL PRIVILEGES ON forum_db.* TO 'forum_user'@'localhost';
FLUSH PRIVILEGES;

-- Import schema
mysql -u forum_user -p forum_db < database_schema.sql
```

### Database Schema
The application uses a normalized database schema with the following main entities:
- **users** - User accounts and authentication
- **topics** - Forum discussion topics
- **comments** - Comments on topics
- **replies** - Replies to comments

For detailed schema information, see [database_schema.sql](database_schema.sql).

## 🔧 Configuration

### Database Configuration
Update database settings in `src/main/java/com/forum/config/DatabaseConfig.java`:
```java
private static final String DATABASE_URL = "jdbc:mysql://localhost:3306/forum_db";
private static final String DATABASE_USERNAME = "forum_user";
private static final String DATABASE_PASSWORD = "forum_password_2025";
```

### Application Properties
Configuration options in `src/main/resources/application.properties`:
```properties
db.url=jdbc:mysql://localhost:3306/forum_db
db.username=forum_user
db.password=forum_password_2025
app.name=Forum Application
log.level=INFO
```

## 🚀 Deployment Options

### 1. Automated Deployment (Recommended)
Use the provided deployment script for quick and reliable deployments:
```bash
./deploy.sh                 # Full deployment with restart
./deploy.sh --no-restart    # Deploy without restarting Tomcat
./deploy.sh --logs-only     # View logs only
```

### 2. Manual Deployment
For manual control over the deployment process:
```bash
mvn clean compile package
rm -rf $CATALINA_HOME/webapps/forum-app*
cp target/forum-app.war $CATALINA_HOME/webapps/
$CATALINA_HOME/bin/catalina.sh restart
```

### 3. IDE Integration
- **IntelliJ IDEA:** Configure Tomcat server in Run Configurations
- **Eclipse:** Use Server adapter for Tomcat deployment
- **VS Code:** Use Java Extension Pack with Tomcat integration

## 📊 API Endpoints

The application provides RESTful API endpoints for integration:

### User Management
```
GET    /api/users          # List all users
POST   /api/users          # Create new user
GET    /api/users/{id}     # Get user details
PUT    /api/users/{id}     # Update user
DELETE /api/users/{id}     # Delete user
```

### Topic Management
```
GET    /api/topics         # List all topics
POST   /api/topics         # Create new topic
GET    /api/topics/{id}    # Get topic details
PUT    /api/topics/{id}    # Update topic
DELETE /api/topics/{id}    # Delete topic
```

### Comment Management
```
GET    /api/comments       # Get comments for topic
POST   /api/comments       # Create new comment
PUT    /api/comments/{id}  # Update comment
DELETE /api/comments/{id}  # Delete comment
```

For complete API documentation, visit: http://localhost:8080/forum-app/api

## 🧪 Testing

### Running Tests
```bash
# Run all tests
mvn test

# Run specific test class
mvn test -Dtest=UserServiceTest

# Run tests with coverage report
mvn test jacoco:report
```

### Test Categories
- **Unit Tests:** Test individual components and methods
- **Integration Tests:** Test database operations and services
- **Web Tests:** Test servlet functionality and HTTP responses

## 🔒 Security Features

### Implemented Security Measures
- **Password Hashing:** BCrypt hashing for secure password storage
- **Input Validation:** Server-side validation for all user inputs
- **SQL Injection Prevention:** Parameterized queries throughout
- **Session Management:** Secure session handling with configurable timeouts
- **CSRF Protection:** Form token validation for state-changing operations
- **XSS Prevention:** Input sanitization and output encoding

### Security Configuration
Session timeout and security settings in `web.xml`:
```xml
<session-config>
    <session-timeout>30</session-timeout>
    <cookie-config>
        <http-only>true</http-only>
        <secure>false</secure>
    </cookie-config>
</session-config>
```

## 📈 Performance Considerations

### Database Optimization
- Proper indexing on frequently queried columns
- Connection pooling for efficient database usage
- Query optimization with prepared statements

### Application Performance
- Efficient DAO pattern implementation
- Proper resource management (connection closing)
- Optimized JSP rendering with minimal inline Java

### Recommended Production Settings
```bash
# JVM Settings for production
export CATALINA_OPTS="-Xms512m -Xmx2048m -XX:PermSize=256m"

# Database connection pool settings
maxTotal="20" maxIdle="10" maxWaitMillis="10000"
```

## 🐛 Troubleshooting

### Common Issues

#### Build Issues
```bash
# Clear Maven cache
mvn dependency:purge-local-repository

# Rebuild with debug info
mvn clean compile package -X
```

#### Database Connection Issues
```bash
# Test database connectivity
mysql -u forum_user -p forum_db -e "SELECT 1;"

# Check connection string format
jdbc:mysql://localhost:3306/forum_db?useSSL=false&serverTimezone=UTC
```

#### Deployment Issues
```bash
# Check Tomcat logs
tail -f $CATALINA_HOME/logs/catalina.out

# Verify WAR file integrity
jar -tf target/forum-app.war | head -20
```

For detailed troubleshooting, see the [Installation Guide](INSTALLATION_GUIDE.md#troubleshooting).

## 📋 Development Guidelines

### Code Quality Standards
- **Documentation:** Comprehensive JavaDoc for all public methods
- **Naming Conventions:** Follow Java naming standards
- **Error Handling:** Proper exception handling throughout
- **Code Organization:** Clear separation of concerns (MVC pattern)
- **Testing:** Unit tests for business logic components

### Contribution Guidelines
1. Follow existing code style and conventions
2. Write comprehensive tests for new features
3. Update documentation for any interface changes
4. Ensure all tests pass before submitting changes
5. Use meaningful commit messages

## 📞 Support and Maintenance

### Regular Maintenance Tasks
- **Database Backup:** Schedule regular backups
- **Log Rotation:** Implement log file rotation
- **Security Updates:** Keep dependencies updated
- **Performance Monitoring:** Monitor application metrics

### Backup Procedures
```bash
# Database backup
mysqldump -u forum_user -p forum_db > forum_backup_$(date +%Y%m%d).sql

# Application backup
tar -czf forum_app_backup_$(date +%Y%m%d).tar.gz .
```

### Monitoring
- Application logs: `$CATALINA_HOME/logs/`
- Database performance: MySQL slow query log
- User activity: Application activity logs
- System resources: Memory and CPU usage

## 📄 License and Academic Information

### Academic Project Details
- **Course:** Advanced Java Programming (ITHCA0)
- **Institution:** Eduvos
- **Assessment:** Project 1 - Distributed Applications
- **Submission Date:** June 13, 2025
- **Academic Year:** 2025

### Educational Purpose
This application is developed as an academic project for educational purposes. It demonstrates:
- Advanced Java programming concepts
- Web application development with servlets and JSP
- Database design and integration
- RESTful web service implementation
- Modern web UI development practices

### Usage Rights
This project is created for educational purposes and demonstrates original work developed specifically for Advanced Java Programming course requirements. All code and documentation represent original implementation following academic integrity guidelines.

## 🤝 Contact Information

**Developer:** Simphiwe Radebe
**Institution:** Eduvos  
**Course:** Advanced Java Programming (ITHCA0)

For technical questions about this project, please refer to:
- [Installation Guide](INSTALLATION_GUIDE.md) for setup issues
- [User Guide](USER_GUIDE.md) for usage questions
- Source code documentation for implementation details

---

**Last Updated:** June 13, 2025  
**Version:** 1.0.0  
**Status:** Production Ready

---

*This README provides a comprehensive overview of the Forum Application. For detailed setup instructions, see the [Installation Guide](INSTALLATION_GUIDE.md). For usage instructions, see the [User Guide](USER_GUIDE.md).*