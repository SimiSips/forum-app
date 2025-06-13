# Forum Application - User Guide

## Table of Contents
1. [Getting Started](#getting-started)
2. [User Registration and Login](#user-registration-and-login)
3. [Forum Navigation](#forum-navigation)
4. [Creating and Managing Topics](#creating-and-managing-topics)
5. [Comments and Replies](#comments-and-replies)
6. [User Profile Management](#user-profile-management)
7. [Search Functionality](#search-functionality)
8. [Password Recovery](#password-recovery)
9. [API Usage](#api-usage)
10. [Troubleshooting](#troubleshooting)

## Getting Started

### Accessing the Application
1. Open your web browser (Chrome, Firefox, Safari, or Edge)
2. Navigate to: `http://localhost:8080/forum-app/`
3. You'll see the forum homepage with recent topics and navigation options

### System Requirements for Users
- **Browser:** Any modern web browser with JavaScript enabled
- **Internet Connection:** Required for full functionality
- **Screen Resolution:** Minimum 1024x768 (responsive design adapts to mobile devices)

## User Registration and Login

### Creating a New Account

1. **Access Registration Page**
    - Click "Create one here" on the login page
    - Or navigate directly to the registration page

2. **Fill Registration Form**
    - **Email Address:** Must be valid and unique
    - **Password:** Must meet security requirements:
        - At least 8 characters long
        - Contains uppercase letters (A-Z)
        - Contains lowercase letters (a-z)
        - Contains at least one digit (0-9)
        - Contains at least one special character (@, #, $, %, etc.)
    - **Confirm Password:** Must match the password
    - **First Name:** Your first name (required)
    - **Last Name:** Your last name (required)
    - **Phone Number:** Optional contact number

3. **Submit Registration**
    - Click "Register" button
    - System will validate your information
    - Successful registration redirects to login page

### Logging In

1. **Enter Credentials**
    - Email address (used as username)
    - Password

2. **Login Options**
    - **Remember Me:** Check this box to stay logged in longer
    - **Forgot Password:** Link for password recovery

3. **Successful Login**
    - Redirected to forum homepage
    - Your name appears in the navigation bar
    - Access to all forum features

### Logging Out
- Click your name in the navigation bar
- Select "Logout" from the dropdown menu
- Alternatively, close your browser tab (if "Remember Me" wasn't selected)

## Forum Navigation

### Main Navigation Bar
- **Home:** Returns to the main forum page
- **Topics:** Browse all forum topics
- **Search:** Find specific topics or content
- **Create Topic:** Start a new discussion (logged-in users only)
- **User Menu:** Access profile, settings, and logout

### Homepage Features
- **Recent Topics:** Latest discussions in chronological order
- **Topic Statistics:** Number of comments and last activity
- **User Information:** Who created each topic and when
- **Quick Search:** Search box in the navigation

### Topic List View
- **Topic Title:** Click to open the full discussion
- **Description Preview:** Brief preview of topic content
- **Author Information:** Who created the topic
- **Comment Count:** Number of comments in the topic
- **Last Activity:** When the topic was last updated

## Creating and Managing Topics

### Creating a New Topic

1. **Access Topic Creation**
    - Click "Create New Topic" button (requires login)
    - Redirected to topic creation form

2. **Fill Topic Information**
    - **Title:** Clear, descriptive title (maximum 255 characters)
        - Example: "Best practices for Java exception handling"
    - **Description:** Detailed explanation of your topic (maximum 5,000 characters)
        - Use clear formatting and structure
        - Include relevant details and context

3. **Submit Topic**
    - Click "Create Topic" button
    - System validates the information
    - Successful creation redirects to the new topic page

### Topic Creation Best Practices

#### Writing Good Titles
- Be specific and descriptive
- Use proper capitalization
- Avoid all caps or excessive punctuation
- Include key terms that others might search for

**Good Examples:**
- "How to implement RESTful APIs in Java Spring Boot"
- "Troubleshooting MySQL connection timeout issues"
- "Best practices for responsive web design"

**Poor Examples:**
- "HELP!!!"
- "Question about Java"
- "Problem with my code"

#### Writing Effective Descriptions
- Start with a clear overview of your topic
- Provide context and background information
- Include specific details about your situation
- Use proper grammar and formatting
- Break up long text into paragraphs

### Viewing Topics

1. **Open a Topic**
    - Click on any topic title from the topic list
    - View complete topic with description and comments

2. **Topic Page Elements**
    - **Topic Header:** Title, author, and creation date
    - **Description:** Full topic content
    - **Comment Section:** All comments and replies
    - **Add Comment Form:** Post new comments (logged-in users)

## Comments and Replies

### Posting Comments

1. **Navigate to Topic**
    - Open any topic you want to comment on
    - Scroll down to the comment section

2. **Write Your Comment**
    - Use the comment text area at the bottom
    - Maximum 2,000 characters per comment
    - Format your comment clearly and thoughtfully

3. **Submit Comment**
    - Click "Post Comment" button
    - Comment appears immediately in the topic
    - Other users can see and reply to your comment

### Replying to Comments

1. **Find the Comment**
    - Locate the comment you want to reply to
    - Click the "Reply" button under that comment

2. **Write Your Reply**
    - Reply form appears below the original comment
    - Maximum 1,000 characters per reply
    - Reference the original comment if needed

3. **Submit Reply**
    - Click "Post Reply" button
    - Reply is nested under the original comment
    - Indented to show the conversation hierarchy

### Comment Best Practices

#### Writing Quality Comments
- Stay on topic and relevant to the discussion
- Be respectful and constructive
- Provide helpful information or insights
- Use proper grammar and spelling
- Avoid duplicate comments

#### Engaging in Discussions
- Read the full topic before commenting
- Acknowledge previous comments when relevant
- Ask clarifying questions if needed
- Share your experience and knowledge
- Respect different viewpoints

## User Profile Management

### Accessing Your Profile

1. **Profile Navigation**
    - Click your name in the navigation bar
    - Select "Profile" from the dropdown menu

2. **Profile Overview**
    - View your current information
    - See registration date and last login
    - Access to edit functions

### Updating Profile Information

1. **Edit Profile**
    - Click "Edit Profile" button on your profile page
    - Modify the following information:
        - First Name
        - Last Name
        - Phone Number
    - Email cannot be changed (used as unique identifier)

2. **Save Changes**
    - Click "Update Profile" button
    - System validates the new information
    - Success message confirms changes

### Changing Your Password

1. **Access Password Change**
    - Go to your profile page
    - Click "Change Password" section

2. **Password Change Form**
    - **Current Password:** Enter your existing password
    - **New Password:** Enter new password (must meet security requirements)
    - **Confirm New Password:** Re-enter the new password

3. **Submit Password Change**
    - Click "Change Password" button
    - System validates current password
    - New password takes effect immediately

### Profile Security Tips
- Use a strong, unique password
- Don't share your login credentials
- Log out from shared computers
- Update your profile information regularly
- Report any suspicious activity

## Search Functionality

### Basic Search

1. **Search Location**
    - Use the search box in the navigation bar
    - Available on all pages

2. **Search Process**
    - Enter keywords related to your topic of interest
    - Press Enter or click the search icon
    - Results display matching topics

### Search Features

#### What Can Be Searched
- **Topic Titles:** Primary search target
- **Topic Descriptions:** Content within topics
- **Keyword Matching:** Finds relevant terms

#### Search Tips
- Use specific keywords for better results
- Try different combinations of words
- Use common terms that others might use
- Search for both technical and general terms

### Search Results

1. **Results Display**
    - Matching topics shown in order of relevance
    - Title and description preview for each result
    - Click any result to open the full topic

2. **No Results**
    - If no matches found, try different keywords
    - Consider browsing the topic list
    - Create a new topic if your subject isn't covered

## Password Recovery

### Forgot Password Process

1. **Access Password Reset**
    - Click "Forgot password?" on the login page
    - Enter your registered email address

2. **Reset Instructions**
    - System generates a password reset link
    - Check your email for reset instructions
    - Click the link in the email (valid for 24 hours)

3. **Set New Password**
    - Enter a new password meeting security requirements
    - Confirm the new password
    - Submit to complete the reset process

### Password Reset Troubleshooting

#### Email Not Received
- Check your spam/junk folder
- Verify you entered the correct email address
- Wait a few minutes for email delivery
- Contact administrator if issues persist

#### Reset Link Expired
- Request a new password reset
- Use the link within 24 hours
- Only one reset link is valid at a time

## API Usage

### REST API Endpoints

The forum application provides RESTful API endpoints for integration:

#### User Endpoints
```
GET    /api/users          - List all users
GET    /api/users/{id}     - Get specific user
POST   /api/users          - Create new user
PUT    /api/users/{id}     - Update user
DELETE /api/users/{id}     - Delete user
```

#### Topic Endpoints
```
GET    /api/topics         - List all topics
GET    /api/topics/{id}    - Get specific topic
POST   /api/topics         - Create new topic
PUT    /api/topics/{id}    - Update topic
DELETE /api/topics/{id}    - Delete topic
```

#### Comment Endpoints
```
GET    /api/comments       - List comments for a topic
POST   /api/comments       - Create new comment
PUT    /api/comments/{id}  - Update comment
DELETE /api/comments/{id}  - Delete comment
```

### API Authentication
- Most read operations are public
- Create, update, delete operations require authentication
- Use session-based authentication from web interface

### API Response Format
All API responses use JSON format:
```json
{
  "success": true,
  "data": {...},
  "message": "Operation completed successfully"
}
```

### Example API Usage

#### Get All Topics
```bash
curl -X GET http://localhost:8080/forum-app/api/topics
```

#### Create New Topic
```bash
curl -X POST http://localhost:8080/forum-app/api/topics \
  -H "Content-Type: application/json" \
  -d '{
    "title": "New Discussion Topic",
    "description": "This is a detailed description of the topic.",
    "userId": 1
  }'
```

## Troubleshooting

### Common User Issues

#### 1. Cannot Login
**Symptoms:**
- "Invalid email or password" message
- Login form keeps appearing

**Solutions:**
- Verify email address is correct (check spelling)
- Ensure password is entered correctly (check caps lock)
- Try password reset if you've forgotten your password
- Clear browser cookies and cache
- Ensure JavaScript is enabled in your browser

#### 2. Registration Problems
**Symptoms:**
- "Email already exists" error
- Password requirements not met
- Form validation errors

**Solutions:**
- Use a different email address if already registered
- Check password meets all requirements:
    - Minimum 8 characters
    - Contains uppercase and lowercase letters
    - Contains at least one number
    - Contains at least one special character
- Fill in all required fields
- Use a valid email format

#### 3. Comments Not Posting
**Symptoms:**
- Comment form doesn't submit
- Comments don't appear after posting
- Error messages when trying to comment

**Solutions:**
- Ensure you're logged in
- Check comment length (maximum 2,000 characters)
- Verify internet connection
- Refresh the page and try again
- Clear browser cache

#### 4. Search Not Working
**Symptoms:**
- No search results found
- Search page doesn't load
- Search function appears broken

**Solutions:**
- Try different keywords or phrases
- Check spelling of search terms
- Use broader search terms
- Ensure there are topics in the forum
- Try browsing instead of searching

#### 5. Profile Update Issues
**Symptoms:**
- Changes don't save
- Error messages when updating profile
- Form doesn't submit

**Solutions:**
- Fill in all required fields
- Use valid phone number format
- Ensure first and last names are not empty
- Check for special characters that might cause issues
- Try updating one field at a time

### Browser Compatibility

#### Supported Browsers
- **Chrome:** Version 90 and above
- **Firefox:** Version 88 and above
- **Safari:** Version 14 and above
- **Edge:** Version 90 and above

#### Browser Settings
- **JavaScript:** Must be enabled
- **Cookies:** Must be enabled for login functionality
- **Pop-up Blocker:** May need to allow pop-ups for some features

#### Mobile Browsers
- Most modern mobile browsers are supported
- Responsive design adapts to smaller screens
- Touch-friendly interface on mobile devices

### Performance Issues

#### Slow Loading Pages
**Causes and Solutions:**
- **Slow Internet:** Check your connection speed
- **Server Load:** Try accessing during off-peak hours
- **Browser Cache:** Clear cache and reload page
- **Too Many Tabs:** Close unnecessary browser tabs

#### Frequent Timeouts
**Causes and Solutions:**
- **Session Timeout:** Normal behavior for security
- **Network Issues:** Check internet stability
- **Server Maintenance:** Wait and try again later
- **Browser Issues:** Try a different browser

### Getting Help

#### Self-Help Resources
1. **Check this User Guide:** Most common questions are answered here
2. **Review Error Messages:** They often contain helpful information
3. **Try Different Browsers:** Some issues are browser-specific
4. **Clear Browser Data:** Often resolves persistent issues

#### Contact Support
- **Technical Issues:** Contact your system administrator
- **Account Problems:** Use the password reset feature first
- **Bug Reports:** Document the issue with steps to reproduce
- **Feature Requests:** Submit through appropriate channels

## Advanced Features

### Keyboard Shortcuts
- **Ctrl + /** or **Cmd + /**: Focus search box
- **Tab**: Navigate through form fields
- **Enter**: Submit forms (when appropriate)
- **Esc**: Close modal dialogs

### URL Navigation
- **Direct Topic Access:** `http://localhost:8080/forum-app/topic?id=123`
- **User Profile:** `http://localhost:8080/forum-app/user/profile`
- **Search Results:** `http://localhost:8080/forum-app/search?q=keyword`

### Data Export
Currently, data export features are limited to:
- Copy and paste topic content
- Save comments manually
- Use browser "Save As" to save pages locally

## Best Practices for Forum Users

### Creating Quality Content

#### Topic Creation
- **Research First:** Check if similar topics already exist
- **Clear Titles:** Make titles descriptive and searchable
- **Detailed Descriptions:** Provide context and background
- **Proper Formatting:** Use paragraphs and clear structure
- **Stay Focused:** Keep topics focused on specific issues

#### Commenting Effectively
- **Read Thoroughly:** Read the full topic before commenting
- **Add Value:** Contribute meaningful insights or questions
- **Be Respectful:** Maintain a professional and courteous tone
- **Stay Relevant:** Keep comments related to the topic
- **Cite Sources:** Reference external information when helpful

### Community Guidelines

#### Respectful Communication
- Treat all users with respect and courtesy
- Avoid personal attacks or inflammatory language
- Focus on ideas and solutions, not personalities
- Be constructive in criticism
- Help create a welcoming environment for newcomers

#### Content Quality
- Use proper grammar and spelling when possible
- Avoid excessive use of capitals (seen as shouting)
- Keep discussions on-topic
- Don't spam or post duplicate content
- Share knowledge and experience generously

#### Privacy and Security
- Don't share personal information unnecessarily
- Be cautious about sensitive business information
- Use the forum's private messaging features when appropriate
- Report suspicious or inappropriate behavior
- Keep your account credentials secure

## Forum Statistics and Activity

### Personal Activity Tracking
- **Your Topics:** View all topics you've created
- **Your Comments:** See all your comments across topics
- **Registration Date:** When you joined the forum
- **Last Login:** Your most recent login time

### Understanding Forum Activity
- **Topic Creation Times:** See when topics were created
- **Comment Timestamps:** Track discussion progression
- **User Activity:** See who's actively participating
- **Popular Topics:** Identify highly commented discussions

## Future Features and Updates

### Planned Enhancements
The forum application is continuously being improved. Future updates may include:
- Enhanced search with filtering options
- File upload capabilities for attachments
- Email notifications for new comments
- User reputation and badge systems
- Advanced moderation tools
- Mobile application version

### Feedback and Suggestions
User feedback is valuable for improving the forum experience:
- Report bugs through appropriate channels
- Suggest new features that would be helpful
- Share usability observations
- Participate in user experience surveys when available

---

## Conclusion

This Forum Application provides a comprehensive platform for online discussions and knowledge sharing. By following this user guide, you should be able to effectively use all available features and contribute meaningfully to the forum community.

Remember that the forum is most valuable when users actively participate, share knowledge, and maintain a respectful environment for all participants.

For additional technical information, see the [Installation Guide](INSTALLATION_GUIDE.md) and project documentation.

---

**Author:** Simphiwe Radebe  
**Course:** Advanced Java Programming (ITHCA0)  
**Institution:** Eduvos  
**Last Updated:** June 13, 2025  
**Version:** 1.0.0

---

*This user guide is part of the Forum Application project developed for educational purposes. All features described are implemented and functional in the current version of the application.*