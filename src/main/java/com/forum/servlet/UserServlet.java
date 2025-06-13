package com.forum.servlet;

import com.forum.service.UserService;
import com.forum.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Logger;

/**
 * Servlet for handling user-related HTTP requests
 * Manages registration, login, logout, and profile updates
 *
 * @author Simphiwe Radebe
 * @version 1.0
 * @since 2025-06-03
 */

public class UserServlet extends HttpServlet {

    /** Serial version UID for serialization */
    private static final long serialVersionUID = 1L;

    /** Logger instance for servlet operations */
    private static final Logger LOGGER = Logger.getLogger(UserServlet.class.getName());

    /** User service for business logic */
    private UserService userService;

    /**
     * Initializes the servlet and user service
     */
    @Override
    public void init() throws ServletException {
        super.init();
        userService = new UserService();
        LOGGER.info("UserServlet initialized successfully");
    }

    /**
     * Handles GET requests for user operations
     *
     * @param request HTTP request
     * @param response HTTP response
     * @throws ServletException if servlet error occurs
     * @throws IOException if I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // Default user page
                handleUserProfile(request, response);
            } else {
                switch (pathInfo) {
                    case "/login":
                        handleLoginPage(request, response);
                        break;
                    case "/register":
                        handleRegisterPage(request, response);
                        break;
                    case "/profile":
                        handleUserProfile(request, response);
                        break;
                    case "/logout":
                        handleLogout(request, response);
                        break;
                    case "/forgot-password":
                        handleForgotPasswordPage(request, response);
                        break;
                    case "/reset-password":
                        handleResetPasswordPage(request, response);
                        break;
                    default:
                        response.sendError(HttpServletResponse.SC_NOT_FOUND);
                }
            }
        } catch (Exception e) {
            LOGGER.severe("Error handling GET request: " + e.getMessage());
            request.setAttribute("error", "An error occurred while processing your request");
            request.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(request, response);
        }
    }

    /**
     * Handles POST requests for user operations
     *
     * @param request HTTP request
     * @param response HTTP response
     * @throws ServletException if servlet error occurs
     * @throws IOException if I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            switch (pathInfo) {
                case "/login":
                    handleLogin(request, response);
                    break;
                case "/register":
                    handleRegister(request, response);
                    break;
                case "/update-profile":
                    handleUpdateProfile(request, response);
                    break;
                case "/change-password":
                    handleChangePassword(request, response);
                    break;
                case "/forgot-password":
                    handleForgotPassword(request, response);
                    break;
                case "/reset-password":
                    handleResetPassword(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            LOGGER.severe("Error handling POST request: " + e.getMessage());
            request.setAttribute("error", "An error occurred while processing your request");
            request.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(request, response);
        }
    }

    /**
     * Handles login page display
     *
     * @param request HTTP request
     * @param response HTTP response
     * @throws ServletException if servlet error occurs
     * @throws IOException if I/O error occurs
     */
    private void handleLoginPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("userId") != null) {
            response.sendRedirect(request.getContextPath() + "/forum");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
    }

    /**
     * Handles user login processing
     *
     * @param request HTTP request
     * @param response HTTP response
     * @throws ServletException if servlet error occurs
     * @throws IOException if I/O error occurs
     */
    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        // Validate input
        String validationError = userService.validateLoginData(email, password);
        if (validationError != null) {
            request.setAttribute("error", validationError);
            request.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
            return;
        }

        // Attempt authentication
        User user = userService.authenticateUser(email, password);

        if (user != null) {
            // Create session
            HttpSession session = request.getSession(true);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("userName", user.getFullName());

            // Set session timeout (30 minutes)
            session.setMaxInactiveInterval(30 * 60);

            // Handle remember me
            if ("on".equals(rememberMe)) {
                session.setMaxInactiveInterval(7 * 24 * 60 * 60); // 7 days
            }

            LOGGER.info("User logged in successfully: " + email);

            // Redirect to forum or requested page
            String redirectTo = request.getParameter("redirectTo");
            if (redirectTo != null && !redirectTo.isEmpty()) {
                response.sendRedirect(redirectTo);
            } else {
                response.sendRedirect(request.getContextPath() + "/forum");
            }
        } else {
            request.setAttribute("error", "Invalid email or password");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
        }
    }

    /**
     * Handles registration page display
     *
     * @param request HTTP request
     * @param response HTTP response
     * @throws ServletException if servlet error occurs
     * @throws IOException if I/O error occurs
     */
    private void handleRegisterPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("userId") != null) {
            response.sendRedirect(request.getContextPath() + "/forum");
            return;
        }

        request.setAttribute("passwordRequirements", userService.getPasswordRequirements());
        request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
    }

    /**
     * Handles user registration processing
     *
     * @param request HTTP request
     * @param response HTTP response
     * @throws ServletException if servlet error occurs
     * @throws IOException if I/O error occurs
     */
    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");

        // Validate password confirmation
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            setRegistrationAttributes(request, email, firstName, lastName, phone);
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
            return;
        }

        // Validate input
        String validationError = userService.validateRegistrationData(email, password,
                firstName, lastName, phone);
        if (validationError != null) {
            request.setAttribute("error", validationError);
            setRegistrationAttributes(request, email, firstName, lastName, phone);
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
            return;
        }

        // Attempt registration
        User user = userService.registerUser(email, password, firstName, lastName, phone);

        if (user != null) {
            LOGGER.info("User registered successfully: " + email);
            request.setAttribute("success", "Registration successful! Please log in.");
            request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            setRegistrationAttributes(request, email, firstName, lastName, phone);
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
        }
    }

    /**
     * Handles user profile page display
     *
     * @param request HTTP request
     * @param response HTTP response
     * @throws ServletException if servlet error occurs
     * @throws IOException if I/O error occurs
     */
    private void handleUserProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        Integer userId = getUserIdFromSession(request);
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }

        // Get user information
        User user = userService.getUserById(userId);
        if (user == null) {
            // Invalid session
            request.getSession().invalidate();
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/jsp/profile.jsp").forward(request, response);
    }

    /**
     * Handles profile update processing
     *
     * @param request HTTP request
     * @param response HTTP response
     * @throws ServletException if servlet error occurs
     * @throws IOException if I/O error occurs
     */
    private void handleUpdateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        Integer userId = getUserIdFromSession(request);
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");

        // Update profile
        boolean success = userService.updateUserProfile(userId, firstName, lastName, phone);

        if (success) {
            // Update session with new name
            HttpSession session = request.getSession();
            session.setAttribute("userName", firstName + " " + lastName);

            request.setAttribute("success", "Profile updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update profile. Please try again.");
        }

        // Reload user data and display profile page
        User user = userService.getUserById(userId);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/jsp/profile.jsp").forward(request, response);
    }

    /**
     * Handles password change processing
     *
     * @param request HTTP request
     * @param response HTTP response
     * @throws ServletException if servlet error occurs
     * @throws IOException if I/O error occurs
     */
    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        Integer userId = getUserIdFromSession(request);
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate password confirmation
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "New passwords do not match");
            User user = userService.getUserById(userId);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/jsp/profile.jsp").forward(request, response);
            return;
        }

        // Change password
        boolean success = userService.changePassword(userId, currentPassword, newPassword);

        if (success) {
            request.setAttribute("success", "Password changed successfully!");
        } else {
            request.setAttribute("error", "Failed to change password. Please check your current password.");
        }

        // Reload user data and display profile page
        User user = userService.getUserById(userId);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/jsp/profile.jsp").forward(request, response);
    }

    /**
     * Handles logout processing
     *
     * @param request HTTP request
     * @param response HTTP response
     * @throws ServletException if servlet error occurs
     * @throws IOException if I/O error occurs
     */
    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            String userEmail = (String) session.getAttribute("userEmail");
            session.invalidate();
            LOGGER.info("User logged out: " + userEmail);
        }

        response.sendRedirect(request.getContextPath() + "/user/login?message=logged-out");
    }

    /**
     * Handles forgot password page display
     *
     * @param request HTTP request
     * @param response HTTP response
     * @throws ServletException if servlet error occurs
     * @throws IOException if I/O error occurs
     */
    private void handleForgotPasswordPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/jsp/forgot-password.jsp").forward(request, response);
    }

    /**
     * Handles forgot password processing
     *
     * @param request HTTP request
     * @param response HTTP response
     * @throws ServletException if servlet error occurs
     * @throws IOException if I/O error occurs
     */
    private void handleForgotPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email is required");
            request.getRequestDispatcher("/WEB-INF/jsp/forgot-password.jsp").forward(request, response);
            return;
        }

        String resetToken = userService.initiatePasswordReset(email);

        if (resetToken != null) {
            // For demo: redirect to reset-password page using token
            response.sendRedirect(request.getContextPath() + "/user/reset-password?token=" + resetToken);
        } else {
            request.setAttribute("error", "Email not found or reset failed");
            request.getRequestDispatcher("/WEB-INF/jsp/forgot-password.jsp").forward(request, response);
        }
    }

    /**
     * Handles reset password page display
     *
     * @param request HTTP request
     * @param response HTTP response
     * @throws ServletException if servlet error occurs
     * @throws IOException if I/O error occurs
     */
    private void handleResetPasswordPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");
        if (token == null || token.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/user/forgot-password");
            return;
        }

        request.setAttribute("token", token);
        request.getRequestDispatcher("/WEB-INF/jsp/reset-password.jsp").forward(request, response);
    }

    /**
     * Handles reset password processing
     *
     * @param request HTTP request
     * @param response HTTP response
     * @throws ServletException if servlet error occurs
     * @throws IOException if I/O error occurs
     */
    private void handleResetPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate password confirmation
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/WEB-INF/jsp/reset-password.jsp").forward(request, response);
            return;
        }

        // Reset password
        boolean success = userService.completePasswordReset(token, newPassword);

        if (success) {
            request.setAttribute("success", "Password reset successful! Please log in with your new password.");
            request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Password reset failed. Token may be invalid or expired.");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/WEB-INF/jsp/reset-password.jsp").forward(request, response);
        }
    }

    /**
     * Gets user ID from session
     *
     * @param request HTTP request
     * @return User ID if logged in, null otherwise
     */
    private Integer getUserIdFromSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (Integer) session.getAttribute("userId");
        }
        return null;
    }

    /**
     * Sets registration form attributes for redisplay
     *
     * @param request HTTP request
     * @param email Email value
     * @param firstName First name value
     * @param lastName Last name value
     * @param phone Phone value
     */
    private void setRegistrationAttributes(HttpServletRequest request, String email,
                                           String firstName, String lastName, String phone) {
        request.setAttribute("email", email);
        request.setAttribute("firstName", firstName);
        request.setAttribute("lastName", lastName);
        request.setAttribute("phone", phone);
        request.setAttribute("passwordRequirements", userService.getPasswordRequirements());
    }
}