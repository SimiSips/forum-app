<%@ include file="includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="includes/header.jsp" %>
<title>Forgot Password - Forum Application</title>

<body class="bg-light">
    <div class="container d-flex align-items-center justify-content-center min-vh-100">
        <div class="row justify-content-center w-100">
            <div class="col-md-6 col-lg-4">
                <div class="card shadow">
                    <div class="card-header bg-warning text-dark text-center py-4">
                        <h3 class="mb-0">
                            <i class="fas fa-key me-2"></i>Forgot Password
                        </h3>
                        <p class="mb-0 mt-2">Reset your account password</p>
                    </div>

                    <div class="card-body p-4">
                        <!-- Messages -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                ${error}
                            </div>
                        </c:if>

                        <c:if test="${not empty success}">
                            <div class="alert alert-success" role="alert">
                                <i class="fas fa-check-circle me-2"></i>
                                ${success}
                                <c:if test="${not empty resetToken}">
                                    <hr>
                                    <small class="d-block mt-2">
                                        <strong>Demo Token:</strong>
                                        <code>${resetToken}</code>
                                        <br><small class="text-muted">In production, this would be sent via email.</small>
                                    </small>
                                    <a href="${pageContext.request.contextPath}/user/reset-password?token=${resetToken}"
                                       class="btn btn-sm btn-outline-success mt-2">
                                        <i class="fas fa-arrow-right me-1"></i>Continue to Reset
                                    </a>
                                </c:if>
                            </div>
                        </c:if>

                        <c:if test="${empty success}">
                            <div class="text-center mb-4">
                                <i class="fas fa-lock fa-3x text-muted mb-3"></i>
                                <p class="text-muted">
                                    Enter your email address and we'll send you instructions to reset your password.
                                </p>
                            </div>

                            <form action="${pageContext.request.contextPath}/user/forgot-password" method="post">
                                <div class="mb-3">
                                    <label for="email" class="form-label">
                                        <i class="fas fa-envelope me-1"></i>Email Address
                                    </label>
                                    <input type="email" class="form-control" id="email" name="email"
                                           required placeholder="Enter your registered email address">
                                </div>

                                <div class="d-grid">
                                    <button type="submit" class="btn btn-warning">
                                        <i class="fas fa-paper-plane me-2"></i>Send Reset Instructions
                                    </button>
                                </div>
                            </form>
                        </c:if>

                        <div class="text-center mt-4">
                            <p class="mb-0">
                                Remember your password?
                                <a href="${pageContext.request.contextPath}/user/login"
                                   class="text-decoration-none">Sign in here</a>
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Help Text -->
                <div class="text-center mt-4">
                    <div class="card">
                        <div class="card-body">
                            <h6 class="card-title">Need Help?</h6>
                            <p class="card-text small text-muted">
                                If you don't receive the reset email within a few minutes, check your spam folder
                                or contact support for assistance.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="includes/footer.jsp" %>
</body>
</html>