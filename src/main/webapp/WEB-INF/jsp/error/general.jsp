<%@ include file="../includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="../includes/header.jsp" %>
<title>Error - Forum Application</title>

<body>
    <%@ include file="../includes/navigation.jsp" %>

    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card shadow">
                    <div class="card-body text-center py-5">
                        <div class="mb-4">
                            <i class="fas fa-exclamation-triangle fa-4x text-warning"></i>
                        </div>

                        <h1 class="display-6 text-muted mb-3">Oops! Something went wrong</h1>

                        <c:choose>
                            <c:when test="${not empty error}">
                                <p class="text-muted mb-4">${error}</p>
                            </c:when>
                            <c:otherwise>
                                <p class="text-muted mb-4">
                                    We encountered an unexpected error while processing your request.
                                    Our team has been notified and is working to fix this issue.
                                </p>
                            </c:otherwise>
                        </c:choose>

                        <div class="mb-4">
                            <small class="text-muted">
                                <strong>Error Code:</strong> GEN-500<br>
                                <strong>Time:</strong> <fmt:formatDate value="<%= new java.util.Date() %>" pattern="MMM dd, yyyy HH:mm:ss"/>
                            </small>
                        </div>

                        <div class="d-flex justify-content-center gap-3 flex-wrap">
                            <a href="javascript:history.back()" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left me-2"></i>Go Back
                            </a>
                            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                                <i class="fas fa-home me-2"></i>Go Home
                            </a>
                            <a href="${pageContext.request.contextPath}/forum" class="btn btn-outline-primary">
                                <i class="fas fa-comments me-2"></i>Browse Forum
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Help Section -->
                <div class="card mt-4">
                    <div class="card-body">
                        <h6 class="card-title">
                            <i class="fas fa-question-circle text-info me-2"></i>Need Help?
                        </h6>
                        <p class="card-text small text-muted mb-3">
                            If you continue to experience issues, try the following:
                        </p>
                        <ul class="small text-muted">
                            <li>Refresh the page and try again</li>
                            <li>Clear your browser cache and cookies</li>
                            <li>Check your internet connection</li>
                            <li>Try accessing the site from a different browser</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="../includes/footer.jsp" %>
</body>
</html>