<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="includes/header.jsp" %>
<title>${topic.title} - Forum Application</title>

<body class="bg-gray-50 min-h-screen">
    <%@ include file="includes/navigation.jsp" %>

    <div class="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <!-- Breadcrumb -->
        <nav class="flex mb-8" aria-label="Breadcrumb">
            <ol class="inline-flex items-center space-x-1 md:space-x-3">
                <li class="inline-flex items-center">
                    <a href="${pageContext.request.contextPath}/"
                       class="inline-flex items-center text-sm font-medium text-gray-500 hover:text-primary-600 transition-colors">
                        <i class="fas fa-home mr-2"></i>Home
                    </a>
                </li>
                <li>
                    <div class="flex items-center">
                        <i class="fas fa-chevron-right text-gray-400 mx-2"></i>
                        <a href="${pageContext.request.contextPath}/forum"
                           class="text-sm font-medium text-gray-500 hover:text-primary-600 transition-colors">Forum</a>
                    </div>
                </li>
                <li>
                    <div class="flex items-center">
                        <i class="fas fa-chevron-right text-gray-400 mx-2"></i>
                        <span class="text-sm font-medium text-gray-700">${topic.title}</span>
                    </div>
                </li>
            </ol>
        </nav>

        <!-- Topic Header -->
        <div class="bg-white rounded-2xl shadow-lg border border-gray-100 p-8 mb-8">
            <div class="flex items-start justify-between">
                <div class="flex-1">
                    <h1 class="text-3xl font-bold text-gray-900 mb-4">${topic.title}</h1>

                    <div class="flex items-center space-x-6 text-sm text-gray-500 mb-6">
                        <span class="flex items-center">
                            <div class="w-8 h-8 bg-gradient-to-r from-primary-500 to-secondary-500 rounded-full flex items-center justify-center mr-2">
                                <span class="text-white text-xs font-bold">
                                    ${topic.user.firstName.substring(0,1).toUpperCase()}
                                </span>
                            </div>
                            By <span class="font-medium text-gray-700">${topic.user.firstName}</span>
                        </span>
                        <span class="flex items-center">
                            <i class="fas fa-clock mr-2"></i>
                            <fmt:formatDate value="${topic.dateCreated}" pattern="MMMM dd, yyyy 'at' HH:mm"/>
                        </span>

                    </div>

                    <div class="prose prose-gray max-w-none">
                        <p class="text-gray-700 leading-relaxed">${topic.description}</p>
                    </div>
                </div>

                <c:if test="${sessionScope.userId == topic.userId}">
                    <div class="flex items-center space-x-2 ml-6">
                        <a href="${pageContext.request.contextPath}/forum/edit-topic/${topic.topicId}"
                           class="bg-gray-100 text-gray-700 px-4 py-2 rounded-lg text-sm font-medium hover:bg-gray-200 transition-colors duration-200">
                            <i class="fas fa-edit mr-1"></i>Edit
                        </a>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- Comments Section -->
        <div class="bg-white rounded-2xl shadow-lg border border-gray-100 overflow-hidden">
            <div class="p-6 border-b border-gray-100">
                <div class="flex items-center justify-between">
                    <h2 class="text-xl font-semibold text-gray-900">
                        Discussion (${comments.size()} ${comments.size() == 1 ? 'comment' : 'comments'})
                    </h2>
                    <c:if test="${not empty sessionScope.userId}">
                        <button onclick="scrollToCommentForm()"
                                class="bg-primary-500 text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-primary-600 transition-colors duration-200">
                            <i class="fas fa-comment mr-2"></i>Add Comment
                        </button>
                    </c:if>
                </div>
            </div>

            <c:choose>
                <c:when test="${not empty comments}">
                    <div class="divide-y divide-gray-100">
                        <c:forEach var="comment" items="${comments}" varStatus="status">
                            <div class="p-6" id="comment-${comment.commentId}">
                                <div class="flex items-start space-x-4">
                                    <div class="flex-shrink-0">
                                        <div class="w-10 h-10 bg-gradient-to-r from-blue-500 to-purple-500 rounded-full flex items-center justify-center">
                                            <span class="text-white text-sm font-bold">
                                                ${comment.user.firstName.substring(0,1).toUpperCase()}
                                            </span>
                                        </div>
                                    </div>

                                    <div class="flex-1">
                                        <div class="flex items-center space-x-2 mb-2">
                                            <span class="font-medium text-gray-900">${comment.user.firstName}</span>
                                            <span class="text-gray-500 text-sm">
                                                <fmt:formatDate value="${comment.datePosted}" pattern="MMM dd, yyyy 'at' HH:mm"/>
                                            </span>
                                        </div>

                                        <div class="prose prose-sm prose-gray max-w-none">
                                            <p class="text-gray-700">${comment.commentText}</p>
                                        </div>

                                        <div class="mt-4 flex items-center space-x-4">
                                            <c:if test="${not empty sessionScope.userId}">
                                                <button onclick="toggleReplyForm(${comment.commentId})"
                                                        class="text-primary-600 hover:text-primary-700 text-sm font-medium transition-colors duration-200">
                                                    <i class="fas fa-reply mr-1"></i>Reply
                                                </button>
                                            </c:if>
                                            <c:if test="${sessionScope.userId == comment.userId}">
                                                <button onclick="editComment(${comment.commentId})"
                                                        class="text-gray-600 hover:text-gray-700 text-sm font-medium transition-colors duration-200">
                                                    <i class="fas fa-edit mr-1"></i>Edit
                                                </button>
                                            </c:if>
                                        </div>

                                        <!-- Reply Form -->
                                        <div id="reply-form-${comment.commentId}" class="hidden mt-4">
                                            <form action="${pageContext.request.contextPath}/forum/add-reply" method="post" class="space-y-4">
                                                <input type="hidden" name="commentId" value="${comment.commentId}">
                                                <input type="hidden" name="topicId" value="${topic.topicId}">

                                                <textarea name="replyText"
                                                          placeholder="Write your reply..."
                                                          rows="3"
                                                          required
                                                          class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors duration-200 resize-none"></textarea>

                                                <div class="flex items-center space-x-3">
                                                    <button type="submit"
                                                            class="bg-primary-500 text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-primary-600 transition-colors duration-200">
                                                        <i class="fas fa-reply mr-1"></i>Post Reply
                                                    </button>
                                                    <button type="button"
                                                            onclick="toggleReplyForm(${comment.commentId})"
                                                            class="bg-gray-100 text-gray-700 px-4 py-2 rounded-lg text-sm font-medium hover:bg-gray-200 transition-colors duration-200">
                                                        Cancel
                                                    </button>
                                                </div>
                                            </form>
                                        </div>

                                        <!-- Replies -->
                                        <c:if test="${not empty comment.replies}">
                                            <div class="mt-6 space-y-4">
                                                <c:forEach var="reply" items="${comment.replies}">
                                                    <div class="bg-gray-50 rounded-lg p-4 border-l-4 border-primary-300">
                                                        <div class="flex items-start space-x-3">
                                                            <div class="flex-shrink-0">
                                                                <div class="w-8 h-8 bg-gradient-to-r from-green-500 to-teal-500 rounded-full flex items-center justify-center">
                                                                    <span class="text-white text-xs font-bold">
                                                                        ${reply.user.firstName.substring(0,1).toUpperCase()}
                                                                    </span>
                                                                </div>
                                                            </div>

                                                            <div class="flex-1">
                                                                <div class="flex items-center space-x-2 mb-1">
                                                                    <span class="font-medium text-gray-900 text-sm">${reply.user.firstName}</span>
                                                                    <span class="text-gray-500 text-xs">
                                                                        <fmt:formatDate value="${reply.datePosted}" pattern="MMM dd 'at' HH:mm"/>
                                                                    </span>
                                                                </div>
                                                                <p class="text-gray-700 text-sm">${reply.replyText}</p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="p-12 text-center">
                        <div class="w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
                            <i class="fas fa-comments text-gray-400 text-2xl"></i>
                        </div>
                        <h3 class="text-lg font-medium text-gray-900 mb-2">No comments yet</h3>
                        <p class="text-gray-600 mb-6">Be the first to start the discussion!</p>
                        <c:if test="${not empty sessionScope.userId}">
                            <button onclick="scrollToCommentForm()"
                                    class="bg-primary-500 text-white px-6 py-3 rounded-lg font-medium hover:bg-primary-600 transition-colors duration-200">
                                <i class="fas fa-comment mr-2"></i>Add First Comment
                            </button>
                        </c:if>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Add Comment Form -->
        <c:choose>
            <c:when test="${not empty sessionScope.userId}">
                <div class="bg-white rounded-2xl shadow-lg border border-gray-100 p-8 mt-8" id="comment-form">
                    <h3 class="text-xl font-semibold text-gray-900 mb-6">Add Your Comment</h3>

                    <form action="${pageContext.request.contextPath}/forum/add-comment" method="post" class="space-y-6">
                        <input type="hidden" name="topicId" value="${topic.topicId}">

                        <div>
                            <label for="commentText" class="block text-sm font-medium text-gray-700 mb-2">
                                Your Comment
                            </label>
                            <textarea id="commentText"
                                      name="commentText"
                                      rows="4"
                                      required
                                      placeholder="Share your thoughts on this topic..."
                                      class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors duration-200 resize-none"></textarea>
                            <p class="text-xs text-gray-500 mt-1">Be respectful and constructive in your comments</p>
                        </div>

                        <div class="flex items-center justify-between">
                            <div class="flex items-center space-x-2 text-sm text-gray-600">
                                <i class="fas fa-user mr-1"></i>
                                <span>Commenting as <strong>${sessionScope.firstName}</strong></span>
                            </div>

                            <button type="submit"
                                    class="bg-gradient-to-r from-primary-500 to-secondary-500 text-white px-8 py-3 rounded-lg font-semibold hover:from-primary-600 hover:to-secondary-600 transition-all duration-200 transform hover:scale-105">
                                <i class="fas fa-comment mr-2"></i>Post Comment
                            </button>
                        </div>
                    </form>
                </div>
            </c:when>
            <c:otherwise>
                <div class="bg-white rounded-2xl shadow-lg border border-gray-100 p-8 mt-8 text-center">
                    <div class="max-w-sm mx-auto">
                        <div class="w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
                            <i class="fas fa-sign-in-alt text-gray-400 text-2xl"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-gray-900 mb-2">Join the Discussion</h3>
                        <p class="text-gray-600 mb-6">You need to be logged in to post comments and participate in discussions.</p>

                        <div class="flex flex-col sm:flex-row gap-3 justify-center">
                            <a href="${pageContext.request.contextPath}/user/login"
                               class="bg-gradient-to-r from-primary-500 to-secondary-500 text-white px-6 py-3 rounded-lg font-medium hover:from-primary-600 hover:to-secondary-600 transition-all duration-200">
                                <i class="fas fa-sign-in-alt mr-2"></i>Sign In
                            </a>
                            <a href="${pageContext.request.contextPath}/user/register"
                               class="bg-gray-100 text-gray-700 px-6 py-3 rounded-lg font-medium hover:bg-gray-200 transition-colors duration-200">
                                <i class="fas fa-user-plus mr-2"></i>Register
                            </a>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <%@ include file="includes/footer.jsp" %>

    <script>
        function scrollToCommentForm() {
            document.getElementById('comment-form').scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
            document.getElementById('commentContent').focus();
        }

        function toggleReplyForm(commentId) {
            const form = document.getElementById('reply-form-' + commentId);
            if (form.classList.contains('hidden')) {
                form.classList.remove('hidden');
                form.querySelector('textarea').focus();
            } else {
                form.classList.add('hidden');
            }
        }

        function editComment(commentId) {
            // Placeholder for edit functionality
            alert('Edit functionality would be implemented here');
        }

        // Auto-resize textareas
        document.addEventListener('DOMContentLoaded', function() {
            const textareas = document.querySelectorAll('textarea');
            textareas.forEach(textarea => {
                textarea.addEventListener('input', function() {
                    this.style.height = 'auto';
                    this.style.height = this.scrollHeight + 'px';
                });
            });
        });
    </script>
</body>
</html>