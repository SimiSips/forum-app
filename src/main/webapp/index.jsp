<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forum Application - Advanced Java Programming</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: {
                            50: '#f0f4ff',
                            500: '#667eea',
                            600: '#5a67d8',
                            700: '#4c51bf',
                            900: '#2d3748'
                        },
                        secondary: {
                            500: '#764ba2',
                            600: '#6b46c1'
                        }
                    },
                    fontFamily: {
                        'sans': ['Inter', 'system-ui', 'sans-serif'],
                    },
                    animation: {
                        'fade-in': 'fadeIn 0.5s ease-in-out',
                        'slide-up': 'slideUp 0.6s ease-out',
                        'bounce-gentle': 'bounceGentle 2s infinite',
                        'gradient': 'gradient 8s ease infinite',
                    },
                    keyframes: {
                        fadeIn: {
                            '0%': { opacity: '0' },
                            '100%': { opacity: '1' }
                        },
                        slideUp: {
                            '0%': { transform: 'translateY(30px)', opacity: '0' },
                            '100%': { transform: 'translateY(0)', opacity: '1' }
                        },
                        bounceGentle: {
                            '0%, 100%': { transform: 'translateY(0)' },
                            '50%': { transform: 'translateY(-10px)' }
                        },
                        gradient: {
                            '0%, 100%': { backgroundPosition: '0% 50%' },
                            '50%': { backgroundPosition: '100% 50%' }
                        }
                    }
                }
            }
        }
    </script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

        .gradient-bg {
            background: linear-gradient(-45deg, #667eea, #764ba2, #667eea, #5a67d8);
            background-size: 400% 400%;
            animation: gradient 15s ease infinite;
        }

        .glass-effect {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .card-hover {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .card-hover:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
        }

        .text-gradient {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
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
</head>
<body class="font-sans antialiased">
    <!-- Navigation -->
    <nav class="fixed top-0 w-full z-50 glass-effect">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <div class="flex items-center">
                    <div class="flex-shrink-0 flex items-center">
                        <i class="fas fa-comments text-2xl text-white mr-3"></i>
                        <span class="text-xl font-bold text-white">Forum App</span>
                    </div>
                </div>
                <div class="flex items-center space-x-4">
                    <a href="#features" class="text-white hover:text-gray-200 transition-colors duration-200">Features</a>
                    <a href="#about" class="text-white hover:text-gray-200 transition-colors duration-200">About</a>
                    <a href="${pageContext.request.contextPath}/user/login"
                       class="bg-white bg-opacity-20 hover:bg-opacity-30 text-white px-4 py-2 rounded-lg transition-all duration-200">
                        Login
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="min-h-screen gradient-bg flex items-center justify-center relative overflow-hidden">
        <div class="floating-shapes"></div>
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center relative z-10">
            <div class="animate-fade-in">
                <h1 class="text-5xl md:text-7xl font-bold text-white mb-6 leading-tight">
                    Welcome to the
                    <span class="block text-transparent bg-clip-text bg-gradient-to-r from-yellow-400 to-orange-500">
                        Future of Discussion
                    </span>
                </h1>
                <p class="text-xl md:text-2xl text-gray-200 mb-8 max-w-3xl mx-auto leading-relaxed">
                    Experience seamless communication with our advanced Java-powered forum application.
                    Connect, share ideas, and build communities like never before.
                </p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center items-center animate-slide-up">
                    <a href="${pageContext.request.contextPath}/user/register"
                       class="bg-white text-primary-600 px-8 py-4 rounded-full font-semibold text-lg hover:bg-gray-100 transition-all duration-300 transform hover:scale-105 shadow-lg">
                        <i class="fas fa-rocket mr-2"></i>Get Started Free
                    </a>
                    <a href="${pageContext.request.contextPath}/forum"
                       class="border-2 border-white text-white px-8 py-4 rounded-full font-semibold text-lg hover:bg-white hover:text-primary-600 transition-all duration-300 transform hover:scale-105">
                        <i class="fas fa-eye mr-2"></i>Explore Forum
                    </a>
                </div>
            </div>
        </div>

        <!-- Scroll indicator -->
        <div class="absolute bottom-8 left-1/2 transform -translate-x-1/2 animate-bounce-gentle">
            <i class="fas fa-chevron-down text-white text-2xl opacity-70"></i>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="py-20 bg-gray-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-16">
                <h2 class="text-4xl md:text-5xl font-bold text-gray-900 mb-4">
                    Powerful <span class="text-gradient">Features</span>
                </h2>
                <p class="text-xl text-gray-600 max-w-2xl mx-auto">
                    Built with cutting-edge Java technologies to deliver exceptional performance and user experience
                </p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                <!-- Feature 1 -->
                <div class="bg-white rounded-2xl p-8 shadow-lg card-hover border border-gray-100">
                    <div class="w-16 h-16 bg-gradient-to-r from-primary-500 to-secondary-500 rounded-2xl flex items-center justify-center mb-6">
                        <i class="fas fa-shield-alt text-white text-2xl"></i>
                    </div>
                    <h3 class="text-2xl font-bold text-gray-900 mb-4">Secure Authentication</h3>
                    <p class="text-gray-600 leading-relaxed">
                        Advanced security with password hashing, session management, and comprehensive input validation to protect your data.
                    </p>
                </div>

                <!-- Feature 2 -->
                <div class="bg-white rounded-2xl p-8 shadow-lg card-hover border border-gray-100">
                    <div class="w-16 h-16 bg-gradient-to-r from-green-500 to-blue-500 rounded-2xl flex items-center justify-center mb-6">
                        <i class="fas fa-comments text-white text-2xl"></i>
                    </div>
                    <h3 class="text-2xl font-bold text-gray-900 mb-4">Real-time Discussions</h3>
                    <p class="text-gray-600 leading-relaxed">
                        Engage in threaded conversations with nested replies, real-time updates, and seamless user interactions.
                    </p>
                </div>

                <!-- Feature 3 -->
                <div class="bg-white rounded-2xl p-8 shadow-lg card-hover border border-gray-100">
                    <div class="w-16 h-16 bg-gradient-to-r from-purple-500 to-pink-500 rounded-2xl flex items-center justify-center mb-6">
                        <i class="fas fa-search text-white text-2xl"></i>
                    </div>
                    <h3 class="text-2xl font-bold text-gray-900 mb-4">Smart Search</h3>
                    <p class="text-gray-600 leading-relaxed">
                        Find topics and discussions instantly with our powerful search engine and advanced filtering options.
                    </p>
                </div>

                <!-- Feature 4 -->
                <div class="bg-white rounded-2xl p-8 shadow-lg card-hover border border-gray-100">
                    <div class="w-16 h-16 bg-gradient-to-r from-yellow-500 to-orange-500 rounded-2xl flex items-center justify-center mb-6">
                        <i class="fas fa-mobile-alt text-white text-2xl"></i>
                    </div>
                    <h3 class="text-2xl font-bold text-gray-900 mb-4">Responsive Design</h3>
                    <p class="text-gray-600 leading-relaxed">
                        Perfect experience across all devices with our mobile-first responsive design and intuitive interface.
                    </p>
                </div>

                <!-- Feature 5 -->
                <div class="bg-white rounded-2xl p-8 shadow-lg card-hover border border-gray-100">
                    <div class="w-16 h-16 bg-gradient-to-r from-indigo-500 to-purple-500 rounded-2xl flex items-center justify-center mb-6">
                        <i class="fas fa-code text-white text-2xl"></i>
                    </div>
                    <h3 class="text-2xl font-bold text-gray-900 mb-4">RESTful API</h3>
                    <p class="text-gray-600 leading-relaxed">
                        Comprehensive web services API for external integrations and mobile app development.
                    </p>
                </div>

                <!-- Feature 6 -->
                <div class="bg-white rounded-2xl p-8 shadow-lg card-hover border border-gray-100">
                    <div class="w-16 h-16 bg-gradient-to-r from-red-500 to-pink-500 rounded-2xl flex items-center justify-center mb-6">
                        <i class="fas fa-chart-line text-white text-2xl"></i>
                    </div>
                    <h3 class="text-2xl font-bold text-gray-900 mb-4">Analytics & Insights</h3>
                    <p class="text-gray-600 leading-relaxed">
                        Track engagement, monitor activity, and gain valuable insights with comprehensive logging and analytics.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Technology Stack Section -->
    <section class="py-20 bg-white">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-16">
                <h2 class="text-4xl md:text-5xl font-bold text-gray-900 mb-4">
                    Built with <span class="text-gradient">Modern Technology</span>
                </h2>
                <p class="text-xl text-gray-600 max-w-2xl mx-auto">
                    Leveraging industry-standard technologies for optimal performance and scalability
                </p>
            </div>

            <div class="grid grid-cols-2 md:grid-cols-4 gap-8">
                <div class="text-center group">
                    <div class="w-20 h-20 bg-gradient-to-r from-orange-500 to-red-500 rounded-2xl flex items-center justify-center mx-auto mb-4 group-hover:scale-110 transition-transform duration-300">
                        <i class="fab fa-java text-white text-3xl"></i>
                    </div>
                    <h3 class="font-semibold text-gray-900">Java</h3>
                    <p class="text-gray-600 text-sm">Backend Logic</p>
                </div>

                <div class="text-center group">
                    <div class="w-20 h-20 bg-gradient-to-r from-blue-500 to-indigo-500 rounded-2xl flex items-center justify-center mx-auto mb-4 group-hover:scale-110 transition-transform duration-300">
                        <i class="fas fa-database text-white text-3xl"></i>
                    </div>
                    <h3 class="font-semibold text-gray-900">MySQL</h3>
                    <p class="text-gray-600 text-sm">Database</p>
                </div>

                <div class="text-center group">
                    <div class="w-20 h-20 bg-gradient-to-r from-green-500 to-teal-500 rounded-2xl flex items-center justify-center mx-auto mb-4 group-hover:scale-110 transition-transform duration-300">
                        <i class="fas fa-server text-white text-3xl"></i>
                    </div>
                    <h3 class="font-semibold text-gray-900">Servlets/JSP</h3>
                    <p class="text-gray-600 text-sm">Web Framework</p>
                </div>

                <div class="text-center group">
                    <div class="w-20 h-20 bg-gradient-to-r from-purple-500 to-pink-500 rounded-2xl flex items-center justify-center mx-auto mb-4 group-hover:scale-110 transition-transform duration-300">
                        <i class="fas fa-globe text-white text-3xl"></i>
                    </div>
                    <h3 class="font-semibold text-gray-900">REST API</h3>
                    <p class="text-gray-600 text-sm">Web Services</p>
                </div>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section id="about" class="py-20 bg-gray-900 text-white">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
                <div>
                    <h2 class="text-4xl md:text-5xl font-bold mb-6">
                        About This <span class="text-gradient">Project</span>
                    </h2>
                    <p class="text-xl text-gray-300 mb-6 leading-relaxed">
                        This forum application represents the culmination of advanced Java programming concepts,
                        showcasing enterprise-level architecture and modern web development practices.
                    </p>
                    <div class="space-y-4">
                        <div class="flex items-center">
                            <i class="fas fa-check-circle text-green-400 text-xl mr-4"></i>
                            <span class="text-lg">MVC Architecture Pattern</span>
                        </div>
                        <div class="flex items-center">
                            <i class="fas fa-check-circle text-green-400 text-xl mr-4"></i>
                            <span class="text-lg">DAO Design Pattern</span>
                        </div>
                        <div class="flex items-center">
                            <i class="fas fa-check-circle text-green-400 text-xl mr-4"></i>
                            <span class="text-lg">RESTful Web Services</span>
                        </div>
                        <div class="flex items-center">
                            <i class="fas fa-check-circle text-green-400 text-xl mr-4"></i>
                            <span class="text-lg">Comprehensive Security</span>
                        </div>
                    </div>
                </div>
                <div class="text-center">
                    <div class="bg-gradient-to-r from-primary-500 to-secondary-500 p-8 rounded-3xl shadow-2xl">
                        <div class="text-center mb-6">
                            <i class="fas fa-graduation-cap text-6xl text-white mb-4"></i>
                            <h3 class="text-2xl font-bold text-white">Academic Project</h3>
                        </div>
                        <div class="space-y-3 text-white">
                            <p><strong>Module:</strong> ITHCA0</p>
                            <p><strong>Course:</strong> Advanced Java Programming</p>
                            <p><strong>Developer:</strong> Simphiwe Radebe</p>
                            <p><strong>Year:</strong> 2025</p>
                            <p><strong>Version:</strong> 1.0.0</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="py-20 gradient-bg relative overflow-hidden">
        <div class="floating-shapes"></div>
        <div class="max-w-4xl mx-auto text-center px-4 sm:px-6 lg:px-8 relative z-10">
            <h2 class="text-4xl md:text-5xl font-bold text-white mb-6">
                Ready to Join the Discussion?
            </h2>
            <p class="text-xl text-gray-200 mb-8 max-w-2xl mx-auto">
                Create your account today and become part of our growing community of developers and tech enthusiasts.
            </p>
            <div class="flex flex-col sm:flex-row gap-4 justify-center items-center">
                <a href="${pageContext.request.contextPath}/user/register"
                   class="bg-white text-primary-600 px-8 py-4 rounded-full font-semibold text-lg hover:bg-gray-100 transition-all duration-300 transform hover:scale-105 shadow-lg">
                    <i class="fas fa-user-plus mr-2"></i>Create Account
                </a>
                <a href="${pageContext.request.contextPath}/user/login"
                   class="border-2 border-white text-white px-8 py-4 rounded-full font-semibold text-lg hover:bg-white hover:text-primary-600 transition-all duration-300 transform hover:scale-105">
                    <i class="fas fa-sign-in-alt mr-2"></i>Sign In
                </a>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-gray-900 text-white py-12">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <div>
                    <div class="flex items-center mb-4">
                        <i class="fas fa-comments text-2xl text-primary-500 mr-3"></i>
                        <span class="text-xl font-bold">Forum Application</span>
                    </div>
                    <p class="text-gray-400 mb-4">
                        Advanced Java Programming project showcasing modern web development practices and enterprise architecture.
                    </p>
                    <div class="flex space-x-4">
                        <span class="inline-block bg-primary-500 text-white px-3 py-1 rounded-full text-sm">Java</span>
                        <span class="inline-block bg-blue-500 text-white px-3 py-1 rounded-full text-sm">MySQL</span>
                        <span class="inline-block bg-green-500 text-white px-3 py-1 rounded-full text-sm">JSP</span>
                    </div>
                </div>

                <div>
                    <h3 class="text-lg font-semibold mb-4">Quick Links</h3>
                    <ul class="space-y-2">
                        <li><a href="${pageContext.request.contextPath}/forum" class="text-gray-400 hover:text-white transition-colors">Browse Forum</a></li>
                        <li><a href="${pageContext.request.contextPath}/user/register" class="text-gray-400 hover:text-white transition-colors">Register</a></li>
                        <li><a href="${pageContext.request.contextPath}/user/login" class="text-gray-400 hover:text-white transition-colors">Login</a></li>
                        <li><a href="${pageContext.request.contextPath}/api" class="text-gray-400 hover:text-white transition-colors">API Documentation</a></li>
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
                    &copy; 2025 Forum Application. Built with ❤️ by Simphiwe Radebe.
                </p>
            </div>
        </div>
    </footer>

    <script>
        // Smooth scrolling for navigation links
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

        // Add parallax effect to hero section
        window.addEventListener('scroll', () => {
            const scrolled = window.pageYOffset;
            const parallax = document.querySelector('.gradient-bg');
            if (parallax) {
                const speed = scrolled * 0.5;
                parallax.style.transform = `translateY(${speed}px)`;
            }
        });

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

        // Observe elements for animation
        document.querySelectorAll('.card-hover').forEach(el => {
            observer.observe(el);
        });
    </script>
</body>
</html>