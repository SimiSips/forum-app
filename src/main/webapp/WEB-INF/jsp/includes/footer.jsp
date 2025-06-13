<%@ include file="taglibs.jsp" %>

<!-- Footer -->
<footer class="bg-dark text-light py-5 mt-5">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h5 class="text-gradient fw-bold">
                    <i class="fas fa-comments me-2"></i>Forum Application
                </h5>
                <p class="text-muted mb-3">
                    Advanced Java Programming Project<br>
                    A comprehensive forum application with modern web technologies.
                </p>
                <div class="mb-3">
                    <span class="badge bg-primary me-2">
                        <i class="fas fa-code me-1"></i>Java
                    </span>
                    <span class="badge bg-success me-2">
                        <i class="fas fa-database me-1"></i>MySQL
                    </span>
                    <span class="badge bg-info me-2">
                        <i class="fas fa-globe me-1"></i>JSP/Servlets
                    </span>
                    <span class="badge bg-warning text-dark">
                        <i class="fas fa-cogs me-1"></i>Web Services
                    </span>
                </div>
            </div>

            <div class="col-md-3">
                <h6 class="fw-bold mb-3">Quick Links</h6>
                <ul class="list-unstyled">
                    <li class="mb-2">
                        <a href="${pageContext.request.contextPath}/" class="text-muted text-decoration-none">
                            <i class="fas fa-home me-2"></i>Home
                        </a>
                    </li>
                    <c:choose>
                        <c:when test="${not empty sessionScope.userId}">
                            <li class="mb-2">
                                <a href="${pageContext.request.contextPath}/forum" class="text-muted text-decoration-none">
                                    <i class="fas fa-comments me-2"></i>Forum
                                </a>
                            </li>
                            <li class="mb-2">
                                <a href="${pageContext.request.contextPath}/user/profile" class="text-muted text-decoration-none">
                                    <i class="fas fa-user me-2"></i>Profile
                                </a>
                            </li>
                            <li class="mb-2">
                                <a href="${pageContext.request.contextPath}/forum/create-topic" class="text-muted text-decoration-none">
                                    <i class="fas fa-plus me-2"></i>New Topic
                                </a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="mb-2">
                                <a href="${pageContext.request.contextPath}/user/login" class="text-muted text-decoration-none">
                                    <i class="fas fa-sign-in-alt me-2"></i>Login
                                </a>
                            </li>
                            <li class="mb-2">
                                <a href="${pageContext.request.contextPath}/user/register" class="text-muted text-decoration-none">
                                    <i class="fas fa-user-plus me-2"></i>Register
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>

            <div class="col-md-3">
                <h6 class="fw-bold mb-3">Technical Info</h6>
                <ul class="list-unstyled text-muted">
                    <li class="mb-2">
                        <i class="fas fa-graduation-cap me-2"></i>
                        Module: ITHCA0
                    </li>
                    <li class="mb-2">
                        <i class="fas fa-user-tie me-2"></i>
                        Developer: Simphiwe Radebe
                    </li>
                    <li class="mb-2">
                        <i class="fas fa-calendar me-2"></i>
                        Year: 2025
                    </li>
                    <li class="mb-2">
                        <i class="fas fa-code-branch me-2"></i>
                        Version: 1.0.0
                    </li>
                </ul>
            </div>
        </div>

        <hr class="my-4">

        <!-- Bottom footer -->
        <div class="row align-items-center">
            <div class="col-md-6">
                <p class="text-muted mb-0">
                    &copy; 2025 Forum Application. Built for educational purposes.
                </p>
            </div>
            <div class="col-md-6 text-end">
                <small class="text-muted">
                    <i class="fas fa-server me-1"></i>
                    Server Time:
                    <span id="server-time">
                        <fmt:formatDate value="<%= new java.util.Date() %>" pattern="MMM dd, yyyy HH:mm:ss"/>
                    </span>
                </small>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom JavaScript -->
<script>
    // Auto-dismiss alerts after 5 seconds
    document.addEventListener('DOMContentLoaded', function() {
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                if (alert.classList.contains('alert-dismissible')) {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                }
            });
        }, 5000);

        // Update server time every minute
        setInterval(function() {
            const timeElement = document.getElementById('server-time');
            if (timeElement) {
                const now = new Date();
                const options = {
                    year: 'numeric',
                    month: 'short',
                    day: '2-digit',
                    hour: '2-digit',
                    minute: '2-digit',
                    second: '2-digit'
                };
                timeElement.textContent = now.toLocaleDateString('en-US', options);
            }
        }, 60000);

        // Smooth scroll for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth'
                    });
                }
            });
        });

        // Add loading states to forms
        const forms = document.querySelectorAll('form');
        forms.forEach(form => {
            form.addEventListener('submit', function() {
                const submitBtn = form.querySelector('button[type="submit"]');
                if (submitBtn) {
                    const originalText = submitBtn.innerHTML;
                    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Please wait...';
                    submitBtn.disabled = true;

                    // Re-enable after 10 seconds in case of issues
                    setTimeout(() => {
                        submitBtn.innerHTML = originalText;
                        submitBtn.disabled = false;
                    }, 10000);
                }
            });
        });
    });

    // Global function to show loading state
    function showLoading(element) {
        if (element) {
            element.classList.add('loading', 'show');
        }
    }

    // Global function to hide loading state
    function hideLoading(element) {
        if (element) {
            element.classList.remove('loading', 'show');
        }
    }

    // Global function for AJAX error handling
    function handleAjaxError(xhr, status, error) {
        console.error('AJAX Error:', error);
        alert('An error occurred while processing your request. Please try again.');
    }
</script>