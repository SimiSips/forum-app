<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="includes/header.jsp" %>
<title>Search Results - Forum Application</title>

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
                        <span class="text-sm font-medium text-gray-700">Search Results</span>
                    </div>
                </li>
            </ol>
        </nav>

        <!-- Search Header -->
        <div class="bg-white rounded-2xl shadow-lg border border-gray-100 p-8 mb-8">
            <div class="flex flex-col lg:flex-row items-center justify-between">
                <div class="text-center lg:text-left mb-6 lg:mb-0">
                    <h1 class="text-3xl font-bold text-gray-900 mb-2">
                        <i class="fas fa-search mr-3 text-primary-600"></i>Search Results
                    </h1>
                    <p class="text-gray-600">
                        <c:choose>
                            <c:when test="${not empty searchResults}">
                                Found ${searchResults.size()} result(s) for "<span class="font-medium text-gray-900">${param.query}</span>"
                            </c:when>
                            <c:otherwise>
                                No results found for "<span class="font-medium text-gray-900">${param.query}</span>"
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>

                <!-- Search Form -->
                <div class="flex-shrink-0 w-full lg:w-auto">
                    <form action="${pageContext.request.contextPath}/forum/search" method="get" class="flex">
                        <div class="relative flex-1 lg:w-80">
                            <input type="text"
                                   name="query"
                                   value="${param.query}"
                                   placeholder="Search topics and discussions..."
                                   class="w-full px-4 py-3 pl-12 border border-gray-300 rounded-l-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors duration-200">
                            <div class="absolute inset-y-0 left-0 flex items-center pl-4">
                                <i class="fas fa-search text-gray-400"></i>
                            </div>
                        </div>
                        <button type="submit"
                                class="bg-gradient-to-r from-primary-500 to-secondary-500 text-white px-6 py-3 rounded-r-xl font-medium hover:from-primary-600 hover:to-secondary-600 transition-all duration-200">
                            Search
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Search Results -->
        <div class="space-y-6">
            <c:choose>
                <c:when test="${not empty searchResults}">
                    <!-- Results List -->
                    <c:forEach var="topic" items="${searchResults}" varStatus="status">
                        <div class="bg-white rounded-2xl shadow-lg border border-gray-100 p-6 hover:shadow-xl transition-shadow duration-300">
                            <div class="flex items-start justify-between">
                                <div class="flex-1">
                                    <h3 class="text-xl font-semibold text-gray-900 mb-2">
                                        <a href="${pageContext.request.contextPath}/forum/topic/${topic.topicId}"
                                           class="hover:text-primary-600 transition-colors duration-200">
                                            ${topic.title}
                                        </a>
                                    </h3>

                                    <p class="text-gray-600 mb-4 leading-relaxed">
                                        ${topic.description.length() > 200 ? topic.description.substring(0, 200).concat('...') : topic.description}
                                    </p>

                                    <div class="flex items-center space-x-6 text-sm text-gray-500">
                                        <span class="flex items-center">
                                            <div class="w-6 h-6 bg-gray-100 rounded-full flex items-center justify-center mr-2">
                                                <i class="fas fa-user text-gray-600 text-xs"></i>
                                            </div>
                                            By ${topic.user.firstName}
                                        </span>
                                        <span class="flex items-center">
                                            <i class="fas fa-clock mr-2"></i>
                                            <fmt:formatDate value="${topic.dateCreated}" pattern="MMM dd, yyyy"/>
                                        </span>
                                        <span class="flex items-center">
                                            <i class="fas fa-comments mr-2"></i>
                                            ${topic.commentCount} ${topic.commentCount == 1 ? 'comment' : 'comments'}
                                        </span>

                                    </div>
                                </div>

                                <div class="flex items-center ml-6">
                                    <a href="${pageContext.request.contextPath}/forum/topic/${topic.topicId}"
                                       class="bg-primary-100 text-primary-700 px-6 py-2 rounded-lg font-medium hover:bg-primary-200 transition-colors duration-200">
                                        <i class="fas fa-arrow-right mr-2"></i>View Topic
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <!-- No Results -->
                    <div class="bg-white rounded-2xl shadow-lg border border-gray-100 p-12 text-center">
                        <div class="max-w-md mx-auto">
                            <div class="w-20 h-20 bg-gradient-to-r from-gray-400 to-gray-500 rounded-full flex items-center justify-center mx-auto mb-6">
                                <i class="fas fa-search text-white text-3xl"></i>
                            </div>
                            <h3 class="text-2xl font-semibold text-gray-900 mb-4">No Results Found</h3>
                            <p class="text-gray-600 mb-8">
                                We couldn't find any topics matching your search. Try using different keywords or browse our forum categories.
                            </p>

                            <div class="space-y-4">
                                <div class="bg-blue-50 rounded-xl p-4 text-left">
                                    <h4 class="font-medium text-blue-900 mb-2">Search Tips:</h4>
                                    <ul class="text-blue-700 text-sm space-y-1">
                                        <li>• Try broader or more general terms</li>
                                        <li>• Check your spelling</li>
                                        <li>• Use fewer keywords</li>
                                        <li>• Browse categories instead</li>
                                    </ul>
                                </div>

                                <div class="flex flex-col sm:flex-row gap-3">
                                    <a href="${pageContext.request.contextPath}/forum"
                                       class="bg-gradient-to-r from-primary-500 to-secondary-500 text-white px-6 py-3 rounded-lg font-medium hover:from-primary-600 hover:to-secondary-600 transition-all duration-200 inline-flex items-center justify-center">
                                        <i class="fas fa-comments mr-2"></i>Browse All Topics
                                    </a>
                                    <a href="${pageContext.request.contextPath}/forum/create-topic"
                                       class="bg-gray-100 text-gray-700 px-6 py-3 rounded-lg font-medium hover:bg-gray-200 transition-colors duration-200 inline-flex items-center justify-center">
                                        <i class="fas fa-plus mr-2"></i>Create New Topic
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Search Suggestions -->
        <c:if test="${empty searchResults and not empty param.query}">
            <div class="bg-white rounded-2xl shadow-lg border border-gray-100 p-6 mt-8">
                <h3 class="text-lg font-semibold text-gray-900 mb-4">Popular Topics You Might Like</h3>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                    <c:forEach var="popularTopic" items="${popularTopics}" varStatus="status" end="5">
                        <a href="${pageContext.request.contextPath}/forum/topic/${popularTopic.id}"
                           class="block p-4 bg-gray-50 rounded-lg hover:bg-gray-100 transition-colors duration-200">
                            <h4 class="font-medium text-gray-900 mb-1">${popularTopic.title}</h4>
                            <p class="text-sm text-gray-600">${popularTopic.commentCount} comments</p>
                        </a>
                    </c:forEach>
                </div>
            </div>
        </c:if>
    </div>

    <%@ include file="includes/footer.jsp" %>
</body>
</html>