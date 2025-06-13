<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="includes/header.jsp" %>
<title>Reset Password - Forum Application</title>

<body class="bg-gray-50 min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
    <div class="max-w-md w-full space-y-8">
        <!-- Logo and Header -->
        <div class="text-center">
            <div class="mx-auto w-16 h-16 bg-gradient-to-r from-primary-500 to-secondary-500 rounded-2xl flex items-center justify-center mb-6">
                <i class="fas fa-lock text-white text-2xl"></i>
            </div>
            <h1 class="text-3xl font-bold text-gray-900 mb-2">Reset Your Password</h1>
            <p class="text-gray-600">Enter your new password below</p>
        </div>

        <!-- Reset Password Form -->
        <div class="bg-white rounded-2xl shadow-lg border border-gray-100 p-8">
            <form action="${pageContext.request.contextPath}/user/reset-password" method="post" class="space-y-6" id="resetForm">
                <input type="hidden" name="token" value="${param.token}">

                <!-- Error Message -->
                <c:if test="${not empty param.error}">
                    <div class="bg-red-50 border border-red-200 rounded-xl p-4">
                        <div class="flex items-center">
                            <div class="w-6 h-6 bg-red-500 rounded-full flex items-center justify-center flex-shrink-0">
                                <i class="fas fa-exclamation text-white text-xs"></i>
                            </div>
                            <div class="ml-3">
                                <p class="text-red-700 text-sm">
                                    <c:choose>
                                        <c:when test="${param.error == 'invalid_token'}">
                                            Invalid or expired reset token. Please request a new password reset.
                                        </c:when>
                                        <c:when test="${param.error == 'password_mismatch'}">
                                            Passwords do not match. Please try again.
                                        </c:when>
                                        <c:otherwise>
                                            Unable to reset password. Please try again.
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>
                    </div>
                </c:if>

                <!-- New Password Field -->
                <div>
                    <label for="newPassword" class="block text-sm font-medium text-gray-700 mb-2">
                        <i class="fas fa-lock mr-2 text-gray-400"></i>New Password
                    </label>
                    <div class="relative">
                        <input type="password"
                               id="newPassword"
                               name="newPassword"
                               required
                               minlength="6"
                               class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors duration-200 text-gray-900 placeholder-gray-500 pr-12"
                               placeholder="Enter your new password">
                        <button type="button"
                                onclick="togglePassword('newPassword')"
                                class="absolute inset-y-0 right-0 flex items-center pr-4 text-gray-400 hover:text-gray-600">
                            <i id="newPassword-toggle-icon" class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>

                <!-- Confirm Password Field -->
                <div>
                    <label for="confirmPassword" class="block text-sm font-medium text-gray-700 mb-2">
                        <i class="fas fa-lock mr-2 text-gray-400"></i>Confirm New Password
                    </label>
                    <div class="relative">
                        <input type="password"
                               id="confirmPassword"
                               name="confirmPassword"
                               required
                               class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors duration-200 text-gray-900 placeholder-gray-500 pr-12"
                               placeholder="Confirm your new password">
                        <button type="button"
                                onclick="togglePassword('confirmPassword')"
                                class="absolute inset-y-0 right-0 flex items-center pr-4 text-gray-400 hover:text-gray-600">
                            <i id="confirmPassword-toggle-icon" class="fas fa-eye"></i>
                        </button>
                    </div>
                    <div id="password-match" class="mt-1 text-xs hidden">
                        <span id="password-match-text"></span>
                    </div>
                </div>

                <!-- Submit Button -->
                <button type="submit"
                        id="submitBtn"
                        class="w-full bg-gradient-to-r from-primary-500 to-secondary-500 text-white px-6 py-3 rounded-xl font-semibold text-lg hover:from-primary-600 hover:to-secondary-600 focus:outline-none focus:ring-2 focus:ring-primary-500 focus:ring-offset-2 transition-all duration-200 transform hover:scale-105 shadow-lg disabled:opacity-50 disabled:cursor-not-allowed disabled:transform-none">
                    <i class="fas fa-save mr-2"></i>Reset Password
                </button>
            </form>
        </div>

        <!-- Back to Login -->
        <div class="text-center">
            <a href="${pageContext.request.contextPath}/user/login"
               class="inline-flex items-center text-gray-500 hover:text-gray-700 transition-colors duration-200">
                <i class="fas fa-arrow-left mr-2"></i>
                Back to Login
            </a>
        </div>
    </div>

    <script>
        function togglePassword(fieldId) {
            const passwordInput = document.getElementById(fieldId);
            const toggleIcon = document.getElementById(fieldId + '-toggle-icon');

            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }

        function checkPasswordMatch() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const matchElement = document.getElementById('password-match');
            const matchText = document.getElementById('password-match-text');

            if (confirmPassword.length > 0) {
                matchElement.classList.remove('hidden');
                if (password === confirmPassword) {
                    matchText.textContent = '✓ Passwords match';
                    matchText.className = 'text-green-600';
                } else {
                    matchText.textContent = '✗ Passwords do not match';
                    matchText.className = 'text-red-600';
                }
            } else {
                matchElement.classList.add('hidden');
            }
        }

        function validateForm() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            const isValid = password.length >= 6 && password === confirmPassword;
            document.getElementById('submitBtn').disabled = !isValid;
            return isValid;
        }

        // Event listeners
        document.addEventListener('DOMContentLoaded', function() {
            const passwordInput = document.getElementById('password');
            const confirmPasswordInput = document.getElementById('confirmPassword');

            passwordInput.addEventListener('input', function() {
                checkPasswordMatch();
                validateForm();
            });

            confirmPasswordInput.addEventListener('input', function() {
                checkPasswordMatch();
                validateForm();
            });

            // Auto-focus password field
            passwordInput.focus();

            // Initial validation
            validateForm();
        });
    </script>
</body>
</html>