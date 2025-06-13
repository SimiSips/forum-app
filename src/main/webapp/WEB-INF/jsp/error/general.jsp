<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="includes/header.jsp" %>
<title>General Information - Forum Application</title>

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
                        <span class="text-sm font-medium text-gray-700">General Information</span>
                    </div>
                </li>
            </ol>
        </nav>

        <!-- Page Header -->
        <div class="gradient-bg rounded-2xl p-8 mb-8 text-white relative overflow-hidden">
            <div class="floating-shapes"></div>
            <div class="relative z-10">
                <div class="text-center">
                    <h1 class="text-4xl lg:text-5xl font-bold mb-4">
                        <i class="fas fa-info-circle mr-3"></i>General Information
                    </h1>
                    <p class="text-xl opacity-90">
                        Learn more about our forum application and community guidelines
                    </p>
                </div>
            </div>
        </div>

        <!-- Content Section -->
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <!-- Main Content -->
            <div class="lg:col-span-2 space-y-8">
                <!-- About Section -->
                <div class="bg-white rounded-2xl shadow-lg border border-gray-100 p-8">
                    <div class="flex items-center mb-6">
                        <div class="w-12 h-12 bg-gradient-to-r from-blue-500 to-indigo-500 rounded-xl flex items-center justify-center mr-4">
                            <i class="fas fa-info text-white text-xl"></i>
                        </div>
                        <h2 class="text-2xl font-bold text-gray-900">About Our Forum</h2>
                    </div>

                    <div class="prose prose-gray max-w-none">
                        <p class="text-gray-600 leading-relaxed mb-4">
                            Welcome to our advanced forum application, a comprehensive platform designed for meaningful
                            discussions and knowledge sharing. Built with modern Java technologies, this forum provides
                            a robust and secure environment for community interaction.
                        </p>

                        <p class="text-gray-600 leading-relaxed mb-4">
                            Our platform supports various discussion topics, user-generated content, and real-time
                            interactions. Whether you're here to learn, teach, or simply engage with like-minded
                            individuals, our forum has the tools and features to enhance your experience.
                        </p>

                        <p class="text-gray-600 leading-relaxed">
                            This application demonstrates advanced Java programming concepts including servlets,
                            JSP pages, database integration, RESTful web services, and modern responsive design
                            principles using Tailwind CSS.
                        </p>
                    </div>
                </div>

                <!-- Features Section -->
                <div class="bg-white rounded-2xl shadow-lg border border-gray-100 p-8">
                    <div class="flex items-center mb-6">
                        <div class="w-12 h-12 bg-gradient-to-r from-green-500 to-teal-500 rounded-xl flex items-center justify-center mr-4">
                            <i class="fas fa-star text-white text-xl"></i>
                        </div>
                        <h2 class="text-2xl font-bold text-gray-900">Key Features</h2>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="flex items-start">
                            <div class="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center mr-3 mt-1">
                                <i class="fas fa-users text-blue-600 text-sm"></i>
                            </div>
                            <div>
                                <h3 class="font-semibold text-gray-900 mb-1">User Management</h3>
                                <p class="text-gray-600 text-sm">Secure registration, login, and profile management</p>
                            </div>
                        </div>

                        <div class="flex items-start">
                            <div class="w-8 h-8 bg-green-100 rounded-lg flex items-center justify-center mr-3 mt-1">
                                <i class="fas fa-comments text-green-600 text-sm"></i>
                            </div>
                            <div>
                                <h3 class="font-semibold text-gray-900 mb-1">Discussion Topics</h3>
                                <p class="text-gray-600 text-sm">Create and participate in threaded discussions</p>
                            </div>
                        </div>

                        <div class="flex items-start">
                            <div class="w-8 h-8 bg-purple-100 rounded-lg flex items-center justify-center mr-3 mt-1">
                                <i class="fas fa-reply text-purple-600 text-sm"></i>
                            </div>
                            <div>
                                <h3 class="font-semibold text-gray-900 mb-1">Comments & Replies</h3>
                                <p class="text-gray-600 text-sm">Multi-level comment system with nested replies</p>
                            </div>
                        </div>

                        <div class="flex items-start">
                            <div class="w-8 h-8 bg-orange-100 rounded-lg flex items-center justify-center mr-3 mt-1">
                                <i class="fas fa-search text-orange-600 text-sm"></i>
                            </div>
                            <div>
                                <h3 class="font-semibold text-gray-900 mb-1">Search Functionality</h3>
                                <p class="text-gray-600 text-sm">Find topics and discussions quickly</p>
                            </div>
                        </div>

                        <div class="flex items-start">
                            <div class="w-8 h-8 bg-red-100 rounded-lg flex items-center justify-center mr-3 mt-1">
                                <i class="fas fa-shield-alt text-red-600 text-sm"></i>
                            </div>
                            <div>
                                <h3 class="font-semibold text-gray-900 mb-1">Security</h3>
                                <p class="text-gray-600 text-sm">Password hashing and input validation</p>
                            </div>
                        </div>

                        <div class="flex items-start">
                            <div class="w-8 h-8 bg-indigo-100 rounded-lg flex items-center justify-center mr-3 mt-1">
                                <i class="fas fa-mobile-alt text-indigo-600 text-sm"></i>
                            </div>
                            <div>
                                <h3 class="font-semibold text-gray-900 mb-1">Responsive Design</h3>
                                <p class="text-gray-600 text-sm">Works seamlessly on all devices</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Community Guidelines -->
                <div class="bg-white rounded-2xl shadow-lg border border-gray-100 p-8">
                    <div class="flex items-center mb-6">
                        <div class="w-12 h-12 bg-gradient-to-r from-purple-500 to-pink-500 rounded-xl flex items-center justify-center mr-4">
                            <i class="fas fa-gavel text-white text-xl"></i>
                        </div>
                        <h2 class="text-2xl font-bold text-gray-900">Community Guidelines</h2>
                    </div>

                    <div class="space-y-4">
                        <div class="border-l-4 border-blue-500 pl-4">
                            <h3 class="font-semibold text-gray-900 mb-1">Be Respectful</h3>
                            <p class="text-gray-600 text-sm">Treat all community members with respect and courtesy. Personal attacks, harassment, or discriminatory language will not be tolerated.</p>
                        </div>

                        <div class="border-l-4 border-green-500 pl-4">
                            <h3 class="font-semibold text-gray-900 mb-1">Stay On Topic</h3>
                            <p class="text-gray-600 text-sm">Keep discussions relevant to the topic at hand. Off-topic posts may be moved or removed by moderators.</p>
                        </div>

                        <div class="border-l-4 border-orange-500 pl-4">
                            <h3 class="font-semibold text-gray-900 mb-1">No Spam or Self-Promotion</h3>
                            <p class="text-gray-600 text-sm">Avoid excessive self-promotion or spam. Share content that adds value to the discussion.</p>
                        </div>

                        <div class="border-l-4 border-red-500 pl-4">
                            <h3 class="font-semibold text-gray-900 mb-1">Use Appropriate Language</h3>
                            <p class="text-gray-600 text-sm">Keep discussions professional and family-friendly. Profanity and inappropriate content are not allowed.</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sidebar -->
            <div class="space-y-6">
                <!-- Quick Stats -->
                <div class="bg-white rounded-2xl shadow-lg border border-gray-100 p-6">
                    <h3 class="text-lg font-semibold text-gray-900 mb-4">Forum Statistics</h3>

                    <div class="space-y-4">
                        <div class="flex items-center justify-between">
                            <div class="flex items-center">
                                <div class="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center mr-3">
                                    <i class="fas fa-comments text-blue-600 text-sm"></i>
                                </div>
                                <span class="text-gray-700">Topics</span>
                            </div>
                            <span class="font-semibold text-gray-900">${totalTopics > 0 ? totalTopics : '0'}</span>
                        </div>

                        <div class="flex items-center justify-between">
                            <div class="flex items-center">
                                <div class="w-8 h-8 bg-green-100 rounded-lg flex items-center justify-center mr-3">
                                    <i class="fas fa-users text-green-600 text-sm"></i>
                                </div>
                                <span class="text-gray-700">Members</span>
                            </div>
                            <span class="font-semibold text-gray-900">${totalUsers > 0 ? totalUsers : '0'}</span>
                        </div>

                        <div class="flex items-center justify-between">
                            <div class="flex items-center">
                                <div class="w-8 h-8 bg-purple-100 rounded-lg flex items-center justify-center mr-3">
                                    <i class="fas fa-comment text-purple-600 text-sm"></i>
                                </div>
                                <span class="text-gray-700">Comments</span>
                            </div>
                            <span class="font-semibold text-gray-900">${totalComments > 0 ? totalComments : '0'}</span>
                        </div>
                    </div>
                </div>

                <!-- Technology Stack -->
                <div class="bg-white rounded-2xl shadow-lg border border-gray-100 p-6">
                    <h3 class="text-lg font-semibold text-gray-900 mb-4">Technology Stack</h3>

                    <div class="space-y-3">
                        <div class="flex items-center">
                            <div class="w-8 h-8 bg-orange-100 rounded-lg flex items-center justify-center mr-3">
                                <i class="fab fa-java text-orange-600 text-sm"></i>
                            </div>
                            <span class="text-gray-700">Java & Servlets</span>
                        </div>

                        <div class="flex items-center">
                            <div class="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center mr-3">
                                <i class="fas fa-database text-blue-600 text-sm"></i>
                            </div>
                            <span class="text-gray-700">MySQL Database</span>
                        </div>

                        <div class="flex items-center">
                            <div class="w-8 h-8 bg-green-100 rounded-lg flex items-center justify-center mr-3">
                                <i class="fas fa-code text-green-600 text-sm"></i>
                            </div>
                            <span class="text-gray-700">JSP & JSTL</span>
                        </div>

                        <div class="flex items-center">
                            <div class="w-8 h-8 bg-purple-100 rounded-lg flex items-center justify-center mr-3">
                                <i class="fas fa-palette text-purple-600 text-sm"></i>
                            </div>
                            <span class="text-gray-700">Tailwind CSS</span>
                        </div>

                        <div class="flex items-center">
                            <div class="w-8 h-8 bg-red-100 rounded-lg flex items-center justify-center mr-3">
                                <i class="fas fa-globe text-red-600 text-sm"></i>
                            </div>
                            <span class="text-gray-700">REST API</span>
                        </div>
                    </div>
                </div>

                <!-- Call to Action -->
                <div class="bg-gradient-to-br from-primary-500 to-secondary-500 rounded-2xl p-6 text-white">
                    <div class="text-center">
                        <div class="w-16 h-16 bg-white bg-opacity-20 rounded-full flex items-center justify-center mx-auto mb-4">
                            <i class="fas fa-rocket text-white text-2xl"></i>
                        </div>
                        <h3 class="text-xl font-bold mb-2">Ready to Get Started?</h3>
                        <p class="text-sm opacity-90 mb-4">
                            Join our community and start engaging in meaningful discussions today!
                        </p>
                        <c:choose>
                            <c:when test="${not empty sessionScope.userId}">
                                <a href="${pageContext.request.contextPath}/forum"
                                   class="bg-white text-primary-600 px-6 py-3 rounded-full font-semibold text-sm hover:bg-gray-100 transition-all duration-200 transform hover:scale-105 inline-flex items-center">
                                    <i class="fas fa-comments mr-2"></i>Browse Forum
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/user/register"
                                   class="bg-white text-primary-600 px-6 py-3 rounded-full font-semibold text-sm hover:bg-gray-100 transition-all duration-200 transform hover:scale-105 inline-flex items-center">
                                    <i class="fas fa-user-plus mr-2"></i>Sign Up Now
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
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