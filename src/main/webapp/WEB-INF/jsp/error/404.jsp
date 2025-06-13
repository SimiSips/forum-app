<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Not Found - Forum Application</title>

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- Tailwind Configuration -->
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: {
                            50: '#f0f4ff',
                            100: '#e0e7ff',
                            200: '#c7d2fe',
                            300: '#a5b4fc',
                            400: '#818cf8',
                            500: '#667eea',
                            600: '#5a67d8',
                            700: '#4c51bf',
                            800: '#434190',
                            900: '#3c366b'
                        },
                        secondary: {
                            50: '#faf5ff',
                            100: '#f3e8ff',
                            200: '#e9d5ff',
                            300: '#d8b4fe',
                            400: '#c084fc',
                            500: '#764ba2',
                            600: '#6b46c1',
                            700: '#553c9a',
                            800: '#44337a',
                            900: '#362a5c'
                        }
                    },
                    fontFamily: {
                        'sans': ['Inter', 'system-ui', 'sans-serif'],
                    },
                    animation: {
                        'fade-in': 'fadeIn 0.5s ease-in-out',
                        'slide-up': 'slideUp 0.6s ease-out',
                        'bounce-gentle': 'bounceGentle 2s infinite',
                    },
                    keyframes: {
                        fadeIn: {
                            '0%': { opacity: '0' },
                            '100%': { opacity: '1' }
                        },
                        slideUp: {
                            '0%': { opacity: '0', transform: 'translateY(30px)' },
                            '100%': { opacity: '1', transform: 'translateY(0)' }
                        },
                        bounceGentle: {
                            '0%, 100%': { transform: 'translateY(0)' },
                            '50%': { transform: 'translateY(-10px)' }
                        }
                    }
                }
            }
        }
    </script>

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
</head>

<body class="bg-gray-50 font-sans min-h-screen flex items-center justify-center">
    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
        <!-- Error Content -->
        <div class="animate-slide-up">
            <!-- Large 404 Number -->
            <div class="mb-8">
                <div class="inline-block gradient-bg rounded-3xl p-8 relative overflow-hidden">
                    <div class="floating-shapes"></div>
                    <div class="relative z-10">
                        <h1 class="text-8xl md:text-9xl font-bold text-white animate-bounce-gentle">
                            404
                        </h1>
                    </div>
                </div>
            </div>

            <!-- Error Message -->
            <div class="bg-white rounded-2xl shadow-lg border border-gray-100 p-8 mb-8">
                <div class="flex flex-col items-center">
                    <div class="w-20 h-20 bg-gradient-to-r from-red-500 to-pink-500 rounded-full flex items-center justify-center mb-6">
                        <i class="fas fa-exclamation-triangle text-white text-3xl"></i>
                    </div>

                    <h2 class="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
                        Oops! Page Not Found
                    </h2>

                    <p class="text-lg text-gray-600 mb-8 max-w-2xl">
                        The page you're looking for seems to have wandered off into the digital void.
                        Don't worry, it happens to the best of us!
                    </p>

                    <!-- Helpful Suggestions -->
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-8 w-full max-w-3xl">
                        <div class="bg-gray-50 rounded-xl p-6 text-center">
                            <div class="w-12 h-12 bg-blue-500 rounded-lg flex items-center justify-center mx-auto mb-3">
                                <i class="fas fa-search text-white"></i>
                            </div>
                            <h3 class="font-semibold text-gray-900 mb-2">Check the URL</h3>
                            <p class="text-sm text-gray-600">Make sure the web address is correct</p>
                        </div>

                        <div class="bg-gray-50 rounded-xl p-6 text-center">
                            <div class="w-12 h-12 bg-green-500 rounded-lg flex items-center justify-center mx-auto mb-3">
                                <i class="fas fa-home text-white"></i>
                            </div>
                            <h3 class="font-semibold text-gray-900 mb-2">Go Home</h3>
                            <p class="text-sm text-gray-600">Start fresh from our homepage</p>
                        </div>

                        <div class="bg-gray-50 rounded-xl p-6 text-center">
                            <div class="w-12 h-12 bg-purple-500 rounded-lg flex items-center justify-center mx-auto mb-3">
                                <i class="fas fa-comments text-white"></i>
                            </div>
                            <h3 class="font-semibold text-gray-900 mb-2">Browse Forum</h3>
                            <p class="text-sm text-gray-600">Explore our forum discussions</p>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="flex flex-col sm:flex-row gap-4 justify-center">
                        <a href="${pageContext.request.contextPath}/"
                           class="bg-gradient-to-r from-primary-500 to-secondary-500 text-white px-8 py-4 rounded-full font-semibold text-lg hover:from-primary-600 hover:to-secondary-600 transition-all duration-300 transform hover:scale-105 shadow-lg inline-flex items-center justify-center">
                            <i class="fas fa-home mr-2"></i>
                            Go Home
                        </a>

                        <a href="${pageContext.request.contextPath}/forum"
                           class="bg-white text-gray-700 border border-gray-300 px-8 py-4 rounded-full font-semibold text-lg hover:bg-gray-50 hover:border-gray-400 transition-all duration-300 inline-flex items-center justify-center">
                            <i class="fas fa-comments mr-2"></i>
                            Browse Forum
                        </a>
                    </div>
                </div>
            </div>

            <!-- Fun Footer Message -->
            <div class="bg-gradient-to-r from-blue-50 to-purple-50 rounded-xl p-6 border border-blue-100">
                <div class="flex items-center justify-center text-gray-600">
                    <i class="fas fa-lightbulb text-yellow-500 mr-2"></i>
                    <span class="text-sm">
                        Lost pages have a way of finding their way back. In the meantime, explore our forum!
                    </span>
                </div>
            </div>
        </div>
    </div>

    <!-- Background Animation -->
    <div class="fixed inset-0 -z-10 overflow-hidden">
        <div class="absolute top-20 left-20 w-72 h-72 bg-primary-200 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse"></div>
        <div class="absolute top-40 right-20 w-72 h-72 bg-secondary-200 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse animation-delay-1000"></div>
        <div class="absolute bottom-20 left-40 w-72 h-72 bg-pink-200 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse animation-delay-2000"></div>
    </div>
</body>
</html>