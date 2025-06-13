<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forum - Discussion Topics</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .navbar {
            background: linear-gradient(45deg, #667eea, #764ba2) !important;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .topic-card {
            transition: transform 0.2s, box-shadow 0.2s;
            border: none;
            border-radius: 15px;
            margin-bottom: 1rem;
        }
        .topic-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        .topic-title {
            color: #2c3e50;
            text-decoration: none;
            font-weight: 600;
        }
        .topic-title:hover {
            color: #667eea;
        }
        .topic-meta {
            font-size: 0.9rem;
            color: #6c757d;
        }
        .comment-count {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            border-radius: 20px;
            padding: 0.25rem 0.75rem;
            font-size: 0.8rem;
        }
        .btn-create {
            background: linear-gradient(45deg, #28a745, #20c997);
            border: none;
            border-radius: 25px;
            padding: 0.75rem 2rem;
            font-weight: 600;
        }
        .btn-create:hover {
            background: linear-gradient(45deg, #218838, #1ea085);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .search-box {
            border-radius: 25px;
            border: 2px solid #e9ecef;
            padding: 0.75rem 1.5rem;
        }
        .search-box:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .welcome-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
        }
        .stats-card {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            text-align: center;
            border: none;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }
        .stats-number {
            font-size: 2rem;
            font-weight: bold;
            color: #667eea;
        }
        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(45deg, #667eea, #764ba2);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/forum">
                <i class="fas fa-comments"></i> Forum
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/forum">
                            <i class="fas fa-home"></i> Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/forum/my-topics">
                            <i class="fas fa-user-edit"></i> My Topics
                        </a>
                    </li>
                </ul>

                <!-- Search -->
                <form class="d-flex me-3" action="${pageContext.request.contextPath}/forum/search" method="get">
                    <input class="form-control search-box" type="search" name="q" placeholder="Search topics..."
                           value="${param.q}" style="width: 250px;">
                    <button class="btn btn-outline-light ms-2" type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </form>

                <!-- User Menu -->
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                           data-bs-toggle="dropdown">
                            <div class="avatar d-inline-flex me-2">
                                ${sessionScope.userName.substring(0,1).toUpperCase()}
                            </div>
                            ${sessionScope.userName}
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">
                                <i class="fas fa-user"></i> Profile</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/logout">
                                <i class="fas fa-sign-out-alt"></i> Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <!-- Welcome Header -->
        <div class="welcome-header">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1><i class="fas fa-comments"></i> Welcome to the Forum</h1>
                    <p class="mb-0">Join the discussion, share your thoughts, and connect with the community!</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/forum/create-topic"
                       class="btn btn-light btn-lg">
                        <i class="fas fa-plus"></i> Create Topic
                    </a>
                </div>
            </div>
        </div>

        <!-- Forum Statistics -->
        <div class="row mb-4">
            <div class="col-md-4">
                <div class="card stats-card">
                    <div class="stats-number">${totalTopics}</div>
                    <div class="text-muted">Total Topics</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card stats-card">
                    <div class="stats-number">${totalUsers}</div>
                    <div class="text-muted">Active Users</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card stats-card">
                    <div class="stats-number">${totalComments}</div>
                    <div class="text-muted">Total Comments</div>
                </div>
            </div>
        </div>

        <!-- Messages -->
        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle"></i> ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Action Buttons -->
        <div class="row mb-4">
            <div class="col-md-6">
                <a href="${pageContext.request.contextPath}/forum/create-topic"
                   class="btn btn-create btn-lg">
                    <i class="fas fa-plus"></i> Create New Topic
                </a>
            </div>
            <div class="col-md-6 text-end">
                <div class="btn-group" role="group">
                    <input type="radio" class="btn-check" name="sortBy" id="sortLatest" value="latest"
                           <c:if test="${empty param.sort or param.sort == 'latest'}">checked</c:if>>
                    <label class="btn btn-outline-primary" for="sortLatest">Latest</label>

                    <input type="radio" class="btn-check" name="sortBy" id="sortPopular" value="popular"
                           <c:if test="${param.sort == 'popular'}">checked</c:if>>
                    <label class="btn btn-outline-primary" for="sortPopular">Popular</label>

                    <input type="radio" class="btn-check" name="sortBy" id="sortOldest" value="oldest"
                           <c:if test="${param.sort == 'oldest'}">checked</c:if>>
                    <label class="btn btn-outline-primary" for="sortOldest">Oldest</label>
                </div>
            </div>
        </div>

        <!-- Topics List -->
        <div class="row">
            <div class="col-12">
                <c:choose>
                    <c:when test="${not empty topics}">
                        <c:forEach var="topic" items="${topics}">
                            <div class="card topic-card">
                                <div class="card-body">
                                    <div class="row align-items-center">
                                        <div class="col-md-8">
                                            <h5 class="card-title">
                                                <a href="${pageContext.request.contextPath}/forum/topic/${topic.topicId}"
                                                   class="topic-title">${topic.title}</a>
                                            </h5>
                                            <p class="card-text text-muted">
                                                <%-- ${topic.getTruncatedDescription(150)} --%>
                                            </p>
                                            <div class="topic-meta">
                                                <i class="fas fa-user"></i>
                                                <strong>${topic.user.fullName}</strong>
                                                <i class="fas fa-calendar ms-3"></i>
                                                <fmt:formatDate value="${topic.dateCreated}" pattern="MMM dd, yyyy HH:mm"/>
                                                <c:if test="${topic.lastActivity != topic.dateCreated}">
                                                    <i class="fas fa-clock ms-3"></i>
                                                    Last activity: <fmt:formatDate value="${topic.lastActivity}" pattern="MMM dd, yyyy HH:mm"/>
                                                </c:if>
                                            </div>
                                        </div>
                                        <div class="col-md-4 text-end">
                                            <div class="mb-2">
                                                <span class="comment-count">
                                                    <i class="fas fa-comments"></i> ${topic.commentCount}
                                                    ${topic.commentCount == 1 ? 'comment' : 'comments'}
                                                </span>
                                            </div>
                                            <a href="${pageContext.request.contextPath}/forum/topic/${topic.topicId}"
                                               class="btn btn-outline-primary">
                                                <i class="fas fa-eye"></i> View Topic
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <nav aria-label="Topics pagination">
                                <ul class="pagination justify-content-center">
                                    <c:if test="${currentPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="?page=${currentPage - 1}&sort=${param.sort}">
                                                <i class="fas fa-chevron-left"></i> Previous
                                            </a>
                                        </li>
                                    </c:if>

                                    <c:forEach begin="1" end="${totalPages}" var="page">
                                        <li class="page-item ${page == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="?page=${page}&sort=${param.sort}">${page}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="?page=${currentPage + 1}&sort=${param.sort}">
                                                Next <i class="fas fa-chevron-right"></i>
                                            </a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <div class="card">
                            <div class="card-body text-center py-5">
                                <i class="fas fa-comments fa-3x text-muted mb-3"></i>
                                <h4 class="text-muted">No topics found</h4>
                                <p class="text-muted">Be the first to start a discussion!</p>
                                <a href="${pageContext.request.contextPath}/forum/create-topic"
                                   class="btn btn-create">
                                    <i class="fas fa-plus"></i> Create First Topic
                                </a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <%@ include file="includes/footer.jsp" %>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Handle sorting
        document.querySelectorAll('input[name="sortBy"]').forEach(radio => {
            radio.addEventListener('change', function() {
                const urlParams = new URLSearchParams(window.location.search);
                urlParams.set('sort', this.value);
                urlParams.set('page', '1'); // Reset to first page
                window.location.search = urlParams.toString();
            });
        });

        // Auto-dismiss alerts
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);

        // Smooth scroll for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });
    </script>
</body>
</html>