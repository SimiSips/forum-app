<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forum Application - Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .main-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .header-section {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            padding: 3rem 2rem;
            text-align: center;
        }
        .content-section {
            padding: 3rem 2rem;
        }
        .feature-card {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            border-left: 4px solid #667eea;
        }
        .btn-custom {
            background: linear-gradient(45deg, #667eea, #764ba2);
            border: none;
            border-radius: 25px;
            padding: 0.75rem 2rem;
            color: white;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
            color: white;
        }
        .btn-outline-custom {
            border: 2px solid #667eea;
            color: #667eea;
            border-radius: 25px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-outline-custom:hover {
            background: #667eea;
            color: white;
            transform: translateY(-2px);
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin: 2rem 0;
        }
        .stat-card {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            padding: 1.5rem;
            border-radius: 15px;
            text-align: center;
        }
        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            display: block;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="main-container">
                    <!-- Header Section -->
                    <div class="header-section">
                        <h1 class="display-4 mb-3">
                            <i class="fas fa-comments"></i> Forum Application
                        </h1>
                        <p class="lead mb-0">Advanced Java Programming Project</p>
                        <p class="mb-0">
                            <small>Module: ITHCA0 | Created by: Simphiwe Radebe</small>
                        </p>
                    </div>

                    <!-- Content Section -->
                    <div class="content-section">
                        <!-- Quick Actions -->
                        <div class="text-center mb-5">
                            <h3 class="mb-4">Get Started</h3>
                            <div class="d-flex justify-content-center gap-3 flex-wrap">
                                <a href="user/login" class="btn btn-custom btn-lg">
                                    <i class="fas fa-sign-in-alt"></i> Login
                                </a>
                                <a href="user/register" class="btn btn-outline-custom btn-lg">
                                    <i class="fas fa-user-plus"></i> Register
                                </a>
                                <a href="forum" class="btn btn-outline-custom btn-lg">
                                    <i class="fas fa-eye"></i> Browse Forum
                                </a>
                            </div>
                        </div>

                        <!-- Features Grid -->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="feature-card">
                                    <h5><i class="fas fa-user-shield text-primary"></i> User Management</h5>
                                    <p class="mb-0">Secure registration, authentication, and profile management with password reset functionality.</p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="feature-card">
                                    <h5><i class="fas fa-comments text-success"></i> Discussion Forum</h5>
                                    <p class="mb-0">Create topics, post comments, and engage in threaded discussions with the community.</p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="feature-card">
                                    <h5><i class="fas fa-search text-info"></i> Search & Discovery</h5>
                                    <p class="mb-0">Find topics and discussions easily with powerful search functionality.</p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="feature-card">
                                    <h5><i class="fas fa-code text-warning"></i> Web Services API</h5>
                                    <p class="mb-0">RESTful API endpoints for external integration and mobile applications.</p>
                                </div>
                            </div>
                        </div>

                        <!-- Technical Features -->
                        <div class="mt-5">
                            <h4 class="text-center mb-4">Technical Implementation</h4>
                            <div class="row">
                                <div class="col-md-4 text-center">
                                    <i class="fas fa-server fa-3x text-primary mb-3"></i>
                                    <h6>Backend</h6>
                                    <p class="small text-muted">Java Servlets, JSP, DAO Pattern, MySQL Database</p>
                                </div>
                                <div class="col-md-4 text-center">
                                    <i class="fas fa-globe fa-3x text-success mb-3"></i>
                                    <h6>Frontend</h6>
                                    <p class="small text-muted">Bootstrap 5, Responsive Design, Modern UI/UX</p>
                                </div>
                                <div class="col-md-4 text-center">
                                    <i class="fas fa-shield-alt fa-3x text-danger mb-3"></i>
                                    <h6>Security</h6>
                                    <p class="small text-muted">Password Hashing, Input Validation, Session Management</p>
                                </div>
                            </div>
                        </div>

                        <!-- Project Info -->
                        <div class="mt-5 pt-4 border-top">
                            <div class="row align-items-center">
                                <div class="col-md-8">
                                    <h6 class="mb-1">Advanced Java Programming Assessment</h6>
                                    <p class="text-muted mb-0">
                                        Complete distributed application with web services,
                                        database integration, and modern web interface.
                                    </p>
                                </div>
                                <div class="col-md-4 text-end">
                                    <div class="badge bg-success fs-6 p-2">
                                        <i class="fas fa-check-circle"></i> Fully Functional
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Footer -->
                <div class="text-center mt-4">
                    <p class="text-white-50">
                        <small>&copy; 2025 Forum Application | Built with ❤️ for Academic Excellence</small>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Add some interactive effects
        document.addEventListener('DOMContentLoaded', function() {
            // Animate feature cards on hover
            const featureCards = document.querySelectorAll('.feature-card');
            featureCards.forEach(card => {
                card.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-5px)';
                    this.style.boxShadow = '0 8px 25px rgba(0,0,0,0.1)';
                });
                card.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                    this.style.boxShadow = 'none';
                });
            });
        });
    </script>
</body>
</html>