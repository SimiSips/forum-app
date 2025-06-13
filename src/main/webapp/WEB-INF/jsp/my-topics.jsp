<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="includes/header.jsp" %>
<title>My Topics - Forum Application</title>

<body class="bg-gray-50 min-h-screen">
    <%@ include file="includes/navigation.jsp" %>

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
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
                        <span class="text-sm font-medium text-gray-700">My Topics</span>
                    </div>
                </li>
            </ol>
        </nav>

        <!-- Page Header -->
        <div class="gradient-bg rounded-2xl p-8 mb-8 text-white relative overflow-hidden">
            <div class="floating-shapes"></div>
            <div class="relative z-10">
                <div class="flex flex-col lg:flex-row items-center justify-between">
                    <div class="text-center lg:text-left mb-6 lg:mb-0">
                        <h1 class="text-4xl lg:text-5xl font-bold mb-4">
                            <i class="fas fa-user-edit mr-3"></i>My Topics
                        </h1>
                        <p class="text-xl opacity-90">
                            Manage and track your discussion topics
                        </p>
                    </div>
                    <div class="flex-shrink-0">
                        <a href="${pageContext.request.contextPath}/forum/create-topic"
                           class="bg-white text-primary-600 px-8 py-4 rounded-full font-semibold text-lg hover:bg-gray-100 transition-all duration-300 transform hover:scale-105 shadow-lg inline-flex items-center">
                            <i class="fas fa-plus mr-2"></i>Create New Topic
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Topics List -->
        <div class="bg-white rounded-2xl shadow-lg border border-gray-100 overflow-hidden">
            <c:choose>
                <c:when test="${not empty topics}">
                    <div class="p-6 border-b border-gray-100">
                        <div class="flex items-center justify-between">
                            <h2 class="text-xl font-semibold text-gray-900">Your Topics (${topics.size()})</h2>
                            <div class="flex items-center space-x-2 text-sm text-gray-500">
                                <i class="fas fa-sort mr-1"></i>
                                <span>Sorted by newest first</span>
                            </div>
                        </div>
                    </div>

                    <div class="divide-y divide-gray-100">
                        <c:forEach var="topic" items="${topics}" varStatus="status">
                            <div class="p-6 hover:bg-gray-50 transition-colors duration-200">
                                <div class="flex items-start justify-between">
                                    <div class="flex-1">
                                        <h3 class="text-lg font-semibold text-gray-900 mb-2">
                                            <a href="${pageContext.request.contextPath}/forum/topic/${topic.topicId}"
                                               class="hover:text-primary-600 transition-colors duration-200">
                                                ${topic.title}
                                            </a>
                                        </h3>
                                        <p class="text-gray-600 mb-4 leading-relaxed">
                                            ${topic.description.length() > 150 ? topic.description.substring(0, 150).concat('...') : topic.description}
                                        </p>

                                        <div class="flex items-center space-x-4 text-sm text-gray-500">
                                            <span class="flex items-center">
                                                <i class="fas fa-clock mr-1"></i>
                                                <fmt:formatDate value="${topic.dateCreated}" pattern="MMM dd, yyyy 'at' HH:mm"/>
                                            </span>
                                            <span class="flex items-center">
                                                <i class="fas fa-comments mr-1"></i>
                                                ${topic.commentCount > 0 ? topic.commentCount : 'No'}
                                                ${topic.commentCount == 1 ? 'comment' : 'comments'}
                                            </span>
                                            
                                        </div>
                                    </div>

                                    <div class="flex items-center space-x-2 ml-4">
                                        <a href="${pageContext.request.contextPath}/forum/topic/${topic.topicId}"
                                           class="bg-primary-100 text-primary-700 px-4 py-2 rounded-lg text-sm font-medium hover:bg-primary-200 transition-colors duration-200">
                                            <i class="fas fa-eye mr-1"></i>View
                                        </a>
                                        <a href="${pageContext.request.contextPath}/forum/edit-topic/${topic.topicId}"
                                           class="bg-gray-100 text-gray-700 px-4 py-2 rounded-lg text-sm font-medium hover:bg-gray-200 transition-colors duration-200">
                                            <i class="fas fa-edit mr-1"></i>Edit
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="p-12 text-center">
                        <div class="max-w-sm mx-auto">
                            <div class="w-20 h-20 bg-gradient-to-r from-gray-400 to-gray-500 rounded-full flex items-center justify-center mx-auto mb-6">
                                <i class="fas fa-comment-slash text-white text-3xl"></i>
                            </div>
                            <h3 class="text-2xl font-semibold text-gray-900 mb-4">No Topics Yet</h3>
                            <p class="text-gray-600 mb-8">You haven't created any discussion topics yet. Start engaging with the community!</p>
                            <a href="${pageContext.request.contextPath}/forum/create-topic"
                               class="bg-gradient-to-r from-primary-500 to-secondary-500 text-white px-8 py-3 rounded-full font-semibold hover:from-primary-600 hover:to-secondary-600 transition-all duration-200 transform hover:scale-105 inline-flex items-center">
                                <i class="fas fa-plus mr-2"></i>Create Your First Topic
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <%@ include file="includes/footer.jsp" %>

    <style>
        .gradient-bg {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .floating-shapes {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: -1;
        }

        .floating-shapes::before,
        .floating-shapes::after {
            content: '';
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            animation: float 6s ease-in-out infinite;
        }

        .floating-shapes::before {
            width: 200px;
            height: 200px;
            top: 10%;
            left: 10%;
            animation-delay: 0s;
        }

        .floating-shapes::after {
            width: 150px;
            height: 150px;
            bottom: 10%;
            right: 10%;
            animation-delay: 3s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(10deg); }
        }
    </style>
</body>
</html>