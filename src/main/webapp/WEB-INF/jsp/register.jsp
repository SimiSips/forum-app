<%@ include file="includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en" class="h-full">
<%@ include file="includes/header.jsp" %>
<title>Register - Forum Application</title>

<body class="h-full bg-gray-50">
    <div class="min-h-full flex flex-col justify-center py-12 sm:px-6 lg:px-8">
        <div class="sm:mx-auto sm:w-full sm:max-w-md">
            <!-- Logo and Header -->
            <div class="text-center">
                <div class="mx-auto w-16 h-16 bg-gradient-to-r from-primary-500 to-secondary-500 rounded-2xl flex items-center justify-center mb-6 animate-pulse-gentle">
                    <i class="fas fa-user-plus text-white text-2xl"></i>
                </div>
                <h2 class="text-3xl font-bold text-gray-900 mb-2">Create Account</h2>
                <p class="text-sm text-gray-600">Join our forum community today!</p>
            </div>
        </div>

        <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
            <div class="bg-white py-8 px-4 shadow-xl rounded-2xl sm:px-10 border border-gray-100">
                <!-- Error Messages -->
                <c:if test="${not empty error}">
                    <div class="mb-6 bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg animate-slide-down">
                        <div class="flex items-center">
                            <i class="fas fa-exclamation-triangle mr-3 text-red-500"></i>
                            <span>${error}</span>
                        </div>
                    </div>
                </c:if>

                <!-- Registration Form -->
                <form action="${pageContext.request.contextPath}/user/register" method="post" id="registerForm" class="space-y-6">
                    <div class="grid grid-cols-1 gap-6">
                        <!-- Name Fields -->
                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label for="firstName" class="block text-sm font-medium text-gray-700 mb-2">
                                    <i class="fas fa-user mr-2 text-gray-400"></i>First Name *
                                </label>
                                <input type="text" id="firstName" name="firstName" value="${firstName}" required
                                       class="w-full px-4 py-3 border border-gray-300 rounded-lg input-focus transition-all duration-200 bg-gray-50 focus:bg-white"
                                       placeholder="Enter your first name">
                            </div>
                            <div>
                                <label for="lastName" class="block text-sm font-medium text-gray-700 mb-2">
                                    <i class="fas fa-user mr-2 text-gray-400"></i>Last Name *
                                </label>
                                <input type="text" id="lastName" name="lastName" value="${lastName}" required
                                       class="w-full px-4 py-3 border border-gray-300 rounded-lg input-focus transition-all duration-200 bg-gray-50 focus:bg-white"
                                       placeholder="Enter your last name">
                            </div>
                        </div>

                        <!-- Email -->
                        <div>
                            <label for="email" class="block text-sm font-medium text-gray-700 mb-2">
                                <i class="fas fa-envelope mr-2 text-gray-400"></i>Email Address *
                            </label>
                            <input type="email" id="email" name="email" value="${email}" required
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg input-focus transition-all duration-200 bg-gray-50 focus:bg-white"
                                   placeholder="Enter your email address">
                            <p class="mt-2 text-xs text-gray-500">We'll never share your email with anyone else.</p>
                        </div>

                        <!-- Phone -->
                        <div>
                            <label for="phone" class="block text-sm font-medium text-gray-700 mb-2">
                                <i class="fas fa-phone mr-2 text-gray-400"></i>Phone Number
                            </label>
                            <input type="tel" id="phone" name="phone" value="${phone}"
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg input-focus transition-all duration-200 bg-gray-50 focus:bg-white"
                                   placeholder="Enter your phone number (optional)">
                        </div>

                        <!-- Password -->
                        <div>
                            <label for="password" class="block text-sm font-medium text-gray-700 mb-2">
                                <i class="fas fa-lock mr-2 text-gray-400"></i>Password *
                            </label>
                            <div class="relative">
                                <input type="password" id="password" name="password" required
                                       class="w-full px-4 py-3 border border-gray-300 rounded-lg input-focus transition-all duration-200 bg-gray-50 focus:bg-white pr-12"
                                       placeholder="Create a secure password">
                                <button type="button" id="togglePassword"
                                        class="absolute inset-y-0 right-0 pr-4 flex items-center text-gray-400 hover:text-gray-600 transition-colors duration-200">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                            <div class="mt-2">
                                <div class="w-full bg-gray-200 rounded-full h-2">
                                    <div id="passwordStrength" class="h-2 rounded-full transition-all duration-300 bg-gray-300" style="width: 0%"></div>
                                </div>
                                <p id="strengthText" class="mt-1 text-xs text-gray-500">Password strength: </p>
                            </div>
                            <div class="mt-2">
                                <p class="text-xs text-gray-500">
                                    <i class="fas fa-info-circle mr-1"></i>
                                    Password must be at least 8 characters with uppercase, lowercase, number, and special character.
                                </p>
                            </div>
                        </div>

                        <!-- Confirm Password -->
                        <div>
                            <label for="confirmPassword" class="block text-sm font-medium text-gray-700 mb-2">
                                <i class="fas fa-lock mr-2 text-gray-400"></i>Confirm Password *
                            </label>
                            <input type="password" id="confirmPassword" name="confirmPassword" required
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg input-focus transition-all duration-200 bg-gray-50 focus:bg-white"
                                   placeholder="Confirm your password">
                            <div id="passwordMismatch" class="mt-1 text-xs text-red-600 hidden">
                                <i class="fas fa-exclamation-triangle mr-1"></i>
                                Passwords do not match.
                            </div>
                        </div>

                        <!-- Terms Agreement -->
                        <div class="flex items-start">
                            <div class="flex items-center h-5">
                                <input id="agreeTerms" name="agreeTerms" type="checkbox" required
                                       class="w-4 h-4 text-primary-600 bg-gray-100 border-gray-300 rounded focus:ring-primary-500 focus:ring-2">
                            </div>
                            <div class="ml-3">
                                <label for="agreeTerms" class="text-sm text-gray-600">
                                    I agree to the
                                    <a href="#" class="font-medium text-primary-600 hover:text-primary-500">Terms of Service</a>
                                    and
                                    <a href="#" class="font-medium text-primary-600 hover:text-primary-500">Privacy Policy</a> *
                                </label>
                            </div>
                        </div>

                        <!-- Submit Button -->
                        <div>
                            <button type="submit" id="submitBtn"
                                    class="w-full flex justify-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-gradient-to-r from-primary-500 to-secondary-500 hover:from-primary-600 hover:to-secondary-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500 transition-all duration-200 transform hover:scale-[1.02] hover:shadow-lg">
                                <span class="flex items-center">
                                    <i class="fas fa-user-plus mr-2"></i>
                                    Create Account
                                </span>
                            </button>
                        </div>

                        <!-- Login Link -->
                        <div class="text-center">
                            <p class="text-sm text-gray-600">
                                Already have an account?
                                <a href="${pageContext.request.contextPath}/user/login"
                                   class="font-medium text-primary-600 hover:text-primary-500 transition-colors duration-200">
                                    Sign in here
                                </a>
                            </p>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Additional Info -->
            <div class="mt-6 bg-white rounded-2xl shadow-lg border border-gray-100 p-6">
                <h3 class="text-lg font-semibold text-gray-900 mb-4 text-center">
                    <i class="fas fa-star text-yellow-500 mr-2"></i>
                    Why Join Our Forum?
                </h3>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4 text-center">
                    <div class="p-4">
                        <div class="w-12 h-12 bg-gradient-to-r from-blue-500 to-indigo-500 rounded-full flex items-center justify-center mx-auto mb-3">
                            <i class="fas fa-comments text-white text-xl"></i>
                        </div>
                        <h4 class="font-semibold text-gray-900 mb-1">Engage in Discussions</h4>
                        <p class="text-xs text-gray-600">Share ideas and connect with like-minded people</p>
                    </div>
                    <div class="p-4">
                        <div class="w-12 h-12 bg-gradient-to-r from-green-500 to-teal-500 rounded-full flex items-center justify-center mx-auto mb-3">
                            <i class="fas fa-users text-white text-xl"></i>
                        </div>
                        <h4 class="font-semibold text-gray-900 mb-1">Connect with Community</h4>
                        <p class="text-xs text-gray-600">Build relationships with fellow developers</p>
                    </div>
                    <div class="p-4">
                        <div class="w-12 h-12 bg-gradient-to-r from-yellow-500 to-orange-500 rounded-full flex items-center justify-center mx-auto mb-3">
                            <i class="fas fa-lightbulb text-white text-xl"></i>
                        </div>
                        <h4 class="font-semibold text-gray-900 mb-1">Share Knowledge</h4>
                        <p class="text-xs text-gray-600">Learn from others and share your expertise</p>
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

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const passwordInput = document.getElementById('password');
            const confirmPasswordInput = document.getElementById('confirmPassword');
            const togglePasswordBtn = document.getElementById('togglePassword');
            const strengthBar = document.getElementById('passwordStrength');
            const strengthText = document.getElementById('strengthText');
            const form = document.getElementById('registerForm');
            const passwordMismatch = document.getElementById('passwordMismatch');

            // Password visibility toggle
            togglePasswordBtn.addEventListener('click', function() {
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

            // Password strength checker
            passwordInput.addEventListener('input', function() {
                const password = this.value;
                const strength = calculatePasswordStrength(password);

                strengthBar.style.width = strength.percentage + '%';
                strengthBar.className = `h-2 rounded-full transition-all duration-300 ${strength.colorClass}`;
                strengthText.textContent = 'Password strength: ' + strength.text;
            });

            // Password confirmation checker
            confirmPasswordInput.addEventListener('input', function() {
                const password = passwordInput.value;
                const confirmPassword = this.value;

                if (confirmPassword && password !== confirmPassword) {
                    this.classList.add('border-red-300', 'bg-red-50');
                    this.classList.remove('border-gray-300', 'bg-gray-50');
                    passwordMismatch.classList.remove('hidden');
                } else {
                    this.classList.remove('border-red-300', 'bg-red-50');
                    this.classList.add('border-gray-300', 'bg-gray-50');
                    passwordMismatch.classList.add('hidden');
                }
            });

            // Form validation
            form.addEventListener('submit', function(e) {
                const password = passwordInput.value;
                const confirmPassword = confirmPasswordInput.value;
                const agreeTerms = document.getElementById('agreeTerms').checked;

                if (password !== confirmPassword) {
                    e.preventDefault();
                    confirmPasswordInput.classList.add('border-red-300', 'bg-red-50');
                    passwordMismatch.classList.remove('hidden');
                    showAlert('Passwords do not match!', 'error');
                    return false;
                }

                if (!agreeTerms) {
                    e.preventDefault();
                    showAlert('Please agree to the Terms of Service and Privacy Policy.', 'error');
                    return false;
                }

                // Check password strength
                const strength = calculatePasswordStrength(password);
                if (strength.score < 3) {
                    e.preventDefault();
                    showAlert('Please choose a stronger password.', 'error');
                    return false;
                }

                // Show loading state
                showLoading();
            });

            // Calculate password strength
            function calculatePasswordStrength(password) {
                let score = 0;

                if (password.length >= 8) score++;
                if (password.length >= 12) score++;
                if (/[a-z]/.test(password)) score++;
                if (/[A-Z]/.test(password)) score++;
                if (/[0-9]/.test(password)) score++;
                if (/[^A-Za-z0-9]/.test(password)) score++;

                let result = {
                    score: score,
                    percentage: (score / 6) * 100
                };

                if (score < 2) {
                    result.text = 'Very Weak';
                    result.colorClass = 'bg-red-500';
                } else if (score < 3) {
                    result.text = 'Weak';
                    result.colorClass = 'bg-orange-500';
                } else if (score < 5) {
                    result.text = 'Medium';
                    result.colorClass = 'bg-yellow-500';
                } else {
                    result.text = 'Strong';
                    result.colorClass = 'bg-green-500';
                }

                return result;
            }

            // Show loading state
            function showLoading() {
                const submitBtn = document.getElementById('submitBtn');
                submitBtn.disabled = true;
                submitBtn.innerHTML = `
                    <div class="flex items-center">
                        <div class="animate-spin rounded-full h-4 w-4 border-b-2 border-white mr-2"></div>
                        Creating Account...
                    </div>
                `;
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

                form.insertBefore(alertDiv, form.firstChild);

                // Auto-remove after 5 seconds
                setTimeout(() => {
                    alertDiv.remove();
                }, 5000);
            }

            // Auto-dismiss existing alerts
            setTimeout(function() {
                const alerts = document.querySelectorAll('.animate-slide-down');
                alerts.forEach(function(alert) {
                    alert.style.opacity = '0';
                    alert.style.transform = 'translateY(-10px)';
                    setTimeout(() => alert.remove(), 300);
                });
            }, 5000);
        });
    </script>

    <style>
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
    </style>
</body>
</html>