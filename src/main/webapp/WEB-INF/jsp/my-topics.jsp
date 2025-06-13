<%@ include file="includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="includes/header.jsp" %>
<title>My Topics - Forum Application</title>

<body>
    <%@ include file="includes/navigation.jsp" %>

    <div class="container mt-4 mb-5">
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-list me-2"></i>My Topics</h2>
                    <a href="${pageContext.request.contextPath}/forum/create-topic"
                       class="btn btn-primary">
                        <i class="fas fa-plus me-2"></i>Create New Topic
                    </a>
                </div>

                <c:choose>
                    <c:when test="${not empty topics}">
                        <c:forEach var="topic" items="${topics}">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <h5 class="card-title">${topic.title}</h5>
                                    <p class="card-text">${topic.description}</p>
                                    <small class="text-muted">
                                        Created: <fmt:formatDate value="${topic.dateCreated}" pattern="MMM dd, yyyy"/>
                                        | Comments: ${topic.commentCount}
                                    </small>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="card">
                            <div class="card-body text-center py-5">
                                <i class="fas fa-plus fa-3x text-muted mb-3"></i>
                                <h5>No Topics Yet</h5>
                                <p class="text-muted">You haven't created any topics yet.</p>
                                <a href="${pageContext.request.contextPath}/forum/create-topic"
                                   class="btn btn-primary">
                                    <i class="fas fa-plus me-2"></i>Create Your First Topic
                                </a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <%@ include file="includes/footer.jsp" %>
</body>
</html>