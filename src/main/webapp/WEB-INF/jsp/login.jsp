<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en" class="h-full">
<%@ include file="includes/header.jsp" %>
<title>Login - Forum Application</title>

<body class="h-full bg-gray-50">
    <div class="min-h-full flex flex-col justify-center py-12 sm:px-6 lg:px-8">
        <div class="sm:mx-auto sm:w-full sm:max-w-md">
            <!-- Logo and Header -->
            <div class="text-center">
                <div class="mx-auto w-16 h-16 bg-gradient-to-r from-primary-500 to-secondary-500 rounded-2xl flex items-center justify-center mb-6 animate-pulse-gentle">
                    <i class="fas fa-comments text-white text-2xl"></i>
                </div>
                <h2 class="text-3xl font-bold text-gray-900 mb-2">Welcome Back</h2>
                <p class="text-sm text-gray-600">Sign in to your account to continue</p>
            </div>
        </div>

        <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
            <div class="bg-white py-8 px-4 shadow-xl rounded-2xl sm:px-10 border border-gray-100">
                <!-- Display Messages -->
                <c:if test="${not empty error}">
                    <div class="mb-6 bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg animate-slide-down">
                        <div class="flex items-center">
                            <i class="fas fa-exclamation-triangle mr-3 text-red-500"></i>
                            <span>${error}</span>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty success}">
                    <div class="mb-6 bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-lg animate-slide-down">
                        <div class="flex items-center">
                            <i class="fas fa-check-circle mr-3 text-green-500"></i>
                            <span>${success}</span>
                        </div>
                    </div>
                </c:if>

                <c:if test="${param.message == 'logged-out'}">
                    <div class="mb-6 bg-blue-50 border border-blue-200 text-blue-700 px-4 py-3 rounded-lg animate-slide-down">
                        <div class="flex items-center">
                            <i class="fas fa-info-circle mr-3 text-blue-500"></i>
                            <span>You have been logged out successfully.</span>
                        </div>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/user/login" method="post" id="loginForm" class="space-y-6">
                    <!-- Email Field -->
                    <div>
                        <label for="email" class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="fas fa-envelope mr-2 text-gray-400"></i>Email Address
                        </label>
                        <input type="email" id="email" name="email" value="${email}" required
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg input-focus transition-all duration-200 bg-gray-50 focus:bg-white"
                               placeholder="Enter your email address">
                    </div>

                    <!-- Password Field -->
                    <div>
                        <label for="password" class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="fas fa-lock mr-2 text-gray-400"></i>Password
                        </label>
                        <div class="relative">
                            <input type="password" id="password" name="password" required
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg input-focus transition-all duration-200 bg-gray-50 focus:bg-white pr-12"
                                   placeholder="Enter your password">
                            <button type="button" id="togglePassword"
                                    class="absolute inset-y-0 right-0 pr-4 flex items-center text-gray-400 hover:text-gray-600 transition-colors duration-200">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                    </div>

                    <!-- Remember Me and Forgot Password -->
                    <div class="flex items-center justify-between">
                        <div class="flex items-center">
                            <input type="checkbox" id="rememberMe" name="rememberMe"
                                   class="w-4 h-4 text-primary-600 bg-gray-100 border-gray-300 rounded focus:ring-primary-500 focus:ring-2">
                            <label for="rememberMe" class="ml-2 text-sm text-gray-600">
                                Remember me
                            </label>
                        </div>
                        <a href="${pageContext.request.contextPath}/user/forgot-password"
                           class="text-sm font-medium text-primary-600 hover:text-primary-500 transition-colors duration-200">
                            Forgot password?
                        </a>
                    </div>

                    <!-- Hidden redirect field -->
                    <c:if test="${not empty param.redirectTo}">
                        <input type="hidden" name="redirectTo" value="${param.redirectTo}">
                    </c:if>

                    <!-- Submit Button -->
                    <div>
                        <button type="submit" id="loginButton"
                                class="w-full flex justify-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-gradient-to-r from-primary-500 to-secondary-500 hover:from-primary-600 hover:to-secondary-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500 transition-all duration-200 transform hover:scale-[1.02] hover:shadow-lg">
                            <span class="flex items-center">
                                <i class="fas fa-sign-in-alt mr-2"></i>
                                Sign In
                            </span>
                        </button>
                    </div>

                    <!-- Registration Link -->
                    <div class="text-center">
                        <p class="text-sm text-gray-600">
                            Don't have an account?
                            <a href="${pageContext.request.contextPath}/user/register"
                               class="font-medium text-primary-600 hover:text-primary-500 transition-colors duration-200">
                                Create one here
                            </a>
                        </p>
                    </div>
                </form>

                <!-- Social Login Options (Future Enhancement) -->
                <div class="mt-6">
                    <div class="relative">
                        <div class="absolute inset-0 flex items-center">
                            <div class="w-full border-t border-gray-300"></div>
                        </div>
                        <div class="relative flex justify-center text-sm">
                            <span class="px-2 bg-white text-gray-500">Or continue with</span>
                        </div>
                    </div>

                    <div class="mt-6">
                        <a href="${pageContext.request.contextPath}/forum"
                           class="w-full inline-flex justify-center py-3 px-4 border border-gray-300 rounded-lg shadow-sm text-sm font-medium text-gray-500 bg-white hover:bg-gray-50 transition-all duration-200">
                            <i class="fas fa-eye mr-2"></i>
                            Browse as Guest
                        </a>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <div class="mt-8 text-center">
                <p class="text-xs text-gray-500">
                    &copy; 2025 Forum Application by Simphiwe Radebe
                </p>
            </div>
        </div>
    </div>

    <!-- Loading Overlay -->
    <div id="loadingOverlay" class="fixed inset-0 bg-gray-900 bg-opacity-50 hidden items-center justify-center z-50">
        <div class="bg-white rounded-lg p-6 shadow-xl">
            <div class="flex items-center space-x-3">
                <div class="animate-spin rounded-full h-6 w-6 border-b-2 border-primary-500"></div>
                <span class="text-gray-700 font-medium">Signing you in...</span>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const loginForm = document.getElementById('loginForm');
            const loginButton = document.getElementById('loginButton');
            const togglePassword = document.getElementById('togglePassword');
            const passwordInput = document.getElementById('password');
            const loadingOverlay = document.getElementById('loadingOverlay');

            // Password visibility toggle
            togglePassword.addEventListener('click', function() {
                const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                passwordInput.setAttribute('type', type);

                const icon = this.querySelector('i');
                if (type === 'password') {
                    icon.classList.remove('fa-eye-slash');
                    icon.classList.add('fa-eye');
                } else {
                    icon.classList.remove('fa-eye');
                    icon.classList.add('fa-eye-slash');
                }
            });

            // Form validation and submission
            loginForm.addEventListener('submit', function(e) {
                const email = document.getElementById('email').value.trim();
                const password = document.getElementById('password').value.trim();

                // Basic validation
                if (!email || !password) {
                    e.preventDefault();
                    showAlert('Please fill in all required fields.', 'error');
                    return false;
                }

                // Email validation
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    e.preventDefault();
                    showAlert('Please enter a valid email address.', 'error');
                    return false;
                }

                // Show loading state
                showLoading();
            });

            // Show loading overlay
            function showLoading() {
                loginButton.disabled = true;
                loginButton.innerHTML = `
                    <div class="flex items-center">
                        <div class="animate-spin rounded-full h-4 w-4 border-b-2 border-white mr-2"></div>
                        Signing In...
                    </div>
                `;
                loadingOverlay.classList.remove('hidden');
                loadingOverlay.classList.add('flex');
            }

            // Show alert message
            function showAlert(message, type) {
                const alertDiv = document.createElement('div');
                const bgColor = type === 'error' ? 'bg-red-50 border-red-200 text-red-700' : 'bg-green-50 border-green-200 text-green-700';
                const iconClass = type === 'error' ? 'fas fa-exclamation-triangle text-red-500' : 'fas fa-check-circle text-green-500';

                alertDiv.className = `mb-6 ${bgColor} border px-4 py-3 rounded-lg animate-slide-down`;
                alertDiv.innerHTML = `
                    <div class="flex items-center">
                        <i class="${iconClass} mr-3"></i>
                        <span>${message}</span>
                    </div>
                `;

                const form = loginForm;
                form.insertBefore(alertDiv, form.firstChild);

                // Auto-remove after 5 seconds
                setTimeout(() => {
                    alertDiv.remove();
                }, 5000);
            }

            // Focus on email field
            document.getElementById('email').focus();

            // Auto-dismiss existing alerts
            setTimeout(function() {
                const alerts = document.querySelectorAll('.animate-slide-down');
                alerts.forEach(function(alert) {
                    alert.style.opacity = '0';
                    alert.style.transform = 'translateY(-10px)';
                    setTimeout(() => alert.remove(), 300);
                });
            }, 5000);

            // Add floating label effect
            const inputs = document.querySelectorAll('input[type="email"], input[type="password"]');
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.classList.add('focused');
                });

                input.addEventListener('blur', function() {
                    if (!this.value) {
                        this.parentElement.classList.remove('focused');
                    }
                });

                // Check if input has value on load
                if (input.value) {
                    input.parentElement.classList.add('focused');
                }
            });
        });

        // Add some interactive animations
        document.querySelectorAll('input').forEach(input => {
            input.addEventListener('focus', function() {
                this.classList.add('scale-[1.02]');
            });

            input.addEventListener('blur', function() {
                this.classList.remove('scale-[1.02]');
            });
        });

        // Prevent form resubmission on page refresh
        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }
    </script>

    <style>
        /* Custom animations for this page */
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .animate-slide-down {
            animation: slideDown 0.3s ease-out;
        }

        /* Floating label styles */
        .floating-label {
            position: relative;
        }

        .floating-label.focused label {
            transform: translateY(-1.5rem) scale(0.85);
            color: #667eea;
        }

        /* Enhanced input styles */
        input:focus {
            transform: scale(1.01);
        }

        /* Gradient text for links */
        .gradient-text {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
    </style>
</body>
</html>