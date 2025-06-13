<%@ include file="includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="includes/header.jsp" %>
<title>Reset Password - Forum Application</title>

<body class="bg-light">
    <div class="container d-flex align-items-center justify-content-center min-vh-100">
        <div class="row justify-content-center w-100">
            <div class="col-md-6 col-lg-4">
                <div class="card shadow">
                    <div class="card-header bg-success text-white text-center py-4">
                        <h3 class="mb-0">
                            <i class="fas fa-lock me-2"></i>Reset Password
                        </h3>
                        <p class="mb-0 mt-2">Create a new password for your account</p>
                    </div>

                    <div class="card-body p-4">
                        <!-- Messages -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                ${error}
                            </div>
                        </c:if>

                        <div class="text-center mb-4">
                            <i class="fas fa-key fa-3x text-success mb-3"></i>
                            <p class="text-muted">
                                Enter your new password below. Make sure it's strong and secure.
                            </p>
                        </div>

                        <form action="${pageContext.request.contextPath}/user/reset-password" method="post"
                              id="resetForm">
                            <input type="hidden" name="token" value="${token}">

                            <div class="mb-3">
                                <label for="newPassword" class="form-label">
                                    <i class="fas fa-key me-1"></i>New Password
                                </label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="newPassword" name="newPassword"
                                           required placeholder="Enter your new password">
                                    <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                                <div class="form-text">
                                    <small class="text-muted">
                                        Password must be at least 8 characters with uppercase, lowercase, number, and special character.
                                    </small>
                                </div>
                                <div class="mt-2">
                                    <div class="progress" style="height: 5px;">
                                        <div class="progress-bar" id="passwordStrength" role="progressbar"
                                             style="width: 0%"></div>
                                    </div>
                                    <small class="text-muted" id="strengthText">Password strength: </small>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="confirmPassword" class="form-label">
                                    <i class="fas fa-lock me-1"></i>Confirm Password
                                </label>
                                <input type="password" class="form-control" id="confirmPassword"
                                       name="confirmPassword" required placeholder="Confirm your new password">
                                <div class="invalid-feedback" id="passwordMismatch">
                                    Passwords do not match.
                                </div>
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-success" id="submitBtn">
                                    <i class="fas fa-check me-2"></i>Reset Password
                                </button>
                            </div>
                        </form>

                        <div class="text-center mt-4">
                            <p class="mb-0">
                                <a href="${pageContext.request.contextPath}/user/login"
                                   class="text-decoration-none">
                                    <i class="fas fa-arrow-left me-1"></i>Back to Login
                                </a>
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Security Tips -->
                <div class="text-center mt-4">
                    <div class="card">
                        <div class="card-body">
                            <h6 class="card-title">
                                <i class="fas fa-shield-alt text-success me-2"></i>Security Tips
                            </h6>
                            <ul class="list-unstyled small text-muted mb-0">
                                <li><i class="fas fa-check text-success me-2"></i>Use a unique password</li>
                                <li><i class="fas fa-check text-success me-2"></i>Include numbers and symbols</li>
                                <li><i class="fas fa-check text-success me-2"></i>Avoid personal information</li>
                                <li><i class="fas fa-check text-success me-2"></i>Keep it confidential</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="includes/footer.jsp" %>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const passwordInput = document.getElementById('newPassword');
            const confirmPasswordInput = document.getElementById('confirmPassword');
            const togglePasswordBtn = document.getElementById('togglePassword');
            const strengthBar = document.getElementById('passwordStrength');
            const strengthText = document.getElementById('strengthText');
            const form = document.getElementById('resetForm');

            // Password visibility toggle
            togglePasswordBtn.addEventListener('click', function() {
                const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                passwordInput.setAttribute('type', type);
                this.querySelector('i').classList.toggle('fa-eye');
                this.querySelector('i').classList.toggle('fa-eye-slash');
            });

            // Password strength checker
            passwordInput.addEventListener('input', function() {
                const password = this.value;
                const strength = calculatePasswordStrength(password);

                strengthBar.style.width = strength.percentage + '%';
                strengthBar.className = 'progress-bar ' + strength.class;
                strengthText.textContent = 'Password strength: ' + strength.text;
            });

            // Password confirmation checker
            confirmPasswordInput.addEventListener('input', function() {
                const password = passwordInput.value;
                const confirmPassword = this.value;

                if (confirmPassword && password !== confirmPassword) {
                    this.classList.add('is-invalid');
                } else {
                    this.classList.remove('is-invalid');
                }
            });

            // Form validation
            form.addEventListener('submit', function(e) {
                const password = passwordInput.value;
                const confirmPassword = confirmPasswordInput.value;

                if (password !== confirmPassword) {
                    e.preventDefault();
                    confirmPasswordInput.classList.add('is-invalid');
                    alert('Passwords do not match!');
                    return false;
                }

                // Check password strength
                const strength = calculatePasswordStrength(password);
                if (strength.score < 3) {
                    e.preventDefault();
                    alert('Please choose a stronger password.');
                    return false;
                }

                // Show loading state
                const submitBtn = document.getElementById('submitBtn');
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Resetting...';
                submitBtn.disabled = true;
            });

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

                if (score < 3) {
                    result.text = 'Weak';
                    result.class = 'bg-danger';
                } else if (score < 5) {
                    result.text = 'Medium';
                    result.class = 'bg-warning';
                } else {
                    result.text = 'Strong';
                    result.class = 'bg-success';
                }

                return result;
            }
        });
    </script>
</body>
</html>