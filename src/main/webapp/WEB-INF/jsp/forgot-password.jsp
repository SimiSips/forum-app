<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="includes/header.jsp" %>
<title>Forgot Password - Forum Application</title>

<body class="bg-gray-50 min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
    <div class="max-w-md w-full space-y-8">
        <!-- Logo and Header -->
        <div class="text-center">
            <div class="mx-auto w-16 h-16 bg-gradient-to-r from-primary-500 to-secondary-500 rounded-2xl flex items-center justify-center mb-6">
                <i class="fas fa-key text-white text-2xl"></i>
            </div>
            <h1 class="text-3xl font-bold text-gray-900 mb-2">Forgot Password?</h1>
            <p class="text-gray-600">No worries! Enter your email address and we'll help you reset it.</p>
        </div>

        <!-- Forgot Password Form -->
        <div class="bg-white rounded-2xl shadow-lg border border-gray-100 p-8">
            <c:choose>
                <c:when test="${param.sent == 'true'}">
                    <!-- Success Message -->
                    <div class="text-center">
                        <div class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-6">
                            <i class="fas fa-check text-green-600 text-2xl"></i>
                        </div>
                        <h2 class="text-2xl font-bold text-gray-900 mb-4">Check Your Email</h2>
                        <p class="text-gray-600 mb-6">
                            We've sent password reset instructions to your email address.
                            Please check your inbox and follow the link to reset your password.
                        </p>

                        <div class="bg-blue-50 border border-blue-200 rounded-xl p-4 mb-6 text-left">
                            <div class="flex items-start">
                                <div class="w-6 h-6 bg-blue-500 rounded-full flex items-center justify-center flex-shrink-0 mt-0.5">
                                    <i class="fas fa-info text-white text-xs"></i>
                                </div>
                                <div class="ml-3">
                                    <h4 class="text-blue-900 font-medium text-sm mb-1">Didn't receive an email?</h4>
                                    <ul class="text-blue-700 text-xs space-y-1">
                                        <li>• Check your spam/junk folder</li>
                                        <li>• Make sure the email address is correct</li>
                                        <li>• Wait a few minutes and try again</li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="space-y-3">
                            <button onclick="location.reload()"
                                    class="w-full bg-gradient-to-r from-primary-500 to-secondary-500 text-white px-6 py-3 rounded-xl font-semibold hover:from-primary-600 hover:to-secondary-600 transition-all duration-200 transform hover:scale-105">
                                <i class="fas fa-redo mr-2"></i>Send Another Email
                            </button>

                            <a href="${pageContext.request.contextPath}/user/login"
                               class="w-full bg-gray-100 text-gray-700 px-6 py-3 rounded-xl font-semibold hover:bg-gray-200 transition-colors duration-200 block text-center">
                                <i class="fas fa-arrow-left mr-2"></i>Back to Login
                            </a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Reset Form -->
                    <form action="${pageContext.request.contextPath}/user/forgot-password" method="post" class="space-y-6">
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
                                                <c:when test="${param.error == 'notfound'}">
                                                    No account found with that email address.
                                                </c:when>
                                                <c:when test="${param.error == 'invalid'}">
                                                    Please enter a valid email address.
                                                </c:when>
                                                <c:otherwise>
                                                    Unable to process your request. Please try again.
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <!-- Email Field -->
                        <div>
                            <label for="email" class="block text-sm font-medium text-gray-700 mb-2">
                                <i class="fas fa-envelope mr-2 text-gray-400"></i>Email Address
                            </label>
                            <input type="email"
                                   id="email"
                                   name="email"
                                   required
                                   value="${param.email}"
                                   class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors duration-200 text-gray-900 placeholder-gray-500"
                                   placeholder="Enter your registered email address"
                                   autocomplete="email">
                            <p class="text-xs text-gray-500 mt-1">We'll send reset instructions to this email</p>
                        </div>

                        <!-- Submit Button -->
                        <button type="submit"
                                class="w-full bg-gradient-to-r from-primary-500 to-secondary-500 text-white px-6 py-3 rounded-xl font-semibold text-lg hover:from-primary-600 hover:to-secondary-600 focus:outline-none focus:ring-2 focus:ring-primary-500 focus:ring-offset-2 transition-all duration-200 transform hover:scale-105 shadow-lg">
                            <i class="fas fa-paper-plane mr-2"></i>Send Reset Instructions
                        </button>

                        <!-- Security Notice -->
                        <div class="bg-yellow-50 border border-yellow-200 rounded-xl p-4">
                            <div class="flex items-start">
                                <div class="w-6 h-6 bg-yellow-500 rounded-full flex items-center justify-center flex-shrink-0 mt-0.5">
                                    <i class="fas fa-shield-alt text-white text-xs"></i>
                                </div>
                                <div class="ml-3">
                                    <h4 class="text-yellow-900 font-medium text-sm mb-1">Security Notice</h4>
                                    <p class="text-yellow-700 text-xs">
                                        For your security, the reset link will expire in 24 hours.
                                        If you don't receive an email, the address may not be registered with us.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Alternative Actions -->
        <div class="text-center space-y-4">
            <p class="text-gray-600">
                Remember your password?
                <a href="${pageContext.request.contextPath}/user/login"
                   class="text-primary-600 hover:text-primary-500 font-medium transition-colors duration-200">
                    Sign in here
                </a>
            </p>

            <p class="text-gray-600">
                Don't have an account?
                <a href="${pageContext.request.contextPath}/user/register"
                   class="text-primary-600 hover:text-primary-500 font-medium transition-colors duration-200">
                    Create one now
                </a>
            </p>
        </div>

        <!-- Back to Home -->
        <div class="text-center">
            <a href="${pageContext.request.contextPath}/"
               class="inline-flex items-center text-gray-500 hover:text-gray-700 transition-colors duration-200">
                <i class="fas fa-arrow-left mr-2"></i>
                Back to Home
            </a>
        </div>
    </div>

    <!-- Background Animation -->
    <div class="fixed inset-0 -z-10 overflow-hidden">
        <div class="absolute top-20 left-20 w-72 h-72 bg-primary-200 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse"></div>
        <div class="absolute top-40 right-20 w-72 h-72 bg-secondary-200 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse animation-delay-1000"></div>
        <div class="absolute bottom-20 left-40 w-72 h-72 bg-pink-200 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse animation-delay-2000"></div>
    </div>

    <script>
        // Auto-focus email field when page loads
        document.addEventListener('DOMContentLoaded', function() {
            const emailField = document.getElementById('email');
            if (emailField) {
                emailField.focus();
            }
        });

        // Form validation
        function validateEmail(email) {
            const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return re.test(email);
        }

        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('form');
            const emailInput = document.getElementById('email');
            const submitButton = document.querySelector('button[type="submit"]');

            if (form && emailInput && submitButton) {
                function validateForm() {
                    const isValid = emailInput.value.trim() !== '' && validateEmail(emailInput.value);
                    submitButton.disabled = !isValid;

                    if (isValid) {
                        submitButton.classList.remove('opacity-50', 'cursor-not-allowed');
                    } else {
                        submitButton.classList.add('opacity-50', 'cursor-not-allowed');
                    }
                }

                emailInput.addEventListener('input', validateForm);
                emailInput.addEventListener('blur', validateForm);

                // Initial validation
                validateForm();
            }
        });
    </script>
</body>
</html>