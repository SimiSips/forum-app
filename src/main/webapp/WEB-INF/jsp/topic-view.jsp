<%@ include file="includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="includes/header.jsp" %>
<title>${topic.title} - Forum Application</title>

<body>
    <%@ include file="includes/navigation.jsp" %>

    <div class="container mt-4 mb-5">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="${pageContext.request.contextPath}/" class="text-decoration-none">Home</a>
                </li>
                <li class="breadcrumb-item">
                    <a href="${pageContext.request.contextPath}/forum" class="text-decoration-none">Forum</a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">${topic.title}</li>
            </ol>
        </nav>

        <!-- Topic Header -->
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h1 class="h3 mb-0">${topic.title}</h1>
                        <div class="mt-2">
                            <span class="badge bg-light text-dark me-2">
                                <i class="fas fa-comments me-1"></i>${fn:length(comments)} Comments
                            </span>
                            <span class="badge bg-light text-dark">
                                <i class="fas fa-eye me-1"></i>Topic #${topic.topicId}
                            </span>
                        </div>
                    </div>
                    <div class="col-md-4 text-end">
                        <c:if test="${sessionScope.userId == topic.userId}">
                            <button class="btn btn-outline-light btn-sm" data-bs-toggle="modal"
                                    data-bs-target="#editTopicModal">
                                <i class="fas fa-edit"></i> Edit
                            </button>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/forum" class="btn btn-light btn-sm">
                            <i class="fas fa-arrow-left"></i> Back to Forum
                        </a>
                    </div>
                </div>
            </div>

            <div class="card-body">
                <div class="row">
                    <div class="col-md-1">
                        <div class="avatar mx-auto">
                            ${fn:substring(topic.user.firstName, 0, 1)}${fn:substring(topic.user.lastName, 0, 1)}
                        </div>
                    </div>
                    <div class="col-md-11">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <h6 class="mb-1">${topic.user.fullName}</h6>
                                <small class="text-muted">
                                    <i class="fas fa-calendar me-1"></i>
                                    Posted on <fmt:formatDate value="${topic.dateCreated}" pattern="MMMM dd, yyyy 'at' HH:mm"/>
                                    <c:if test="${topic.lastActivity != topic.dateCreated}">
                                        <br>
                                        <i class="fas fa-clock me-1"></i>
                                        Last activity: <fmt:formatDate value="${topic.lastActivity}" pattern="MMMM dd, yyyy 'at' HH:mm"/>
                                    </c:if>
                                </small>
                            </div>
                        </div>
                        <div class="mt-3">
                            <p class="mb-0">${fn:escapeXml(topic.description)}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Comments Section -->
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0">
                    <i class="fas fa-comments me-2"></i>
                    Discussion (${fn:length(comments)} comments)
                </h5>
            </div>

            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty comments}">
                        <c:forEach var="comment" items="${comments}" varStatus="commentStatus">
                            <div class="comment-item border-bottom pb-3 mb-3" id="comment-${comment.commentId}">
                                <div class="row">
                                    <div class="col-md-1">
                                        <div class="avatar">
                                            ${fn:substring(comment.user.firstName, 0, 1)}${fn:substring(comment.user.lastName, 0, 1)}
                                        </div>
                                    </div>
                                    <div class="col-md-11">
                                        <div class="d-flex justify-content-between align-items-start mb-2">
                                            <div>
                                                <h6 class="mb-1">${comment.user.fullName}</h6>
                                                <small class="text-muted">
                                                    <i class="fas fa-clock me-1"></i>
                                                    <fmt:formatDate value="${comment.datePosted}" pattern="MMMM dd, yyyy 'at' HH:mm"/>
                                                </small>
                                            </div>
                                            <div class="dropdown">
                                                <button class="btn btn-sm btn-outline-secondary dropdown-toggle"
                                                        type="button" data-bs-toggle="dropdown">
                                                    <i class="fas fa-ellipsis-h"></i>
                                                </button>
                                                <ul class="dropdown-menu">
                                                    <li>
                                                        <button class="dropdown-item reply-btn"
                                                                data-comment-id="${comment.commentId}">
                                                            <i class="fas fa-reply me-2"></i>Reply
                                                        </button>
                                                    </li>
                                                    <c:if test="${sessionScope.userId == comment.userId}">
                                                        <li>
                                                            <button class="dropdown-item text-warning">
                                                                <i class="fas fa-edit me-2"></i>Edit
                                                            </button>
                                                        </li>
                                                        <li>
                                                            <button class="dropdown-item text-danger">
                                                                <i class="fas fa-trash me-2"></i>Delete
                                                            </button>
                                                        </li>
                                                    </c:if>
                                                </ul>
                                            </div>
                                        </div>

                                        <div class="comment-text">
                                            <p class="mb-2">${fn:escapeXml(comment.commentText)}</p>
                                        </div>

                                        <!-- Replies -->
                                        <c:if test="${not empty comment.replies}">
                                            <div class="replies mt-3 ms-4 border-start border-3 border-primary ps-3">
                                                <h6 class="text-muted mb-3">
                                                    <i class="fas fa-reply me-1"></i>
                                                    ${fn:length(comment.replies)} ${fn:length(comment.replies) == 1 ? 'Reply' : 'Replies'}
                                                </h6>

                                                <c:forEach var="reply" items="${comment.replies}">
                                                    <div class="reply-item mb-3 p-2 bg-light rounded" id="reply-${reply.replyId}">
                                                        <div class="d-flex align-items-start">
                                                            <div class="avatar avatar-sm me-2" style="width: 30px; height: 30px; font-size: 0.7rem;">
                                                                ${fn:substring(reply.user.firstName, 0, 1)}${fn:substring(reply.user.lastName, 0, 1)}
                                                            </div>
                                                            <div class="flex-grow-1">
                                                                <div class="d-flex justify-content-between align-items-start">
                                                                    <div>
                                                                        <strong class="small">${reply.user.fullName}</strong>
                                                                        <small class="text-muted ms-2">
                                                                            <fmt:formatDate value="${reply.datePosted}" pattern="MMM dd, HH:mm"/>
                                                                        </small>
                                                                    </div>
                                                                    <c:if test="${sessionScope.userId == reply.userId}">
                                                                        <div class="dropdown">
                                                                            <button class="btn btn-sm btn-link text-muted"
                                                                                    data-bs-toggle="dropdown">
                                                                                <i class="fas fa-ellipsis-h"></i>
                                                                            </button>
                                                                            <ul class="dropdown-menu dropdown-menu-end">
                                                                                <li>
                                                                                    <button class="dropdown-item text-warning small">
                                                                                        <i class="fas fa-edit me-1"></i>Edit
                                                                                    </button>
                                                                                </li>
                                                                                <li>
                                                                                    <button class="dropdown-item text-danger small">
                                                                                        <i class="fas fa-trash me-1"></i>Delete
                                                                                    </button>
                                                                                </li>
                                                                            </ul>
                                                                        </div>
                                                                    </c:if>
                                                                </div>
                                                                <p class="small mb-0 mt-1">${fn:escapeXml(reply.replyText)}</p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </c:if>

                                        <!-- Reply Form (hidden by default) -->
                                        <div class="reply-form mt-3" id="reply-form-${comment.commentId}" style="display: none;">
                                            <form action="${pageContext.request.contextPath}/forum/add-reply" method="post"
                                                  class="bg-light p-3 rounded">
                                                <input type="hidden" name="commentId" value="${comment.commentId}">
                                                <input type="hidden" name="topicId" value="${topic.topicId}">

                                                <div class="mb-3">
                                                    <label class="form-label small">
                                                        <i class="fas fa-reply me-1"></i>Reply to ${comment.user.fullName}:
                                                    </label>
                                                    <textarea class="form-control" name="replyText" rows="3"
                                                              required maxlength="1000"
                                                              placeholder="Write your reply..."></textarea>
                                                </div>

                                                <div class="d-flex justify-content-end gap-2">
                                                    <button type="button" class="btn btn-sm btn-outline-secondary cancel-reply">
                                                        Cancel
                                                    </button>
                                                    <button type="submit" class="btn btn-sm btn-primary">
                                                        <i class="fas fa-paper-plane me-1"></i>Post Reply
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <i class="fas fa-comments fa-3x text-muted mb-3"></i>
                            <h6 class="text-muted">No comments yet</h6>
                            <p class="text-muted">Be the first to share your thoughts!</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Add Comment Section -->
        <c:if test="${not empty sessionScope.userId}">
            <div class="card mt-4">
                <div class="card-header">
                    <h6 class="mb-0">
                        <i class="fas fa-plus me-2"></i>Add Your Comment
                    </h6>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/forum/add-comment" method="post"
                          id="commentForm">
                        <input type="hidden" name="topicId" value="${topic.topicId}">

                        <div class="row">
                            <div class="col-md-1">
                                <div class="avatar">
                                    ${fn:substring(sessionScope.userName, 0, 1)}
                                </div>
                            </div>
                            <div class="col-md-11">
                                <div class="mb-3">
                                    <textarea class="form-control" name="commentText" rows="4"
                                              required maxlength="2000"
                                              placeholder="Share your thoughts on this topic..."></textarea>
                                    <div class="form-text">
                                        <span id="commentCount">0</span>/2000 characters
                                    </div>
                                </div>

                                <div class="d-flex justify-content-between align-items-center">
                                    <small class="text-muted">
                                        <i class="fas fa-info-circle me-1"></i>
                                        Be respectful and stay on topic
                                    </small>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-paper-plane me-2"></i>Post Comment
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </c:if>

        <c:if test="${empty sessionScope.userId}">
            <div class="card mt-4">
                <div class="card-body text-center">
                    <i class="fas fa-sign-in-alt fa-2x text-muted mb-3"></i>
                    <h6>Join the Discussion</h6>
                    <p class="text-muted">Sign in to post comments and replies</p>
                    <a href="${pageContext.request.contextPath}/user/login?redirectTo=${pageContext.request.requestURI}"
                       class="btn btn-primary me-2">
                        <i class="fas fa-sign-in-alt me-1"></i>Login
                    </a>
                    <a href="${pageContext.request.contextPath}/user/register" class="btn btn-outline-primary">
                        <i class="fas fa-user-plus me-1"></i>Register
                    </a>
                </div>
            </div>
        </c:if>
    </div>

    <%@ include file="includes/footer.jsp" %>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const commentTextarea = document.querySelector('#commentForm textarea[name="commentText"]');
            const commentCount = document.getElementById('commentCount');
            const replyButtons = document.querySelectorAll('.reply-btn');
            const cancelReplyButtons = document.querySelectorAll('.cancel-reply');

            // Comment character counter
            if (commentTextarea) {
                commentTextarea.addEventListener('input', function() {
                    const count = this.value.length;
                    commentCount.textContent = count;
                    commentCount.className = count > 1800 ? 'text-warning' : count > 1950 ? 'text-danger' : '';
                });
            }

            // Reply functionality
            replyButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const commentId = this.dataset.commentId;
                    const replyForm = document.getElementById(`reply-form-${commentId}`);

                    // Hide all other reply forms
                    document.querySelectorAll('.reply-form').forEach(form => {
                        if (form.id !== `reply-form-${commentId}`) {
                            form.style.display = 'none';
                        }
                    });

                    // Toggle current reply form
                    replyForm.style.display = replyForm.style.display === 'none' ? 'block' : 'none';

                    if (replyForm.style.display === 'block') {
                        replyForm.querySelector('textarea').focus();
                    }
                });
            });

            // Cancel reply
            cancelReplyButtons.forEach(button => {
                button.addEventListener('click', function() {
                    this.closest('.reply-form').style.display = 'none';
                });
            });

            // Auto-expand textareas
            document.querySelectorAll('textarea').forEach(textarea => {
                textarea.addEventListener('input', function() {
                    this.style.height = 'auto';
                    this.style.height = (this.scrollHeight) + 'px';
                });
            });
        });
    </script>
</body>
</html>