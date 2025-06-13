<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="includes/header.jsp" %>
<title>Forum - Discussion Topics</title>

<body class="bg-gray-50 min-h-screen">
    <%@ include file="includes/navigation.jsp" %>

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <!-- Welcome Header -->
        <div class="gradient-bg rounded-2xl p-8 mb-8 text-white relative overflow-hidden">
            <div class="floating-shapes"></div>
            <div class="relative z-10">
                <div class="flex flex-col lg:flex-row items-center justify-between">
                    <div class="text-center lg:text-left mb-6 lg:mb-0">
                        <h1 class="text-4xl lg:text-5xl font-bold mb-4">
                            <i class="fas fa-comments mr-3"></i>Welcome to the Forum
                        </h1>
                        <p class="text-xl opacity-90 max-w-2xl">
                            Join the discussion, share your thoughts, and connect with the community!
                        </p>
                    </div>
                    <div class="flex-shrink-0">
                        <a href="${pageContext.request.contextPath}/forum/create-topic"
                           class="bg-white text-primary-600 px-8 py-4 rounded-full font-semibold text-lg hover:bg-gray-100 transition-all duration-300 transform hover:scale-105 shadow-lg inline-flex items-center">
                            <i class="fas fa-plus mr-2"></i>Create Topic
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Forum Statistics -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <div class="bg-white rounded-2xl p-6 shadow-lg border border-gray-100 card-hover">
                <div class="flex items-center">
                    <div class="w-12 h-12 bg-gradient-to-r from-blue-500 to-indigo-500 rounded-xl flex items-center justify-center">
                        <i class="fas fa-comments text-white text-xl"></i>
                    </div>
                    <div class="ml-4">
                        <div class="text-2xl font-bold text-gray-900">${totalTopics}</div>
                        <div class="text-sm text-gray-600">Total Topics</div>
                    </div>
                </div>
            </div>
            <div class="bg-white rounded-2xl p-6 shadow-lg border border-gray-100 card-hover">
                <div class="flex items-center">
                    <div class="w-12 h-12 bg-gradient-to-r from-green-500 to-teal-500 rounded-xl flex items-center justify-center">
                        <i class="fas fa-users text-white text-xl"></i>
                    </div>
                    <div class="ml-4">
                        <div class="text-2xl font-bold text-gray-900">${totalUsers}</div>
                        <div class="text-sm text-gray-600">Active Users</div>
                    </div>
                </div>
            </div>
            <div class="bg-white rounded-2xl p-6 shadow-lg border border-gray-100 card-hover">
                <div class="flex items-center">
                    <div class="w-12 h-12 bg-gradient-to-r from-purple-500 to-pink-500 rounded-xl flex items-center justify-center">
                        <i class="fas fa-chart-line text-white text-xl"></i>
                    </div>
                    <div class="ml-4">
                        <div class="text-2xl font-bold text-gray-900">${totalComments}</div>
                        <div class="text-sm text-gray-600">Total Comments</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Messages -->
        <c:if test="${not empty message}">
            <div class="mb-6 bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-lg animate-slide-down">
                <div class="flex items-center">
                    <i class="fas fa-check-circle mr-3 text-green-500"></i>
                    <span>${message}</span>
                </div>
            </div>
        </c:if>

        <!-- Controls Section -->
        <div class="bg-white rounded-2xl shadow-lg border border-gray-100 p-6 mb-8">
            <div class="flex flex-col lg:flex-row items-center justify-between space-y-4 lg:space-y-0">
                <!-- Create Topic Button -->
                <div>
                    <a href="${pageContext.request.contextPath}/forum/create-topic"
                       class="bg-gradient-to-r from-primary-500 to-secondary-500 text-white px-6 py-3 rounded-full font-semibold hover:from-primary-600 hover:to-secondary-600 transition-all duration-200 transform hover:scale-105 inline-flex items-center">
                        <i class="fas fa-plus mr-2"></i>Create New Topic
                    </a>
                </div>

                <!-- Sorting Options -->
                <div class="flex items-center space-x-4">
                    <span class="text-sm font-medium text-gray-700">Sort by:</span>
                    <div class="flex rounded-lg border border-gray-300 overflow-hidden">
                        <button class="sort-btn px-4 py-2 text-sm font-medium transition-colors duration-200 ${empty param.sort or param.sort == 'latest' ? 'bg-primary-500 text-white' : 'bg-white text-gray-700 hover:bg-gray-50'}"
                                data-sort="latest">
                            <i class="fas fa-clock mr-1"></i>Latest
                        </button>
                        <button class="sort-btn px-4 py-2 text-sm font-medium border-l border-gray-300 transition-colors duration-200 ${param.sort == 'popular' ? 'bg-primary-500 text-white' : 'bg-white text-gray-700 hover:bg-gray-50'}"
                                data-sort="popular">
                            <i class="fas fa-fire mr-1"></i>Popular
                        </button>
                        <button class="sort-btn px-4 py-2 text-sm font-medium border-l border-gray-300 transition-colors duration-200 ${param.sort == 'oldest' ? 'bg-primary-500 text-white' : 'bg-white text-gray-700 hover:bg-gray-50'}"
                                data-sort="oldest">
                            <i class="fas fa-history mr-1"></i>Oldest
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Topics List -->
        <div class="space-y-6">
            <c:choose>
                <c:when test="${not empty topics}">
                    <c:forEach var="topic" items="${topics}">
                        <div class="bg-white rounded-2xl shadow-lg border border-gray-100 p-6 card-hover animate-fade-in">
                            <div class="flex items-start space-x-4">
                                <!-- Author Avatar -->
                                <div class="flex-shrink-0">
                                    <div class="w-12 h-12 rounded-full avatar flex items-center justify-center text-white font-semibold">
                                        ${fn:substring(topic.user.firstName, 0, 1)}${fn:substring(topic.user.lastName, 0, 1)}
                                    </div>
                                </div>

                                <!-- Topic Content -->
                                <div class="flex-1 min-w-0">
                                    <div class="flex items-start justify-between">
                                        <div class="flex-1">
                                            <h3 class="text-xl font-semibold text-gray-900 mb-2">
                                                <a href="${pageContext.request.contextPath}/forum/topic/${topic.topicId}"
                                                   class="hover:text-primary-600 transition-colors duration-200">
                                                    ${topic.title}
                                                </a>
                                            </h3>
                                            <p class="text-gray-600 mb-4 line-clamp-3">
                                                ${fn:length(topic.description) > 200 ? fn:substring(topic.description, 0, 200).concat('...') : topic.description}
                                            </p>
                                            <div class="flex items-center space-x-6 text-sm text-gray-500">
                                                <div class="flex items-center">
                                                    <i class="fas fa-user mr-2"></i>
                                                    <span class="font-medium text-gray-700">${topic.user.fullName}</span>
                                                </div>
                                                <div class="flex items-center">
                                                    <i class="fas fa-calendar mr-2"></i>
                                                    <fmt:formatDate value="${topic.dateCreated}" pattern="MMM dd, yyyy"/>
                                                </div>
                                                <c:if test="${topic.lastActivity != topic.dateCreated}">
                                                    <div class="flex items-center">
                                                        <i class="fas fa-clock mr-2"></i>
                                                        <span>Last activity: <fmt:formatDate value="${topic.lastActivity}" pattern="MMM dd, yyyy"/></span>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>

                                        <!-- Topic Stats -->
                                        <div class="flex flex-col items-end space-y-3">
                                            <div class="bg-gradient-to-r from-primary-500 to-secondary-500 text-white px-4 py-2 rounded-full text-sm font-medium">
                                                <i class="fas fa-comments mr-2"></i>
                                                ${topic.commentCount} ${topic.commentCount == 1 ? 'comment' : 'comments'}
                                            </div>
                                            <a href="${pageContext.request.contextPath}/forum/topic/${topic.topicId}"
                                               class="bg-gray-100 hover:bg-gray-200 text-gray-700 px-4 py-2 rounded-full text-sm font-medium transition-colors duration-200">
                                                <i class="fas fa-eye mr-2"></i>View Topic
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <div class="flex justify-center mt-8">
                            <nav class="flex items-center space-x-2">
                                <c:if test="${currentPage > 1}">
                                    <a href="?page=${currentPage - 1}&sort=${param.sort}"
                                       class="px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 hover:text-gray-700 transition-colors duration-200">
                                        <i class="fas fa-chevron-left mr-1"></i>Previous
                                    </a>
                                </c:if>

                                <c:forEach begin="1" end="${totalPages}" var="page">
                                    <a href="?page=${page}&sort=${param.sort}"
                                       class="px-3 py-2 text-sm font-medium transition-colors duration-200 ${page == currentPage ? 'bg-primary-500 text-white border-primary-500' : 'text-gray-500 bg-white border-gray-300 hover:bg-gray-50 hover:text-gray-700'} border rounded-lg">
                                        ${page}
                                    </a>
                                </c:forEach>

                                <c:if test="${currentPage < totalPages}">
                                    <a href="?page=${currentPage + 1}&sort=${param.sort}"
                                       class="px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 hover:text-gray-700 transition-colors duration-200">
                                        Next<i class="fas fa-chevron-right ml-1"></i>
                                    </a>
                                </c:if>
                            </nav>
                        </div>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <div class="bg-white rounded-2xl shadow-lg border border-gray-100 p-12 text-center">
                        <div class="max-w-sm mx-auto">
                            <div class="w-20 h-20 bg-gradient-to-r from-gray-400 to-gray-500 rounded-full flex items-center justify-center mx-auto mb-6">
                                <i class="fas fa-comments text-white text-3xl"></i>
                            </div>
                            <h3 class="text-2xl font-semibold text-gray-900 mb-4">No topics found</h3>
                            <p class="text-gray-600 mb-8">Be the first to start a discussion!</p>
                            <a href="${pageContext.request.contextPath}/forum/create-topic"
                               class="bg-gradient-to-r from-primary-500 to-secondary-500 text-white px-8 py-3 rounded-full font-semibold hover:from-primary-600 hover:to-secondary-600 transition-all duration-200 transform hover:scale-105 inline-flex items-center">
                                <i class="fas fa-plus mr-2"></i>Create First Topic
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-gray-900 text-white py-12 mt-16">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <div>
                    <div class="flex items-center mb-4">
                        <div class="w-10 h-10 bg-gradient-to-r from-primary-500 to-secondary-500 rounded-xl flex items-center justify-center mr-3">
                            <i class="fas fa-comments text-white"></i>
                        </div>
                        <span class="text-xl font-bold">Forum Application</span>
                    </div>
                    <p class="text-gray-400 mb-4">
                        Advanced Java Programming project showcasing modern web development practices.
                    </p>
                    <div class="flex space-x-3">
                        <span class="inline-block bg-primary-500 text-white px-3 py-1 rounded-full text-sm">Java</span>
                        <span class="inline-block bg-blue-500 text-white px-3 py-1 rounded-full text-sm">MySQL</span>
                        <span class="inline-block bg-green-500 text-white px-3 py-1 rounded-full text-sm">JSP</span>
                    </div>
                </div>

                <div>
                    <h3 class="text-lg font-semibold mb-4">Quick Links</h3>
                    <ul class="space-y-2">
                        <li><a href="${pageContext.request.contextPath}/" class="text-gray-400 hover:text-white transition-colors">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/forum" class="text-gray-400 hover:text-white transition-colors">Browse Forum</a></li>
                        <li><a href="${pageContext.request.contextPath}/user/register" class="text-gray-400 hover:text-white transition-colors">Register</a></li>
                        <li><a href="${pageContext.request.contextPath}/api" class="text-gray-400 hover:text-white transition-colors">API</a></li>
                    </ul>
                </div>

                <div>
                    <h3 class="text-lg font-semibold mb-4">Project Info</h3>
                    <ul class="space-y-2 text-gray-400">
                        <li><i class="fas fa-university mr-2"></i>Eduvos Institution</li>
                        <li><i class="fas fa-code mr-2"></i>Module: ITHCA0</li>
                        <li><i class="fas fa-user-tie mr-2"></i>Simphiwe Radebe</li>
                        <li><i class="fas fa-calendar mr-2"></i>2025</li>
                    </ul>
                </div>
            </div>

            <div class="border-t border-gray-800 mt-8 pt-8 text-center">
                <p class="text-gray-400">
                    &copy; 2025 Forum Application. Built with ❤️ for Academic Excellence.
                </p>
            </div>
        </div>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Handle sorting
            document.querySelectorAll('.sort-btn').forEach(button => {
                button.addEventListener('click', function() {
                    const sortValue = this.dataset.sort;
                    const urlParams = new URLSearchParams(window.location.search);
                    urlParams.set('sort', sortValue);
                    urlParams.set('page', '1'); // Reset to first page
                    window.location.search = urlParams.toString();
                });
            });

            // Auto-dismiss alerts
            setTimeout(function() {
                const alerts = document.querySelectorAll('.animate-slide-down');
                alerts.forEach(function(alert) {
                    alert.style.opacity = '0';
                    alert.style.transform = 'translateY(-10px)';
                    setTimeout(() => alert.remove(), 300);
                });
            }, 5000);

            // Intersection Observer for animations
            const observerOptions = {
                threshold: 0.1,
                rootMargin: '0px 0px -50px 0px'
            };

            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('animate-fade-in');
                    }
                });
            }, observerOptions);

            // Observe topic cards for animation
            document.querySelectorAll('.card-hover').forEach(el => {
                observer.observe(el);
            });

            // Add smooth hover effects to topic cards
            document.querySelectorAll('.card-hover').forEach(card => {
                card.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-4px)';
                    this.style.boxShadow = '0 20px 40px -12px rgba(0, 0, 0, 0.15)';
                });

                card.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                    this.style.boxShadow = '0 10px 15px -3px rgba(0, 0, 0, 0.1)';
                });
            });

            // Add click animation to buttons
            document.querySelectorAll('a, button').forEach(element => {
                element.addEventListener('click', function(e) {
                    // Create ripple effect
                    const ripple = document.createElement('span');
                    const rect = this.getBoundingClientRect();
                    const size = Math.max(rect.width, rect.height);
                    const x = e.clientX - rect.left - size / 2;
                    const y = e.clientY - rect.top - size / 2;

                    ripple.style.width = ripple.style.height = size + 'px';
                    ripple.style.left = x + 'px';
                    ripple.style.top = y + 'px';
                    ripple.classList.add('ripple');

                    this.appendChild(ripple);

                    setTimeout(() => {
                        ripple.remove();
                    }, 600);
                });
            });
        });

        // Add parallax effect to header
        window.addEventListener('scroll', () => {
            const scrolled = window.pageYOffset;
            const header = document.querySelector('.gradient-bg');
            if (header && scrolled < window.innerHeight) {
                const speed = scrolled * 0.5;
                header.style.transform = `translateY(${speed}px)`;
            }
        });
    </script>

    <style>
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .animate-slide-down {
            animation: slideDown 0.3s ease-out;
        }

        .line-clamp-3 {
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        /* Ripple effect */
        .ripple {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.3);
            transform: scale(0);
            animation: ripple 0.6s linear;
            pointer-events: none;
        }

        @keyframes ripple {
            to {
                transform: scale(4);
                opacity: 0;
            }
        }

        /* Custom scrollbar for webkit browsers */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: #f1f5f9;
        }

        ::-webkit-scrollbar-thumb {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(135deg, #5a67d8 0%, #6b46c1 100%);
        }

        /* Loading states */
        .loading {
            position: relative;
            overflow: hidden;
        }

        .loading::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
            animation: loading 1.5s infinite;
        }

        @keyframes loading {
            0% { left: -100%; }
            100% { left: 100%; }
        }
    </style>
</body>
</html>