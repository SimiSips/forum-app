<%@ include file="taglibs.jsp" %>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
    <div class="container">
        <!-- Brand -->
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/">
            <i class="fas fa-comments me-2"></i>Forum App
        </a>

        <!-- Mobile toggle button -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navigation items -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <!-- Left side navigation -->
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/">
                        <i class="fas fa-home me-1"></i>Home
                    </a>
                </li>

                <c:if test="${not empty sessionScope.userId}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/forum">
                            <i class="fas fa-comments me-1"></i>Forum
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/forum/my-topics">
                            <i class="fas fa-user-edit me-1"></i>My Topics
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/forum/create-topic">
                            <i class="fas fa-plus me-1"></i>New Topic
                        </a>
                    </li>
                </c:if>
            </ul>

            <!-- Search form (only show if user is logged in) -->
            <c:if test="${not empty sessionScope.userId}">
                <form class="d-flex me-3" action="${pageContext.request.contextPath}/forum/search" method="get">
                    <div class="input-group">
                        <input class="form-control" type="search" name="q" placeholder="Search topics..."
                               value="${param.q}" style="border-radius: 20px 0 0 20px;">
                        <button class="btn btn-outline-light" type="submit" style="border-radius: 0 20px 20px 0;">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </form>
            </c:if>

            <!-- Right side navigation -->
            <ul class="navbar-nav">
                <c:choose>
                    <c:when test="${not empty sessionScope.userId}">
                        <!-- User is logged in -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="navbarDropdown"
                               role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <div class="avatar me-2">
                                    ${fn:substring(sessionScope.userName, 0, 1)}
                                </div>
                                <span class="d-none d-md-inline">${sessionScope.userName}</span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li>
                                    <h6 class="dropdown-header">
                                        <i class="fas fa-user-circle me-1"></i>
                                        ${sessionScope.userName}
                                    </h6>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">
                                        <i class="fas fa-user me-2"></i>Profile
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/forum/my-topics">
                                        <i class="fas fa-list me-2"></i>My Topics
                                    </a>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/user/logout">
                                        <i class="fas fa-sign-out-alt me-2"></i>Logout
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <!-- User is not logged in -->
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/user/login">
                                <i class="fas fa-sign-in-alt me-1"></i>Login
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/user/register">
                                <i class="fas fa-user-plus me-1"></i>Register
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/forum">
                                <i class="fas fa-eye me-1"></i>Browse Forum
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<!-- Breadcrumb (optional, can be enabled per page) -->
<c:if test="${not empty breadcrumbs}">
    <div class="container mt-3">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb bg-light rounded p-2">
                <c:forEach var="crumb" items="${breadcrumbs}" varStatus="status">
                    <c:choose>
                        <c:when test="${status.last}">
                            <li class="breadcrumb-item active" aria-current="page">${crumb.name}</li>
                        </c:when>
                        <c:otherwise>
                            <li class="breadcrumb-item">
                                <a href="${crumb.url}">${crumb.name}</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </ol>
        </nav>
    </div>
</c:if>