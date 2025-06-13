<%@ include file="includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="includes/header.jsp" %>
<title>Create New Topic - Forum Application</title>

<body>
    <%@ include file="includes/navigation.jsp" %>

    <div class="container mt-4 mb-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <!-- Page Header -->
                <div class="card mb-4">
                    <div class="card-body text-center">
                        <h1 class="display-6 text-gradient">
                            <i class="fas fa-plus-circle me-2"></i>Create New Topic
                        </h1>
                        <p class="text-muted mb-0">Start a new discussion and engage with the community</p>
                    </div>
                </div>

                <!-- Error Messages -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Create Topic Form -->
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-edit me-2"></i>Topic Details
                        </h5>
                    </div>

                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/forum/create-topic" method="post"
                              id="createTopicForm">

                            <!-- Topic Title -->
                            <div class="mb-4">
                                <label for="title" class="form-label">
                                    <i class="fas fa-heading me-1"></i>Topic Title *
                                </label>
                                <input type="text" class="form-control form-control-lg" id="title" name="title"
                                       value="${title}" required maxlength="255"
                                       placeholder="Enter a descriptive title for your topic">
                                <div class="form-text">
                                    <span id="titleCount">0</span>/255 characters
                                </div>
                            </div>

                            <!-- Topic Description -->
                            <div class="mb-4">
                                <label for="description" class="form-label">
                                    <i class="fas fa-align-left me-1"></i>Topic Description *
                                </label>
                                <textarea class="form-control" id="description" name="description" rows="8"
                                          required maxlength="5000"
                                          placeholder="Provide a detailed description of your topic. What would you like to discuss?">${description}</textarea>
                                <div class="form-text">
                                    <span id="descCount">0</span>/5000 characters
                                </div>
                            </div>

                            <!-- Topic Guidelines -->
                            <div class="card bg-light mb-4">
                                <div class="card-body">
                                    <h6 class="card-title">
                                        <i class="fas fa-lightbulb text-warning me-2"></i>Topic Guidelines
                                    </h6>
                                    <ul class="mb-0 small">
                                        <li>Choose a clear and descriptive title</li>
                                        <li>Provide enough context in your description</li>
                                        <li>Be respectful and follow community guidelines</li>
                                        <li>Search existing topics to avoid duplicates</li>
                                        <li>Use proper grammar and formatting</li>
                                    </ul>
                                </div>
                            </div>

                            <!-- Topic Preview -->
                            <div class="card border-secondary mb-4" id="previewCard" style="display: none;">
                                <div class="card-header bg-secondary text-white">
                                    <h6 class="mb-0">
                                        <i class="fas fa-eye me-2"></i>Preview
                                    </h6>
                                </div>
                                <div class="card-body">
                                    <h5 id="previewTitle" class="card-title"></h5>
                                    <p id="previewDescription" class="card-text"></p>
                                    <div class="text-muted small">
                                        <i class="fas fa-user me-1"></i>
                                        Posted by: ${sessionScope.userName}
                                        <i class="fas fa-calendar ms-3 me-1"></i>
                                        <span id="previewDate"></span>
                                    </div>
                                </div>
                            </div>

                            <!-- Form Actions -->
                            <div class="row">
                                <div class="col-md-6">
                                    <button type="button" class="btn btn-outline-secondary me-2" id="previewBtn">
                                        <i class="fas fa-eye me-2"></i>Preview
                                    </button>
                                    <button type="button" class="btn btn-outline-warning" onclick="clearForm()">
                                        <i class="fas fa-eraser me-2"></i>Clear
                                    </button>
                                </div>
                                <div class="col-md-6 text-end">
                                    <a href="${pageContext.request.contextPath}/forum"
                                       class="btn btn-outline-secondary me-2">
                                        <i class="fas fa-times me-2"></i>Cancel
                                    </a>
                                    <button type="submit" class="btn btn-primary" id="submitBtn">
                                        <i class="fas fa-paper-plane me-2"></i>Create Topic
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Help Section -->
                <div class="card mt-4">
                    <div class="card-header">
                        <h6 class="mb-0">
                            <i class="fas fa-question-circle me-2"></i>Need Help?
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <h6>Writing Tips</h6>
                                <ul class="small text-muted">
                                    <li>Start with a compelling question or statement</li>
                                    <li>Provide background information</li>
                                    <li>Be specific about what you want to discuss</li>
                                    <li>Use formatting to make your post readable</li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <h6>Community Guidelines</h6>
                                <ul class="small text-muted">
                                    <li>Be respectful to all members</li>
                                    <li>Stay on topic</li>
                                    <li>No spam or self-promotion</li>
                                    <li>Search before posting</li>
                                </ul>
                            </div>
                        </div>
                    </div>
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
                titleCount.className = count > 200 ? 'text-warning' : count > 240 ? 'text-danger' : '';
            });

            descriptionInput.addEventListener('input', function() {
                const count = this.value.length;
                descCount.textContent = count;
                descCount.className = count > 4000 ? 'text-warning' : count > 4800 ? 'text-danger' : '';
            });

            // Preview functionality
            previewBtn.addEventListener('click', function() {
                const title = titleInput.value.trim();
                const description = descriptionInput.value.trim();

                if (!title || !description) {
                    alert('Please fill in both title and description to preview.');
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

                previewCard.style.display = 'block';
                previewCard.scrollIntoView({ behavior: 'smooth' });
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