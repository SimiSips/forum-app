<%@ include file="taglibs.jsp" %>

<!-- Footer -->
<footer class="bg-gray-900 text-white py-12 mt-16">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
            <div class="md:col-span-2">
                <div class="flex items-center mb-4">
                    <div class="w-10 h-10 bg-gradient-to-r from-primary-500 to-secondary-500 rounded-xl flex items-center justify-center mr-3">
                        <i class="fas fa-comments text-white"></i>
                    </div>
                    <span class="text-xl font-bold">Forum Application</span>
                </div>
                <p class="text-gray-400 mb-4 max-w-md">
                    Advanced Java Programming project showcasing modern web development practices
                    and enterprise-level architecture patterns.
                </p>
                <div class="flex flex-wrap gap-2 mb-4">
                    <span class="inline-block bg-primary-500 text-white px-3 py-1 rounded-full text-sm">
                        <i class="fab fa-java mr-1"></i>Java
                    </span>
                    <span class="inline-block bg-blue-500 text-white px-3 py-1 rounded-full text-sm">
                        <i class="fas fa-database mr-1"></i>MySQL
                    </span>
                    <span class="inline-block bg-green-500 text-white px-3 py-1 rounded-full text-sm">
                        <i class="fas fa-server mr-1"></i>JSP/Servlets
                    </span>
                    <span class="inline-block bg-purple-500 text-white px-3 py-1 rounded-full text-sm">
                        <i class="fas fa-globe mr-1"></i>REST API
                    </span>
                </div>
            </div>

            <div>
                <h3 class="text-lg font-semibold mb-4">Quick Links</h3>
                <ul class="space-y-2">
                    <li>
                        <a href="${pageContext.request.contextPath}/"
                           class="text-gray-400 hover:text-white transition-colors duration-200 flex items-center">
                            <i class="fas fa-home mr-2 text-sm"></i>Home
                        </a>
                    </li>
                    <c:choose>
                        <c:when test="${not empty sessionScope.userId}">
                            <li>
                                <a href="${pageContext.request.contextPath}/forum"
                                   class="text-gray-400 hover:text-white transition-colors duration-200 flex items-center">
                                    <i class="fas fa-comments mr-2 text-sm"></i>Forum
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/user/profile"
                                   class="text-gray-400 hover:text-white transition-colors duration-200 flex items-center">
                                    <i class="fas fa-user mr-2 text-sm"></i>Profile
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/forum/create-topic"
                                   class="text-gray-400 hover:text-white transition-colors duration-200 flex items-center">
                                    <i class="fas fa-plus mr-2 text-sm"></i>New Topic
                                </a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li>
                                <a href="${pageContext.request.contextPath}/user/login"
                                   class="text-gray-400 hover:text-white transition-colors duration-200 flex items-center">
                                    <i class="fas fa-sign-in-alt mr-2 text-sm"></i>Login
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/user/register"
                                   class="text-gray-400 hover:text-white transition-colors duration-200 flex items-center">
                                    <i class="fas fa-user-plus mr-2 text-sm"></i>Register
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/forum"
                                   class="text-gray-400 hover:text-white transition-colors duration-200 flex items-center">
                                    <i class="fas fa-eye mr-2 text-sm"></i>Browse Forum
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                    <li>
                        <a href="${pageContext.request.contextPath}/api"
                           class="text-gray-400 hover:text-white transition-colors duration-200 flex items-center">
                            <i class="fas fa-code mr-2 text-sm"></i>API Documentation
                        </a>
                    </li>
                </ul>
            </div>

            <div>
                <h3 class="text-lg font-semibold mb-4">Project Info</h3>
                <ul class="space-y-2 text-gray-400">
                    <li class="flex items-center">
                        <i class="fas fa-university mr-2 text-sm text-gray-500"></i>
                        <span class="text-sm">Eduvos Institution</span>
                    </li>
                    <li class="flex items-center">
                        <i class="fas fa-code mr-2 text-sm text-gray-500"></i>
                        <span class="text-sm">Module: ITHCA0</span>
                    </li>
                    <li class="flex items-center">
                        <i class="fas fa-user-tie mr-2 text-sm text-gray-500"></i>
                        <span class="text-sm">Simphiwe Radebe</span>
                    </li>
                    <li class="flex items-center">
                        <i class="fas fa-calendar mr-2 text-sm text-gray-500"></i>
                        <span class="text-sm">2025</span>
                    </li>
                    <li class="flex items-center">
                        <i class="fas fa-code-branch mr-2 text-sm text-gray-500"></i>
                        <span class="text-sm">Version 1.0.0</span>
                    </li>
                </ul>
            </div>
        </div>

        <div class="border-t border-gray-800 mt-8 pt-8">
            <div class="flex flex-col md:flex-row justify-between items-center">
                <div class="text-center md:text-left mb-4 md:mb-0">
                    <p class="text-gray-400 text-sm">
                        &copy; 2025 Forum Application. Built with ❤️ by Simphiwe Radebe.
                    </p>
                </div>
                <div class="flex items-center space-x-4">
                    <span class="text-gray-500 text-xs">
                        <i class="fas fa-server mr-1"></i>
                        Server Time:
                        <span id="server-time">
                            <fmt:formatDate value="<%= new java.util.Date() %>" pattern="MMM dd, yyyy HH:mm:ss"/>
                        </span>
                    </span>
                </div>
            </div>
        </div>
    </div>
</footer>

<!-- Back to Top Button -->
<button id="backToTop"
        class="fixed bottom-8 right-8 bg-gradient-to-r from-primary-500 to-secondary-500 text-white p-3 rounded-full shadow-lg hover:shadow-xl transition-all duration-300 transform hover:scale-110 opacity-0 invisible">
    <i class="fas fa-chevron-up"></i>
</button>

<!-- Scripts -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Update server time every minute
        setInterval(function() {
            const timeElement = document.getElementById('server-time');
            if (timeElement) {
                const now = new Date();
                const options = {
                    year: 'numeric',
                    month: 'short',
                    day: '2-digit',
                    hour: '2-digit',
                    minute: '2-digit',
                    second: '2-digit'
                };
                timeElement.textContent = now.toLocaleDateString('en-US', options);
            }
        }, 60000);

        // Back to top functionality
        const backToTopButton = document.getElementById('backToTop');

        window.addEventListener('scroll', function() {
            if (window.pageYOffset > 300) {
                backToTopButton.classList.remove('opacity-0', 'invisible');
                backToTopButton.classList.add('opacity-100', 'visible');
            } else {
                backToTopButton.classList.add('opacity-0', 'invisible');
                backToTopButton.classList.remove('opacity-100', 'visible');
            }
        });

        backToTopButton.addEventListener('click', function() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });

        // Add loading states to forms (if not already handled)
        const forms = document.querySelectorAll('form');
        forms.forEach(form => {
            if (!form.hasAttribute('data-form-handler')) {
                form.setAttribute('data-form-handler', 'true');
                form.addEventListener('submit', function() {
                    const submitBtn = form.querySelector('button[type="submit"]');
                    if (submitBtn && !submitBtn.disabled) {
                        const originalText = submitBtn.innerHTML;
                        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>Processing...';
                        submitBtn.disabled = true;

                        // Re-enable after 10 seconds in case of issues
                        setTimeout(() => {
                            submitBtn.innerHTML = originalText;
                            submitBtn.disabled = false;
                        }, 10000);
                    }
                });
            }
        });

        // Auto-dismiss alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert-dismissible, .animate-slide-down');
            alerts.forEach(function(alert) {
                if (alert.classList.contains('animate-slide-down')) {
                    alert.style.opacity = '0';
                    alert.style.transform = 'translateY(-10px)';
                    setTimeout(() => alert.remove(), 300);
                }
            });
        }, 5000);

        // Smooth scroll for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    });

    // Global utility functions
    window.ForumUtils = {
        // Show toast notification
        showToast: function(message, type = 'info', duration = 3000) {
            const toast = document.createElement('div');
            const bgColor = {
                'success': 'bg-green-500',
                'error': 'bg-red-500',
                'warning': 'bg-yellow-500',
                'info': 'bg-blue-500'
            }[type] || 'bg-blue-500';

            toast.className = `fixed top-4 right-4 ${bgColor} text-white px-6 py-3 rounded-lg shadow-lg z-50 transform translate-x-full transition-transform duration-300`;
            toast.innerHTML = `
                <div class="flex items-center">
                    <span>${message}</span>
                    <button onclick="this.parentElement.parentElement.remove()" class="ml-4 text-white hover:text-gray-200">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
            `;

            document.body.appendChild(toast);

            // Show toast
            setTimeout(() => {
                toast.classList.remove('translate-x-full');
            }, 100);

            // Auto-remove toast
            setTimeout(() => {
                toast.classList.add('translate-x-full');
                setTimeout(() => toast.remove(), 300);
            }, duration);
        },

        // Format date
        formatDate: function(date) {
            return new Intl.DateTimeFormat('en-US', {
                year: 'numeric',
                month: 'short',
                day: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            }).format(new Date(date));
        },

        // Copy to clipboard
        copyToClipboard: function(text) {
            if (navigator.clipboard) {
                navigator.clipboard.writeText(text).then(() => {
                    this.showToast('Copied to clipboard', 'success');
                });
            } else {
                // Fallback
                const textArea = document.createElement('textarea');
                textArea.value = text;
                document.body.appendChild(textArea);
                textArea.select();
                try {
                    document.execCommand('copy');
                    this.showToast('Copied to clipboard', 'success');
                } catch (err) {
                    this.showToast('Failed to copy', 'error');
                }
                document.body.removeChild(textArea);
            }
        }
    };
</script>