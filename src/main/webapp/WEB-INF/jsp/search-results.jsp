<%@ include file="includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="includes/header.jsp" %>
<title>Search Results - Forum Application</title>

<body>
    <%@ include file="includes/navigation.jsp" %>

    <div class="container mt-4 mb-5">
        <div class="row">
            <div class="col-12">
                <h2>
                    <i class="fas fa-search me-2"></i>Search Results
                    <c:if test="${not empty searchTerm}">
                        for "${searchTerm}"
                    </c:if>
                </h2>

                <c:choose>
                    <c:when test="${not empty topics}">
                        <p class="text-muted">Found ${fn:length(topics)} result(s)</p>

                        <c:forEach var="topic" items="${topics}">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <h5 class="card-title">
                                        <a href="${pageContext.request.contextPath}/forum/topic/${topic.topicId}"
                                           class="text-decoration-none">${topic.title}</a>
                                    </h5>
                                    <p class="card-text">${topic.description}</p>
                                    <small class="text-muted">
                                        By: ${topic.userFullName} |
                                        Created: <fmt:formatDate value="${topic.dateCreated}" pattern="MMM dd, yyyy"/> |
                                        Comments: ${topic.commentCount}
                                    </small>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="card">
                            <div class="card-body text-center py-5">
                                <i class="fas fa-search fa-3x text-muted mb-3"></i>
                                <h5>No Results Found</h5>
                                <c:choose>
                                    <c:when test="${not empty searchTerm}">
                                        <p class="text-muted">
                                            No topics found matching "${searchTerm}".
                                            Try different keywords or
                                            <a href="${pageContext.request.contextPath}/forum/create-topic">create a new topic</a>.
                                        </p>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="text-muted">Enter a search term to find topics.</p>
                                    </c:otherwise>
                                </c:choose>

                                <form action="${pageContext.request.contextPath}/forum/search" method="get" class="mt-3">
                                    <div class="input-group justify-content-center">
                                        <input type="text" name="q" class="form-control"
                                               style="max-width: 300px;"
                                               placeholder="Search topics..." value="${searchTerm}">
                                        <button class="btn btn-primary" type="submit">
                                            <i class="fas fa-search"></i>
                                        </button>
                                    </div>
                                </form>
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