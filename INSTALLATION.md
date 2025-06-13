# Forum Application - Installation Guide

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Environment Setup](#environment-setup)
3. [Database Configuration](#database-configuration)
4. [Application Installation](#application-installation)
5. [Deployment Options](#deployment-options)
6. [Verification](#verification)
7. [Troubleshooting](#troubleshooting)

## Prerequisites

### System Requirements
- **Operating System:** Windows 10+, macOS 10.14+, or Linux (Ubuntu 18.04+)
- **Memory:** Minimum 4GB RAM (8GB recommended)
- **Storage:** At least 2GB free disk space
- **Network:** Internet connection for downloading dependencies

### Required Software

#### Java Development Kit (JDK)
- **Version:** JDK 11 or higher
- **Download:** [Oracle JDK](https://www.oracle.com/java/technologies/downloads/) or [OpenJDK](https://openjdk.java.net/)

```bash
# Verify Java installation
java -version
javac -version
```

#### Apache Maven
- **Version:** 3.6.0 or higher
- **Download:** [Apache Maven](https://maven.apache.org/download.cgi)

```bash
# Verify Maven installation
mvn -version
```

#### MySQL Database Server
- **Version:** 8.0 or higher
- **Download:** [MySQL Community Server](https://dev.mysql.com/downloads/mysql/)

```bash
# Verify MySQL installation
mysql --version
```

#### Apache Tomcat
- **Version:** 9.0 or higher
- **Download:** [Apache Tomcat](https://tomcat.apache.org/download-90.cgi)

## Environment Setup

### 1. Configure Environment Variables

#### Windows
```cmd
# Set JAVA_HOME
set JAVA_HOME=C:\Program Files\Java\jdk-11

# Set CATALINA_HOME
set CATALINA_HOME=C:\apache-tomcat-9.0.x

# Add to PATH
set PATH=%JAVA_HOME%\bin;%CATALINA_HOME%\bin;%PATH%
```

#### Linux/macOS
```bash
# Add to ~/.bashrc or ~/.zshrc
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export CATALINA_HOME=/opt/tomcat
export PATH=$JAVA_HOME/bin:$CATALINA_HOME/bin:$PATH

# Reload the shell configuration
source ~/.bashrc
```

### 2. Verify Environment Setup
```bash
# Check all required tools
echo $JAVA_HOME
echo $CATALINA_HOME
java -version
mvn -version
mysql --version
```

## Database Configuration

### 1. Create Database User
```sql
-- Connect to MySQL as root
mysql -u root -p

-- Create database
CREATE DATABASE forum_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Create dedicated user
CREATE USER 'forum_user'@'localhost' IDENTIFIED BY 'forum_password_2025';

-- Grant permissions
GRANT ALL PRIVILEGES ON forum_db.* TO 'forum_user'@'localhost';
FLUSH PRIVILEGES;

-- Exit MySQL
EXIT;
```

### 2. Import Database Schema
```bash
# Navigate to project directory
cd /path/to/forum-app

# Import the database schema
mysql -u forum_user -p forum_db < database_schema.sql
```

### 3. Verify Database Setup
```sql
-- Connect with the new user
mysql -u forum_user -p forum_db

-- Check tables
SHOW TABLES;

-- Verify sample data
SELECT * FROM users LIMIT 5;
```

## Application Installation

### 1. Download/Clone Project
```bash
# If downloading from repository
git clone <repository-url> forum-app
cd forum-app

# Or extract from ZIP file
unzip forum-app.zip
cd forum-app
```

### 2. Configure Database Connection

Edit the database configuration in `src/main/java/com/forum/config/DatabaseConfig.java`:

```java
public class DatabaseConfig {
    private static final String DATABASE_URL = "jdbc:mysql://localhost:3306/forum_db?useSSL=false&serverTimezone=UTC";
    private static final String DATABASE_USERNAME = "forum_user";
    private static final String DATABASE_PASSWORD = "forum_password_2025";
    private static final String DATABASE_DRIVER = "com.mysql.cj.jdbc.Driver";
}
```

### 3. Install MySQL Connector

#### Option A: Add to Project Dependencies
The MySQL connector is already included in `pom.xml`. No additional action needed.

#### Option B: Add to Tomcat (Alternative)
```bash
# Download MySQL Connector/J
wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-j-8.0.33.jar

# Copy to Tomcat lib directory
cp mysql-connector-j-8.0.33.jar $CATALINA_HOME/lib/
```

## Deployment Options

### Option 1: Automated Deployment (Recommended)

1. **Make the deployment script executable:**
```bash
chmod +x deploy.sh
```

2. **Run the deployment script:**
```bash
./deploy.sh
```

The script will:
- Clean and build the project
- Remove old deployments
- Deploy the new WAR file
- Restart Tomcat
- Show deployment status

### Option 2: Manual Deployment

1. **Build the project:**
```bash
mvn clean compile package
```

2. **Deploy to Tomcat:**
```bash
# Remove existing deployment
rm -rf $CATALINA_HOME/webapps/forum-app*

# Copy WAR file
cp target/forum-app.war $CATALINA_HOME/webapps/

# Start/Restart Tomcat
$CATALINA_HOME/bin/catalina.sh start
```

### Option 3: IDE Deployment

#### IntelliJ IDEA
1. Open project in IntelliJ IDEA
2. Configure Tomcat server in Run Configurations
3. Set deployment artifact to `forum-app:war exploded`
4. Run the configuration

#### Eclipse
1. Import project as Maven project
2. Right-click project → Properties → Project Facets
3. Enable Java and Dynamic Web Module
4. Add to Tomcat server in Servers view
5. Start server

## Verification

### 1. Check Application Startup
```bash
# Monitor Tomcat logs
tail -f $CATALINA_HOME/logs/catalina.out

# Look for successful deployment messages
# Should see: "Deployment of web application directory [forum-app] has finished"
```

### 2. Access the Application
Open a web browser and navigate to:
```
http://localhost:8080/forum-app/
```

### 3. Test Core Functionality

#### Register a New User
1. Click "Create one here" on the login page
2. Fill in the registration form
3. Submit and verify redirect to login page

#### Login Test
1. Use the credentials you just created
2. Verify successful login and redirect to forum home

#### Create a Topic
1. Click "Create New Topic"
2. Enter title and description
3. Submit and verify the topic appears in the list

#### Post a Comment
1. Click on any topic
2. Enter a comment in the comment section
3. Submit and verify the comment appears

### 4. Database Verification
```sql
-- Check if data is being stored
mysql -u forum_user -p forum_db

-- Verify user registration
SELECT user_id, email, first_name, last_name, date_registered FROM users;

-- Check topics and comments
SELECT * FROM topics ORDER BY date_created DESC LIMIT 5;
SELECT * FROM comments ORDER BY date_posted DESC LIMIT 5;
```

## Troubleshooting

### Common Issues and Solutions

#### 1. Port Already in Use
**Problem:** `java.net.BindException: Address already in use`

**Solution:**
```bash
# Find process using port 8080
lsof -i :8080
# or on Windows
netstat -ano | findstr :8080

# Kill the process
kill -9 <PID>
# or change Tomcat port in server.xml
```

#### 2. Database Connection Failed
**Problem:** `Communications link failure`

**Solutions:**
- Verify MySQL is running: `sudo systemctl status mysql`
- Check database credentials in DatabaseConfig.java
- Verify database and user exist
- Check firewall settings

#### 3. WAR File Not Deploying
**Problem:** WAR file copied but application not accessible

**Solutions:**
```bash
# Check Tomcat permissions
ls -la $CATALINA_HOME/webapps/

# Verify WAR file integrity
file target/forum-app.war

# Check Tomcat logs for errors
tail -f $CATALINA_HOME/logs/catalina.out
```

#### 4. ClassNotFoundException for MySQL Driver
**Problem:** `java.lang.ClassNotFoundException: com.mysql.cj.jdbc.Driver`

**Solutions:**
- Verify MySQL connector in WEB-INF/lib/
- Or add to Tomcat lib directory
- Rebuild project: `mvn clean package`

#### 5. Session/Login Issues
**Problem:** Users can't stay logged in

**Solutions:**
- Check web.xml session configuration
- Verify cookie settings in browser
- Clear browser cache and cookies
- Check server time zone settings

#### 6. File Permission Issues
**Problem:** Cannot write logs or upload files

**Solutions:**
```bash
# Fix Tomcat directory permissions
sudo chown -R tomcat:tomcat $CATALINA_HOME/webapps/forum-app
sudo chmod -R 755 $CATALINA_HOME/webapps/forum-app

# Create logs directory if missing
mkdir -p logs
chmod 755 logs
```

### Performance Optimization

#### 1. JVM Settings
Add to `$CATALINA_HOME/bin/setenv.sh`:
```bash
export CATALINA_OPTS="-Xms512m -Xmx2048m -XX:PermSize=256m -XX:MaxPermSize=512m"
```

#### 2. Database Connection Pooling
Configure in `$CATALINA_HOME/conf/context.xml`:
```xml
<Resource name="jdbc/ForumDB"
          auth="Container"
          type="javax.sql.DataSource"
          maxTotal="20"
          maxIdle="10"
          maxWaitMillis="10000"
          driverClassName="com.mysql.cj.jdbc.Driver"
          url="jdbc:mysql://localhost:3306/forum_db"
          username="forum_user"
          password="forum_password_2025"/>
```

### Maintenance Commands

#### Application Logs
```bash
# View application logs
tail -f $CATALINA_HOME/logs/catalina.out

# View access logs
tail -f $CATALINA_HOME/logs/localhost_access_log.$(date +%Y-%m-%d).txt
```

#### Database Backup
```bash
# Create backup
mysqldump -u forum_user -p forum_db > forum_backup_$(date +%Y%m%d).sql

# Restore backup
mysql -u forum_user -p forum_db < forum_backup_20250613.sql
```

#### Application Updates
```bash
# Quick redeploy
./deploy.sh --no-restart

# Full redeploy with restart
./deploy.sh

# View logs only
./deploy.sh --logs-only
```

## Security Considerations

### Production Deployment
1. **Change default passwords** in database and configuration files
2. **Enable HTTPS** by configuring SSL in Tomcat
3. **Configure firewall** to restrict database access
4. **Regular security updates** for all components
5. **Enable access logging** and monitoring

### Database Security
```sql
-- Remove or disable default accounts
DROP USER 'root'@'%';

-- Create production user with limited privileges
CREATE USER 'forum_prod'@'localhost' IDENTIFIED BY 'secure_production_password';
GRANT SELECT, INSERT, UPDATE, DELETE ON forum_db.* TO 'forum_prod'@'localhost';
```

## Support

For additional support:
1. Check the [User Guide](USER_GUIDE.md) for usage instructions
2. Review application logs for error details
3. Verify all prerequisites are correctly installed
4. Consult the project documentation

---

**Author:** Simphiwe Radebe  
**Course:** Advanced Java Programming (ITHCA0)  
**Institution:** Eduvos  
**Last Updated:** June 13, 2025