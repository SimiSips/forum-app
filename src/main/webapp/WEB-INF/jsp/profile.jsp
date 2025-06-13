<%@ include file="includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="includes/header.jsp" %>
<title>Profile - ${user.fullName} - Forum Application</title>

<body>
    <%@ include file="includes/navigation.jsp" %>

    <div class="container mt-4 mb-5">
        <div class="row">
            <!-- Profile Sidebar -->
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body text-center">
                        <div class="avatar mx-auto mb-3" style="width: 100px; height: 100px; font-size: 2rem;">
                            ${fn:substring(user.firstName, 0, 1)}${fn:substring(user.lastName, 0, 1)}
                        </div>
                        <h4 class="card-title">${user.fullName}</h4>
                        <p class="text-muted">${user.email}</p>
                        <div class="row text-center mt-4">
                            <div class="col-6">
                                <div class="border-end">
                                    <h5 class="text-primary mb-0">${userTopicCount}</h5>
                                    <small class="text-muted">Topics</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <h5 class="text-success mb-0">${userCommentCount}</h5>
                                <small class="text-muted">Comments</small>
                            </div>
                        </div>
                        <div class="mt-3">
                            <small class="text-muted">
                                <i class="fas fa-calendar-alt me-1"></i>
                                Member since: <fmt:formatDate value="${user.dateRegistered}" pattern="MMM yyyy"/>
                            </small>
                        </div>
                        <c:if test="${user.lastLogin != null}">
                            <div class="mt-2">
                                <small class="text-muted">
                                    <i class="fas fa-clock me-1"></i>
                                    Last login: <fmt:formatDate value="${user.lastLogin}" pattern="MMM dd, yyyy HH:mm"/>
                                </small>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="card mt-3">
                    <div class="card-header">
                        <h6 class="mb-0"><i class="fas fa-bolt me-2"></i>Quick Actions</h6>
                    </div>
                    <div class="card-body">
                        <div class="d-grid gap-2">
                            <a href="${pageContext.request.contextPath}/forum/create-topic"
                               class="btn btn-primary">
                                <i class="fas fa-plus me-2"></i>Create New Topic
                            </a>
                            <a href="${pageContext.request.contextPath}/forum/my-topics"
                               class="btn btn-outline-primary">
                                <i class="fas fa-list me-2"></i>My Topics
                            </a>
                            <a href="${pageContext.request.contextPath}/forum"
                               class="btn btn-outline-secondary">
                                <i class="fas fa-comments me-2"></i>Browse Forum
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-8">
                <!-- Success/Error Messages -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>
                        ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Profile Information Tab -->
                <div class="card">
                    <div class="card-header">
                        <ul class="nav nav-tabs card-header-tabs" id="profileTabs" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="info-tab" data-bs-toggle="tab"
                                        data-bs-target="#info" type="button" role="tab">
                                    <i class="fas fa-user me-2"></i>Profile Information
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="password-tab" data-bs-toggle="tab"
                                        data-bs-target="#password" type="button" role="tab">
                                    <i class="fas fa-lock me-2"></i>Change Password
                                </button>
                            </li>
                        </ul>
                    </div>

                    <div class="card-body">
                        <div class="tab-content" id="profileTabsContent">
                            <!-- Profile Information Tab -->
                            <div class="tab-pane fade show active" id="info" role="tabpanel">
                                <form action="${pageContext.request.contextPath}/user/update-profile" method="post">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="firstName" class="form-label">
                                                <i class="fas fa-user me-1"></i>First Name *
                                            </label>
                                            <input type="text" class="form-control" id="firstName" name="firstName"
                                                   value="${user.firstName}" required>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="lastName" class="form-label">
                                                <i class="fas fa-user me-1"></i>Last Name *
                                            </label>
                                            <input type="text" class="form-control" id="lastName" name="lastName"
                                                   value="${user.lastName}" required>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="email" class="form-label">
                                            <i class="fas fa-envelope me-1"></i>Email Address
                                        </label>
                                        <input type="email" class="form-control" id="email" value="${user.email}"
                                               disabled readonly>
                                        <div class="form-text">Email address cannot be changed.</div>
                                    </div>

                                    <div class="mb-4">
                                        <label for="phone" class="form-label">
                                            <i class="fas fa-phone me-1"></i>Phone Number
                                        </label>
                                        <input type="tel" class="form-control" id="phone" name="phone"
                                               value="${user.phone}" placeholder="Enter your phone number">
                                    </div>

                                    <div class="d-flex justify-content-between">
                                        <button type="button" class="btn btn-outline-secondary" onclick="resetForm()">
                                            <i class="fas fa-undo me-2"></i>Reset
                                        </button>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save me-2"></i>Update Profile
                                        </button>
                                    </div>
                                </form>
                            </div>

                            <!-- Change Password Tab -->
                            <div class="tab-pane fade" id="password" role="tabpanel">
                                <form action="${pageContext.request.contextPath}/user/change-password" method="post"
                                      id="passwordForm">
                                    <div class="mb-3">
                                        <label for="currentPassword" class="form-label">
                                            <i class="fas fa-lock me-1"></i>Current Password *
                                        </label>
                                        <input type="password" class="form-control" id="currentPassword"
                                               name="currentPassword" required placeholder="Enter your current password">
                                    </div>

                                    <div class="mb-3">
                                        <label for="newPassword" class="form-label">
                                            <i class="fas fa-key me-1"></i>New Password *
                                        </label>
                                        <input type="password" class="form-control" id="newPassword"
                                               name="newPassword" required placeholder="Enter your new password">
                                        <div class="form-text">
                                            <small class="text-muted">
                                                Password must be at least 8 characters with uppercase, lowercase, number, and special character.
                                            </small>
                                        </div>
                                    </div>

                                    <div class="mb-4">
                                        <label for="confirmNewPassword" class="form-label">
                                            <i class="fas fa-key me-1"></i>Confirm New Password *
                                        </label>
                                        <input type="password" class="form-control" id="confirmNewPassword"
                                               required placeholder="Confirm your new password">
                                        <div class="invalid-feedback" id="passwordMismatchFeedback">
                                            Passwords do not match.
                                        </div>
                                    </div>

                                    <div class="d-flex justify-content-between">
                                        <a href="${pageContext.request.contextPath}/user/forgot-password"
                                           class="btn btn-link text-decoration-none">
                                            <i class="fas fa-question-circle me-1"></i>Forgot Password?
                                        </a>
                                        <button type="submit" class="btn btn-warning">
                                            <i class="fas fa-key me-2"></i>Change Password
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Account Information -->
                <div class="card mt-4">
                    <div class="card-header">
                        <h6 class="mb-0"><i class="fas fa-info-circle me-2"></i>Account Information</h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <table class="table table-borderless table-sm">
                                    <tr>
                                        <td class="text-muted">User ID:</td>
                                        <td>${user.userId}</td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted">Registration Date:</td>
                                        <td><fmt:formatDate value="${user.dateRegistered}" pattern="MMMM dd, yyyy"/></td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted">Account Status:</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${user.active}">
                                                    <span class="badge bg-success">Active</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger">Inactive</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-md-6">
                                <table class="table table-borderless table-sm">
                                    <tr>
                                        <td class="text-muted">Topics Created:</td>
                                        <td>
                                            <span class="badge badge-custom">${userTopicCount}</span>
                                            <a href="${pageContext.request.contextPath}/forum/my-topics"
                                               class="ms-2 text-decoration-none">View All</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted">Comments Posted:</td>
                                        <td><span class="badge badge-custom">${userCommentCount}</span></td>
                                    </tr>
                                    <c:if test="${user.lastLogin != null}">
                                        <tr>
                                            <td class="text-muted">Last Login:</td>
                                            <td><fmt:formatDate value="${user.lastLogin}" pattern="MMM dd, yyyy HH:mm"/></td>
                                        </tr>
                                    </c:if>
                                </table>
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
            const passwordForm = document.getElementById('passwordForm');
            const newPasswordInput = document.getElementById('newPassword');
            const confirmPasswordInput = document.getElementById('confirmNewPassword');

            // Password confirmation validation
            confirmPasswordInput.addEventListener('input', function() {
                const newPassword = newPasswordInput.value;
                const confirmPassword = this.value;

                if (confirmPassword && newPassword !== confirmPassword) {
                    this.classList.add('is-invalid');
                } else {
                    this.classList.remove('is-invalid');
                }
            });

            // Password form validation
            passwordForm.addEventListener('submit', function(e) {
                const newPassword = newPasswordInput.value;
                const confirmPassword = confirmPasswordInput.value;

                if (newPassword !== confirmPassword) {
                    e.preventDefault();
                    confirmPasswordInput.classList.add('is-invalid');
                    alert('New passwords do not match!');
                    return false;
                }
            });
        });

        function resetForm() {
            const form = document.querySelector('#info form');
            form.reset();
            // Restore original values
            document.getElementById('firstName').value = '${user.firstName}';
            document.getElementById('lastName').value = '${user.lastName}';
            document.getElementById('phone').value = '${user.phone}';
        }
    </script>
</body>
</html>