<%@ include file="includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="includes/header.jsp" %>
<title>Register - Forum Application</title>

<body>
    <%@ include file="includes/navigation.jsp" %>

    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card shadow-lg">
                    <div class="card-header bg-primary text-white text-center py-4">
                        <h2 class="mb-0">
                            <i class="fas fa-user-plus me-2"></i>Create Account
                        </h2>
                        <p class="mb-0 mt-2">Join our forum community today!</p>
                    </div>

                    <div class="card-body p-5">
                        <!-- Error Messages -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <!-- Registration Form -->
                        <form action="${pageContext.request.contextPath}/user/register" method="post" id="registerForm">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="firstName" class="form-label">
                                        <i class="fas fa-user me-1"></i>First Name *
                                    </label>
                                    <input type="text" class="form-control" id="firstName" name="firstName"
                                           value="${firstName}" required placeholder="Enter your first name">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="lastName" class="form-label">
                                        <i class="fas fa-user me-1"></i>Last Name *
                                    </label>
                                    <input type="text" class="form-control" id="lastName" name="lastName"
                                           value="${lastName}" required placeholder="Enter your last name">
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="email" class="form-label">
                                    <i class="fas fa-envelope me-1"></i>Email Address *
                                </label>
                                <input type="email" class="form-control" id="email" name="email"
                                       value="${email}" required placeholder="Enter your email address">
                                <div class="form-text">We'll never share your email with anyone else.</div>
                            </div>

                            <div class="mb-3">
                                <label for="phone" class="form-label">
                                    <i class="fas fa-phone me-1"></i>Phone Number
                                </label>
                                <input type="tel" class="form-control" id="phone" name="phone"
                                       value="${phone}" placeholder="Enter your phone number (optional)">
                            </div>

                            <div class="mb-3">
                                <label for="password" class="form-label">
                                    <i class="fas fa-lock me-1"></i>Password *
                                </label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="password" name="password"
                                           required placeholder="Create a secure password">
                                    <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                                <div class="form-text">
                                    <small class="text-muted">
                                        <i class="fas fa-info-circle me-1"></i>
                                        ${passwordRequirements}
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
                                    <i class="fas fa-lock me-1"></i>Confirm Password *
                                </label>
                                <input type="password" class="form-control" id="confirmPassword"
                                       name="confirmPassword" required placeholder="Confirm your password">
                                <div class="invalid-feedback" id="passwordMismatch">
                                    Passwords do not match.
                                </div>
                            </div>

                            <div class="mb-4">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="agreeTerms" required>
                                    <label class="form-check-label" for="agreeTerms">
                                        I agree to the <a href="#" class="text-decoration-none">Terms of Service</a>
                                        and <a href="#" class="text-decoration-none">Privacy Policy</a> *
                                    </label>
                                </div>
                            </div>

                            <div class="d-grid mb-3">
                                <button type="submit" class="btn btn-primary btn-lg" id="submitBtn">
                                    <i class="fas fa-user-plus me-2"></i>Create Account
                                </button>
                            </div>

                            <div class="text-center">
                                <p class="mb-0">Already have an account?
                                    <a href="${pageContext.request.contextPath}/user/login"
                                       class="text-decoration-none fw-bold">Sign in here</a>
                                </p>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Additional Info -->
                <div class="text-center mt-4">
                    <div class="card">
                        <div class="card-body">
                            <h6 class="card-title">Why Join Our Forum?</h6>
                            <div class="row text-center">
                                <div class="col-md-4">
                                    <i class="fas fa-comments fa-2x text-primary mb-2"></i>
                                    <p class="small mb-0">Engage in Discussions</p>
                                </div>
                                <div class="col-md-4">
                                    <i class="fas fa-users fa-2x text-success mb-2"></i>
                                    <p class="small mb-0">Connect with Community</p>
                                </div>
                                <div class="col-md-4">
                                    <i class="fas fa-lightbulb fa-2x text-warning mb-2"></i>
                                    <p class="small mb-0">Share Knowledge</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="includes/footer.jsp" %>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const passwordInput = document.getElementById('password');
            const confirmPasswordInput = document.getElementById('confirmPassword');
            const togglePasswordBtn = document.getElementById('togglePassword');
            const strengthBar = document.getElementById('passwordStrength');
            const strengthText = document.getElementById('strengthText');
            const form = document.getElementById('registerForm');

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
                const agreeTerms = document.getElementById('agreeTerms').checked;

                if (password !== confirmPassword) {
                    e.preventDefault();
                    confirmPasswordInput.classList.add('is-invalid');
                    alert('Passwords do not match!');
                    return false;
                }

                if (!agreeTerms) {
                    e.preventDefault();
                    alert('Please agree to the Terms of Service and Privacy Policy.');
                    return false;
                }

                // Check password strength
                const strength = calculatePasswordStrength(password);
                if (strength.score < 3) {
                    e.preventDefault();
                    alert('Please choose a stronger password.');
                    return false;
                }
            });

            function calculatePasswordStrength(password) {
                let score = 0;
                let feedback = [];

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