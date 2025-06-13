<%@ include file="includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="includes/header.jsp" %>
<title>Create New Topic - Forum Application</title>

<body class="bg-gray-50 min-h-screen">
    <%@ include file="includes/navigation.jsp" %>

    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
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
                        <span class="text-sm font-medium text-gray-700">Create Topic</span>
                    </div>
                </li>
            </ol>
        </nav>

        <!-- Page Header -->
        <div class="bg-white rounded-2xl shadow-lg border border-gray-100 p-8 mb-8">
            <div class="text-center">
                <div class="w-16 h-16 bg-gradient-to-r from-primary-500 to-secondary-500 rounded-2xl flex items-center justify-center mx-auto mb-4">
                    <i class="fas fa-plus-circle text-white text-2xl"></i>
                </div>
                <h1 class="text-3xl font-bold text-gray-900 mb-2">Create New Topic</h1>
                <p class="text-gray-600">Start a new discussion and engage with the community</p>
            </div>
        </div>

        <!-- Error Messages -->
        <c:if test="${not empty error}">
            <div class="mb-6 bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg animate-slide-down">
                <div class="flex items-center">
                    <i class="fas fa-exclamation-triangle mr-3 text-red-500"></i>
                    <span>${error}</span>
                </div>
            </div>
        </c:if>

        <!-- Create Topic Form -->
        <div class="bg-white rounded-2xl shadow-lg border border-gray-100 overflow-hidden">
            <div class="bg-gradient-to-r from-primary-500 to-secondary-500 px-6 py-4">
                <h2 class="text-xl font-semibold text-white">
                    <i class="fas fa-edit mr-2"></i>Topic Details
                </h2>
            </div>

            <div class="p-6">
                <form action="${pageContext.request.contextPath}/forum/create-topic" method="post" id="createTopicForm" class="space-y-6">

                    <!-- Topic Title -->
                    <div>
                        <label for="title" class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="fas fa-heading mr-2 text-gray-400"></i>Topic Title *
                        </label>
                        <input type="text" id="title" name="title" value="${title}" required maxlength="255"
                               class="w-full px-4 py-3 text-lg border border-gray-300 rounded-lg input-focus transition-all duration-200 bg-gray-50 focus:bg-white"
                               placeholder="Enter a descriptive title for your topic">
                        <div class="mt-2 flex justify-between items-center">
                            <p class="text-xs text-gray-500">
                                <i class="fas fa-lightbulb mr-1"></i>
                                Choose a clear and descriptive title that summarizes your topic
                            </p>
                            <span class="text-xs text-gray-500">
                                <span id="titleCount">0</span>/255 characters
                            </span>
                        </div>
                    </div>

                    <!-- Topic Description -->
                    <div>
                        <label for="description" class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="fas fa-align-left mr-2 text-gray-400"></i>Topic Description *
                        </label>
                        <textarea id="description" name="description" rows="8" required maxlength="5000"
                                  class="w-full px-4 py-3 border border-gray-300 rounded-lg input-focus transition-all duration-200 bg-gray-50 focus:bg-white resize-none"
                                  placeholder="Provide a detailed description of your topic. What would you like to discuss?">${description}</textarea>
                        <div class="mt-2 flex justify-between items-center">
                            <p class="text-xs text-gray-500">
                                <i class="fas fa-info-circle mr-1"></i>
                                Provide enough context for meaningful discussion
                            </p>
                            <span class="text-xs text-gray-500">
                                <span id="descCount">0</span>/5000 characters
                            </span>
                        </div>
                    </div>

                    <!-- Topic Guidelines -->
                    <div class="bg-blue-50 border border-blue-200 rounded-lg p-4">
                        <h3 class="text-sm font-semibold text-blue-900 mb-2">
                            <i class="fas fa-info-circle mr-2"></i>Community Guidelines
                        </h3>
                        <ul class="text-xs text-blue-800 space-y-1">
                            <li><i class="fas fa-check mr-2 text-blue-600"></i>Choose a clear and descriptive title</li>
                            <li><i class="fas fa-check mr-2 text-blue-600"></i>Provide enough context in your description</li>
                            <li><i class="fas fa-check mr-2 text-blue-600"></i>Be respectful and follow community guidelines</li>
                            <li><i class="fas fa-check mr-2 text-blue-600"></i>Search existing topics to avoid duplicates</li>
                            <li><i class="fas fa-check mr-2 text-blue-600"></i>Use proper grammar and formatting</li>
                        </ul>
                    </div>

                    <!-- Topic Preview -->
                    <div id="previewCard" class="bg-gray-50 border border-gray-200 rounded-lg p-4 hidden">
                        <h3 class="text-sm font-semibold text-gray-700 mb-3">
                            <i class="fas fa-eye mr-2"></i>Preview
                        </h3>
                        <div class="bg-white rounded-lg p-4 border border-gray-200">
                            <h4 id="previewTitle" class="text-xl font-semibold text-gray-900 mb-2"></h4>
                            <p id="previewDescription" class="text-gray-600 mb-3"></p>
                            <div class="flex items-center text-sm text-gray-500">
                                <div class="flex items-center mr-6">
                                    <div class="w-6 h-6 rounded-full avatar flex items-center justify-center text-white text-xs mr-2">
                                        ${fn:substring(sessionScope.userName, 0, 1)}
                                    </div>
                                    <span>${sessionScope.userName}</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-calendar mr-2"></i>
                                    <span id="previewDate"></span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Form Actions -->
                    <div class="flex flex-col sm:flex-row justify-between items-center space-y-4 sm:space-y-0 pt-6 border-t border-gray-200">
                        <div class="flex space-x-3">
                            <button type="button" id="previewBtn"
                                    class="bg-gray-100 hover:bg-gray-200 text-gray-700 px-4 py-2 rounded-lg font-medium transition-colors duration-200">
                                <i class="fas fa-eye mr-2"></i>Preview
                            </button>
                            <button type="button" onclick="clearForm()"
                                    class="bg-yellow-100 hover:bg-yellow-200 text-yellow-700 px-4 py-2 rounded-lg font-medium transition-colors duration-200">
                                <i class="fas fa-eraser mr-2"></i>Clear
                            </button>
                        </div>
                        <div class="flex space-x-3">
                            <a href="${pageContext.request.contextPath}/forum"
                               class="bg-gray-100 hover:bg-gray-200 text-gray-700 px-6 py-3 rounded-lg font-medium transition-colors duration-200">
                                <i class="fas fa-times mr-2"></i>Cancel
                            </a>
                            <button type="submit" id="submitBtn"
                                    class="bg-gradient-to-r from-primary-500 to-secondary-500 text-white px-6 py-3 rounded-lg font-medium hover:from-primary-600 hover:to-secondary-600 transition-all duration-200 transform hover:scale-105">
                                <i class="fas fa-paper-plane mr-2"></i>Create Topic
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Help Section -->
        <div class="mt-8 bg-white rounded-2xl shadow-lg border border-gray-100 p-6">
            <h3 class="text-lg font-semibold text-gray-900 mb-4">
                <i class="fas fa-question-circle mr-2 text-primary-500"></i>Need Help?
            </h3>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                    <h4 class="font-semibold text-gray-700 mb-2">Writing Tips</h4>
                    <ul class="text-sm text-gray-600 space-y-1">
                        <li><i class="fas fa-arrow-right mr-2 text-gray-400"></i>Start with a compelling question or statement</li>
                        <li><i class="fas fa-arrow-right mr-2 text-gray-400"></i>Provide background information</li>
                        <li><i class="fas fa-arrow-right mr-2 text-gray-400"></i>Be specific about what you want to discuss</li>
                        <li><i class="fas fa-arrow-right mr-2 text-gray-400"></i>Use formatting to make your post readable</li>
                    </ul>
                </div>
                <div>
                    <h4 class="font-semibold text-gray-700 mb-2">Best Practices</h4>
                    <ul class="text-sm text-gray-600 space-y-1">
                        <li><i class="fas fa-arrow-right mr-2 text-gray-400"></i>Be respectful to all members</li>
                        <li><i class="fas fa-arrow-right mr-2 text-gray-400"></i>Stay on topic</li>
                        <li><i class="fas fa-arrow-right mr-2 text-gray-400"></i>No spam or self-promotion</li>
                        <li><i class="fas fa-arrow-right mr-2 text-gray-400"></i>Search before posting</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="includes/footer.jsp" %>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const titleInput = document.getElementById('title');
            const descriptionInput = document.getElementById('description');
            const titleCount = document.getElementById('titleCount');
            const descCount = document.getElementById('descCount');
            const previewBtn = document.getElementById('previewBtn');
            const previewCard = document.getElementById('previewCard');
            const previewTitle = document.getElementById('previewTitle');
            const previewDescription = document.getElementById('previewDescription');
            const previewDate = document.getElementById('previewDate');
            const form = document.getElementById('createTopicForm');

            // Character counters
            titleInput.addEventListener('input', function() {
                const count = this.value.length;
                titleCount.textContent = count;
                titleCount.className = count > 200 ? 'text-yellow-500' : count > 240 ? 'text-red-500' : 'text-gray-500';
            });

            descriptionInput.addEventListener('input', function() {
                const count = this.value.length;
                descCount.textContent = count;
                descCount.className = count > 4000 ? 'text-yellow-500' : count > 4800 ? 'text-red-500' : 'text-gray-500';

                // Auto-resize textarea
                this.style.height = 'auto';
                this.style.height = (this.scrollHeight) + 'px';
            });

            // Preview functionality
            previewBtn.addEventListener('click', function() {
                const title = titleInput.value.trim();
                const description = descriptionInput.value.trim();

                if (!title || !description) {
                    if (window.ForumUtils) {
                        window.ForumUtils.showToast('Please fill in both title and description to preview.', 'warning');
                    } else {
                        alert('Please fill in both title and description to preview.');
                    }
                    return;
                }

                previewTitle.textContent = title;
                previewDescription.textContent = description;
                previewDate.textContent = new Date().toLocaleDateString('en-US', {
                    year: 'numeric',
                    month: 'long',
                    day: 'numeric',
                    hour: '2-digit',
                    minute: '2-digit'
                });

                previewCard.classList.remove('hidden');
                previewCard.scrollIntoView({ behavior: 'smooth' });

                // Update button text
                this.innerHTML = '<i class="fas fa-eye-slash mr-2"></i>Hide Preview';
                this.onclick = function() {
                    previewCard.classList.add('hidden');
                    this.innerHTML = '<i class="fas fa-eye mr-2"></i>Preview';
                    this.onclick = arguments.callee.caller;
                };
            });

            // Form validation
            form.addEventListener('submit', function(e) {
                const title = titleInput.value.trim();
                const description = descriptionInput.value.trim();

                if (!title || !description) {
                    e.preventDefault();
                    alert('Please fill in all required fields.');
                    return false;
                }

                if (title.length < 5) {
                    e.preventDefault();
                    alert('Topic title must be at least 5 characters long.');
                    titleInput.focus();
                    return false;
                }

                if (description.length < 20) {
                    e.preventDefault();
                    alert('Topic description must be at least 20 characters long.');
                    descriptionInput.focus();
                    return false;
                }

                // Show loading state
                const submitBtn = document.getElementById('submitBtn');
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Creating...';
                submitBtn.disabled = true;
            });

            // Initialize character counters
            titleInput.dispatchEvent(new Event('input'));
            descriptionInput.dispatchEvent(new Event('input'));

            // Auto-resize textarea
            descriptionInput.addEventListener('input', function() {
                this.style.height = 'auto';
                this.style.height = (this.scrollHeight) + 'px';
            });
        });

        function clearForm() {
            if (confirm('Are you sure you want to clear all content?')) {
                document.getElementById('createTopicForm').reset();
                document.getElementById('previewCard').style.display = 'none';
                document.getElementById('titleCount').textContent = '0';
                document.getElementById('descCount').textContent = '0';
                document.getElementById('title').focus();
            }
        }
    </script>
</body>
</html>