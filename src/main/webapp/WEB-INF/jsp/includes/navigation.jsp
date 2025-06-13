<%@ include file="taglibs.jsp" %>

<nav class="bg-white shadow-lg border-b border-gray-200 sticky top-0 z-50">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-16">
            <!-- Brand -->
            <div class="flex items-center">
                <a href="${pageContext.request.contextPath}/" class="flex items-center space-x-3 group">
                    <div class="w-10 h-10 bg-gradient-to-r from-primary-500 to-secondary-500 rounded-xl flex items-center justify-center group-hover:scale-110 transition-transform duration-300">
                        <i class="fas fa-comments text-white text-lg"></i>
                    </div>
                    <span class="text-xl font-bold text-gray-900 group-hover:text-primary-600 transition-colors duration-300">
                        Forum App
                    </span>
                </a>
            </div>

            <!-- Desktop Navigation -->
            <div class="hidden md:flex items-center space-x-8">
                <!-- Left side navigation -->
                <div class="flex items-center space-x-6">
                    <a href="${pageContext.request.contextPath}/"
                       class="text-gray-600 hover:text-primary-600 px-3 py-2 rounded-lg text-sm font-medium transition-colors duration-200">
                        <i class="fas fa-home mr-2"></i>Home
                    </a>

                    <c:if test="${not empty sessionScope.userId}">
                        <a href="${pageContext.request.contextPath}/forum"
                           class="text-gray-600 hover:text-primary-600 px-3 py-2 rounded-lg text-sm font-medium transition-colors duration-200">
                            <i class="fas fa-comments mr-2"></i>Forum
                        </a>
                        <a href="${pageContext.request.contextPath}/forum/my-topics"
                           class="text-gray-600 hover:text-primary-600 px-3 py-2 rounded-lg text-sm font-medium transition-colors duration-200">
                            <i class="fas fa-user-edit mr-2"></i>My Topics
                        </a>
                        <a href="${pageContext.request.contextPath}/forum/create-topic"
                           class="bg-gradient-to-r from-primary-500 to-secondary-500 text-white px-4 py-2 rounded-lg text-sm font-medium hover:from-primary-600 hover:to-secondary-600 transition-all duration-200 transform hover:scale-105">
                            <i class="fas fa-plus mr-2"></i>New Topic
                        </a>
                    </c:if>
                </div>

                <!-- Search (only show if user is logged in) -->
                <c:if test="${not empty sessionScope.userId}">
                    <div class="relative">
                        <form action="${pageContext.request.contextPath}/forum/search" method="get" class="flex">
                            <div class="relative">
                                <input type="search" name="q" placeholder="Search topics..." value="${param.q}"
                                       class="w-64 pl-10 pr-4 py-2 border border-gray-300 rounded-lg input-focus bg-gray-50 text-sm">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fas fa-search text-gray-400"></i>
                                </div>
                            </div>
                            <button type="submit"
                                    class="ml-2 px-4 py-2 bg-gray-100 hover:bg-gray-200 text-gray-600 rounded-lg transition-colors duration-200">
                                <i class="fas fa-search"></i>
                            </button>
                        </form>
                    </div>
                </c:if>

                <!-- User Menu -->
                <div class="flex items-center space-x-4">
                    <c:choose>
                        <c:when test="${not empty sessionScope.userId}">
                            <!-- User is logged in -->
                            <div class="relative group">
                                <button class="flex items-center space-x-3 p-2 rounded-lg hover:bg-gray-100 transition-colors duration-200">
                                    <div class="w-8 h-8 rounded-full avatar flex items-center justify-center text-white text-sm font-medium">
                                        ${fn:substring(sessionScope.userName, 0, 1)}
                                    </div>
                                    <span class="text-sm font-medium text-gray-700">${sessionScope.userName}</span>
                                    <i class="fas fa-chevron-down text-gray-400 text-xs"></i>
                                </button>

                                <!-- Dropdown Menu -->
                                <div class="absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-lg border border-gray-200 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200 transform group-hover:translate-y-0 translate-y-2">
                                    <div class="py-2">
                                        <div class="px-4 py-2 text-xs font-semibold text-gray-500 uppercase tracking-wider border-b border-gray-100">
                                            Account
                                        </div>
                                        <a href="${pageContext.request.contextPath}/user/profile"
                                           class="flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 transition-colors duration-200">
                                            <i class="fas fa-user mr-3 text-gray-400"></i>Profile
                                        </a>
                                        <a href="${pageContext.request.contextPath}/forum/my-topics"
                                           class="flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 transition-colors duration-200">
                                            <i class="fas fa-list mr-3 text-gray-400"></i>My Topics
                                        </a>
                                        <div class="border-t border-gray-100 my-1"></div>
                                        <a href="${pageContext.request.contextPath}/user/logout"
                                           class="flex items-center px-4 py-2 text-sm text-red-600 hover:bg-red-50 transition-colors duration-200">
                                            <i class="fas fa-sign-out-alt mr-3 text-red-400"></i>Logout
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- User is not logged in -->
                            <a href="${pageContext.request.contextPath}/user/login"
                               class="text-gray-600 hover:text-primary-600 px-3 py-2 rounded-lg text-sm font-medium transition-colors duration-200">
                                <i class="fas fa-sign-in-alt mr-2"></i>Login
                            </a>
                            <a href="${pageContext.request.contextPath}/user/register"
                               class="bg-gradient-to-r from-primary-500 to-secondary-500 text-white px-4 py-2 rounded-lg text-sm font-medium hover:from-primary-600 hover:to-secondary-600 transition-all duration-200 transform hover:scale-105">
                                <i class="fas fa-user-plus mr-2"></i>Register
                            </a>
                            <a href="${pageContext.request.contextPath}/forum"
                               class="text-gray-600 hover:text-primary-600 px-3 py-2 rounded-lg text-sm font-medium transition-colors duration-200">
                                <i class="fas fa-eye mr-2"></i>Browse Forum
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Mobile menu button -->
            <div class="md:hidden">
                <button type="button" id="mobile-menu-button"
                        class="text-gray-600 hover:text-primary-600 p-2 rounded-lg transition-colors duration-200">
                    <i class="fas fa-bars text-xl"></i>
                </button>
            </div>
        </div>
    </div>

    <!-- Mobile Navigation Menu -->
    <div id="mobile-menu" class="md:hidden hidden border-t border-gray-200 bg-white">
        <div class="px-4 py-4 space-y-3">
            <a href="${pageContext.request.contextPath}/"
               class="flex items-center px-3 py-2 text-gray-600 hover:text-primary-600 hover:bg-gray-50 rounded-lg transition-colors duration-200">
                <i class="fas fa-home mr-3"></i>Home
            </a>

            <c:if test="${not empty sessionScope.userId}">
                <a href="${pageContext.request.contextPath}/forum"
                   class="flex items-center px-3 py-2 text-gray-600 hover:text-primary-600 hover:bg-gray-50 rounded-lg transition-colors duration-200">
                    <i class="fas fa-comments mr-3"></i>Forum
                </a>
                <a href="${pageContext.request.contextPath}/forum/my-topics"
                   class="flex items-center px-3 py-2 text-gray-600 hover:text-primary-600 hover:bg-gray-50 rounded-lg transition-colors duration-200">
                    <i class="fas fa-user-edit mr-3"></i>My Topics
                </a>
                <a href="${pageContext.request.contextPath}/forum/create-topic"
                   class="flex items-center px-3 py-2 text-white bg-gradient-to-r from-primary-500 to-secondary-500 rounded-lg">
                    <i class="fas fa-plus mr-3"></i>New Topic
                </a>

                <!-- Mobile Search -->
                <div class="pt-3 border-t border-gray-200">
                    <form action="${pageContext.request.contextPath}/forum/search" method="get" class="flex">
                        <input type="search" name="q" placeholder="Search topics..." value="${param.q}"
                               class="flex-1 px-3 py-2 border border-gray-300 rounded-l-lg input-focus text-sm">
                        <button type="submit"
                                class="px-4 py-2 bg-gray-100 hover:bg-gray-200 text-gray-600 rounded-r-lg border border-l-0 border-gray-300 transition-colors duration-200">
                            <i class="fas fa-search"></i>
                        </button>
                    </form>
                </div>

                <!-- Mobile User Menu -->
                <div class="pt-3 border-t border-gray-200">
                    <div class="flex items-center px-3 py-2 mb-3">
                        <div class="w-8 h-8 rounded-full avatar flex items-center justify-center text-white text-sm font-medium mr-3">
                            ${fn:substring(sessionScope.userName, 0, 1)}
                        </div>
                        <span class="text-sm font-medium text-gray-700">${sessionScope.userName}</span>
                    </div>
                    <a href="${pageContext.request.contextPath}/user/profile"
                       class="flex items-center px-3 py-2 text-gray-600 hover:text-primary-600 hover:bg-gray-50 rounded-lg transition-colors duration-200">
                        <i class="fas fa-user mr-3"></i>Profile
                    </a>
                    <a href="${pageContext.request.contextPath}/user/logout"
                       class="flex items-center px-3 py-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors duration-200">
                        <i class="fas fa-sign-out-alt mr-3"></i>Logout
                    </a>
                </div>
            </c:if>

            <c:if test="${empty sessionScope.userId}">
                <a href="${pageContext.request.contextPath}/user/login"
                   class="flex items-center px-3 py-2 text-gray-600 hover:text-primary-600 hover:bg-gray-50 rounded-lg transition-colors duration-200">
                    <i class="fas fa-sign-in-alt mr-3"></i>Login
                </a>
                <a href="${pageContext.request.contextPath}/user/register"
                   class="flex items-center px-3 py-2 text-white bg-gradient-to-r from-primary-500 to-secondary-500 rounded-lg">
                    <i class="fas fa-user-plus mr-3"></i>Register
                </a>
                <a href="${pageContext.request.contextPath}/forum"
                   class="flex items-center px-3 py-2 text-gray-600 hover:text-primary-600 hover:bg-gray-50 rounded-lg transition-colors duration-200">
                    <i class="fas fa-eye mr-3"></i>Browse Forum
                </a>
            </c:if>
        </div>
    </div>
</nav>

<script>
    // Mobile menu toggle
    document.getElementById('mobile-menu-button').addEventListener('click', function() {
        const mobileMenu = document.getElementById('mobile-menu');
        const icon = this.querySelector('i');

        mobileMenu.classList.toggle('hidden');

        if (mobileMenu.classList.contains('hidden')) {
            icon.classList.remove('fa-times');
            icon.classList.add('fa-bars');
        } else {
            icon.classList.remove('fa-bars');
            icon.classList.add('fa-times');
        }
    });

    // Close mobile menu when clicking outside
    document.addEventListener('click', function(event) {
        const mobileMenu = document.getElementById('mobile-menu');
        const mobileMenuButton = document.getElementById('mobile-menu-button');

        if (!mobileMenu.contains(event.target) && !mobileMenuButton.contains(event.target)) {
            mobileMenu.classList.add('hidden');
            const icon = mobileMenuButton.querySelector('i');
            icon.classList.remove('fa-times');
            icon.classList.add('fa-bars');
        }
    });
</script>