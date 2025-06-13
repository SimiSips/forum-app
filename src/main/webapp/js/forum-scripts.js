/**
 * Forum Application JavaScript
 * Client-side functionality for enhanced user experience
 *
 * @author Simphiwe Radebe
 * @version 1.3
 * @since 2025-06-06
 */

// Global forum application object
const ForumApp = {
    // Configuration
    config: {
        maxCommentLength: 2000,
        maxReplyLength: 1000,
        autoSaveInterval: 30000,
        animationDuration: 300
    },

    // Initialize the application
    init: function() {
        this.setupEventListeners();
        this.initializeComponents();
        this.startAutoSave();
        console.log('Forum Application initialized');
    },

    // Set up event listeners
    setupEventListeners: function() {
        // Form submissions
        this.setupFormHandlers();

        // Navigation
        this.setupNavigationHandlers();

        // Comments and replies
        this.setupCommentHandlers();

        // Search functionality
        this.setupSearchHandlers();

        // Real-time features
        this.setupRealTimeFeatures();
    },

    // Initialize components
    initializeComponents: function() {
        this.initializeTooltips();
        this.initializeModals();
        this.initializeTextareas();
        this.initializeCounters();
        this.initializeLazyLoading();
    },

    // Form handling
    setupFormHandlers: function() {
        // Generic form submission handler
        document.querySelectorAll('form').forEach(form => {
            form.addEventListener('submit', function(e) {
                const submitBtn = form.querySelector('button[type="submit"]');
                if (submitBtn && !submitBtn.disabled) {
                    ForumApp.showLoading(submitBtn);

                    // Re-enable after timeout to prevent permanent disable
                    setTimeout(() => {
                        ForumApp.hideLoading(submitBtn);
                    }, 10000);
                }
            });
        });

        // Form validation
        this.setupFormValidation();
    },

    // Form validation
    setupFormValidation: function() {
        // Real-time validation for input fields
        document.querySelectorAll('input, textarea').forEach(field => {
            field.addEventListener('blur', function() {
                ForumApp.validateField(this);
            });

            field.addEventListener('input', function() {
                // Clear validation state on input
                this.classList.remove('is-invalid', 'is-valid');
            });
        });
    },

    // Validate individual field
    validateField: function(field) {
        const value = field.value.trim();
        const type = field.type;
        const required = field.hasAttribute('required');

        // Required field validation
        if (required && !value) {
            this.showFieldError(field, 'This field is required');
            return false;
        }

        // Email validation
        if (type === 'email' && value) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(value)) {
                this.showFieldError(field, 'Please enter a valid email address');
                return false;
            }
        }

        // Password validation
        if (field.name === 'password' && value) {
            if (!this.isPasswordStrong(value)) {
                this.showFieldError(field, 'Password must be at least 8 characters with uppercase, lowercase, number, and special character');
                return false;
            }
        }

        // Character limit validation
        const maxLength = field.getAttribute('maxlength');
        if (maxLength && value.length > parseInt(maxLength)) {
            this.showFieldError(field, `Maximum ${maxLength} characters allowed`);
            return false;
        }

        this.showFieldSuccess(field);
        return true;
    },

    // Show field error
    showFieldError: function(field, message) {
        field.classList.remove('is-valid');
        field.classList.add('is-invalid');

        let feedback = field.parentNode.querySelector('.invalid-feedback');
        if (!feedback) {
            feedback = document.createElement('div');
            feedback.className = 'invalid-feedback';
            field.parentNode.appendChild(feedback);
        }
        feedback.textContent = message;
    },

    // Show field success
    showFieldSuccess: function(field) {
        field.classList.remove('is-invalid');
        field.classList.add('is-valid');
    },

    // Password strength checker
    isPasswordStrong: function(password) {
        return password.length >= 8 &&
               /[a-z]/.test(password) &&
               /[A-Z]/.test(password) &&
               /[0-9]/.test(password) &&
               /[^A-Za-z0-9]/.test(password);
    },

    // Navigation handlers
    setupNavigationHandlers: function() {
        // Smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
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

        // Back button functionality
        document.querySelectorAll('[data-action="back"]').forEach(button => {
            button.addEventListener('click', function() {
                window.history.back();
            });
        });
    },

    // Comment and reply handlers
    setupCommentHandlers: function() {
        // Reply button handlers
        document.querySelectorAll('.reply-btn').forEach(button => {
            button.addEventListener('click', function() {
                const commentId = this.dataset.commentId;
                ForumApp.toggleReplyForm(commentId);
            });
        });

        // Cancel reply handlers
        document.querySelectorAll('.cancel-reply').forEach(button => {
            button.addEventListener('click', function() {
                const form = this.closest('.reply-form');
                if (form) {
                    form.style.display = 'none';
                }
            });
        });

        // Character counters for textareas
        document.querySelectorAll('textarea').forEach(textarea => {
            this.setupCharacterCounter(textarea);
        });
    },

    // Toggle reply form visibility
    toggleReplyForm: function(commentId) {
        const replyForm = document.getElementById(`reply-form-${commentId}`);
        if (replyForm) {
            const isVisible = replyForm.style.display !== 'none';

            // Hide all other reply forms
            document.querySelectorAll('.reply-form').forEach(form => {
                form.style.display = 'none';
            });

            // Toggle current form
            replyForm.style.display = isVisible ? 'none' : 'block';

            if (!isVisible) {
                const textarea = replyForm.querySelector('textarea');
                if (textarea) {
                    textarea.focus();
                }
            }
        }
    },

    // Setup character counter for textarea
    setupCharacterCounter: function(textarea) {
        const maxLength = textarea.getAttribute('maxlength');
        if (!maxLength) return;

        const counter = document.createElement('div');
        counter.className = 'character-counter text-muted small mt-1';
        counter.textContent = `0/${maxLength} characters`;

        textarea.parentNode.appendChild(counter);

        textarea.addEventListener('input', function() {
            const count = this.value.length;
            counter.textContent = `${count}/${maxLength} characters`;

            if (count > maxLength * 0.9) {
                counter.classList.add('text-warning');
            } else {
                counter.classList.remove('text-warning');
            }

            if (count >= maxLength) {
                counter.classList.add('text-danger');
            } else {
                counter.classList.remove('text-danger');
            }
        });
    },

    // Search handlers
    setupSearchHandlers: function() {
        const searchForm = document.querySelector('form[action*="search"]');
        if (searchForm) {
            const searchInput = searchForm.querySelector('input[name="q"]');
            if (searchInput) {
                // Auto-suggest functionality could be added here
                searchInput.addEventListener('input', this.debounce(function() {
                    // Future: Implement live search suggestions
                }, 300));
            }
        }
    },

    // Real-time features
    setupRealTimeFeatures: function() {
        // Auto-save draft functionality
        this.setupAutoSave();

        // Online/offline status
        this.setupConnectionStatus();

        // Periodic session refresh
        this.setupSessionRefresh();
    },

    // Auto-save functionality
    setupAutoSave: function() {
        document.querySelectorAll('textarea').forEach(textarea => {
            textarea.addEventListener('input', this.debounce(() => {
                this.saveToLocalStorage(textarea);
            }, 2000));
        });
    },

    // Save content to local storage
    saveToLocalStorage: function(textarea) {
        if (!textarea.name || !textarea.value) return;

        const key = `forum_draft_${textarea.name}_${Date.now()}`;
        try {
            localStorage.setItem(key, textarea.value);
            this.showToast('Draft saved', 'success');
        } catch (e) {
            console.warn('Could not save draft to localStorage:', e);
        }
    },

    // Load draft from local storage
    loadFromLocalStorage: function(textarea) {
        if (!textarea.name) return;

        const keys = Object.keys(localStorage).filter(key =>
            key.startsWith(`forum_draft_${textarea.name}`)
        );

        if (keys.length > 0) {
            const latestKey = keys.sort().pop();
            const draft = localStorage.getItem(latestKey);
            if (draft && !textarea.value) {
                textarea.value = draft;
                this.showToast('Draft restored', 'info');
            }
        }
    },

    // Connection status monitoring
    setupConnectionStatus: function() {
        window.addEventListener('online', () => {
            this.showToast('Connection restored', 'success');
        });

        window.addEventListener('offline', () => {
            this.showToast('Connection lost', 'warning');
        });
    },

    // Session refresh
    setupSessionRefresh: function() {
        // Ping server every 15 minutes to keep session alive
        setInterval(() => {
            fetch('/forum-app/api/health', {
                method: 'GET',
                credentials: 'include'
            }).catch(() => {
                console.log('Session ping failed');
            });
        }, 15 * 60 * 1000);
    },

    // Initialize tooltips
    initializeTooltips: function() {
        // Initialize Bootstrap tooltips if available
        if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
            document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(element => {
                new bootstrap.Tooltip(element);
            });
        }
    },

    // Initialize modals
    initializeModals: function() {
        // Custom modal handling if needed
        document.querySelectorAll('[data-toggle="modal"]').forEach(trigger => {
            trigger.addEventListener('click', function(e) {
                e.preventDefault();
                const target = this.getAttribute('data-target');
                if (target) {
                    ForumApp.showModal(target);
                }
            });
        });
    },

    // Initialize textareas with auto-resize
    initializeTextareas: function() {
        document.querySelectorAll('textarea').forEach(textarea => {
            this.setupAutoResize(textarea);
            this.loadFromLocalStorage(textarea);
        });
    },

    // Auto-resize textarea
    setupAutoResize: function(textarea) {
        const resize = () => {
            textarea.style.height = 'auto';
            textarea.style.height = textarea.scrollHeight + 'px';
        };

        textarea.addEventListener('input', resize);
        textarea.addEventListener('focus', resize);

        // Initial resize
        setTimeout(resize, 100);
    },

    // Initialize character counters
    initializeCounters: function() {
        document.querySelectorAll('[data-counter]').forEach(element => {
            this.setupCharacterCounter(element);
        });
    },

    // Initialize lazy loading
    initializeLazyLoading: function() {
        if ('IntersectionObserver' in window) {
            const lazyImages = document.querySelectorAll('img[data-lazy]');
            const imageObserver = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const img = entry.target;
                        img.src = img.dataset.lazy;
                        img.classList.remove('lazy');
                        imageObserver.unobserve(img);
                    }
                });
            });

            lazyImages.forEach(img => imageObserver.observe(img));
        }
    },

    // Start auto-save timer
    startAutoSave: function() {
        setInterval(() => {
            document.querySelectorAll('textarea').forEach(textarea => {
                if (textarea.value && textarea.value.length > 10) {
                    this.saveToLocalStorage(textarea);
                }
            });
        }, this.config.autoSaveInterval);
    },

    // Utility functions
    showLoading: function(element) {
        if (!element) return;

        const originalText = element.innerHTML;
        element.dataset.originalText = originalText;
        element.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Loading...';
        element.disabled = true;
    },

    hideLoading: function(element) {
        if (!element) return;

        const originalText = element.dataset.originalText;
        if (originalText) {
            element.innerHTML = originalText;
        }
        element.disabled = false;
    },

    // Show toast notification
    showToast: function(message, type = 'info') {
        const toast = document.createElement('div');
        toast.className = `toast align-items-center text-white bg-${type} border-0`;
        toast.setAttribute('role', 'alert');
        toast.innerHTML = `
            <div class="d-flex">
                <div class="toast-body">${message}</div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto"
                        data-bs-dismiss="toast"></button>
            </div>
        `;

        // Add to toast container or create one
        let container = document.querySelector('.toast-container');
        if (!container) {
            container = document.createElement('div');
            container.className = 'toast-container position-fixed top-0 end-0 p-3';
            document.body.appendChild(container);
        }

        container.appendChild(toast);

        // Show toast
        if (typeof bootstrap !== 'undefined' && bootstrap.Toast) {
            const bsToast = new bootstrap.Toast(toast);
            bsToast.show();
        } else {
            toast.style.display = 'block';
            setTimeout(() => {
                toast.remove();
            }, 3000);
        }
    },

    // Show modal
    showModal: function(selector) {
        const modal = document.querySelector(selector);
        if (modal) {
            if (typeof bootstrap !== 'undefined' && bootstrap.Modal) {
                const bsModal = new bootstrap.Modal(modal);
                bsModal.show();
            } else {
                modal.style.display = 'block';
                modal.classList.add('show');
            }
        }
    },

    // Debounce function
    debounce: function(func, wait) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func(...args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    },

    // Throttle function
    throttle: function(func, limit) {
        let inThrottle;
        return function() {
            const args = arguments;
            const context = this;
            if (!inThrottle) {
                func.apply(context, args);
                inThrottle = true;
                setTimeout(() => inThrottle = false, limit);
            }
        };
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

    // Format time ago
    timeAgo: function(date) {
        const now = new Date();
        const diff = now - new Date(date);
        const seconds = Math.floor(diff / 1000);
        const minutes = Math.floor(seconds / 60);
        const hours = Math.floor(minutes / 60);
        const days = Math.floor(hours / 24);

        if (days > 0) return `${days} day${days > 1 ? 's' : ''} ago`;
        if (hours > 0) return `${hours} hour${hours > 1 ? 's' : ''} ago`;
        if (minutes > 0) return `${minutes} minute${minutes > 1 ? 's' : ''} ago`;
        return 'Just now';
    },

    // Escape HTML
    escapeHtml: function(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    },

    // Copy to clipboard
    copyToClipboard: function(text) {
        if (navigator.clipboard) {
            navigator.clipboard.writeText(text).then(() => {
                this.showToast('Copied to clipboard', 'success');
            });
        } else {
            // Fallback for older browsers
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
    },

    // Smooth scroll to element
    scrollTo: function(element, offset = 0) {
        if (typeof element === 'string') {
            element = document.querySelector(element);
        }

        if (element) {
            const elementPosition = element.getBoundingClientRect().top;
            const offsetPosition = elementPosition + window.pageYOffset - offset;

            window.scrollTo({
                top: offsetPosition,
                behavior: 'smooth'
            });
        }
    },

    // Check if element is in viewport
    isInViewport: function(element) {
        const rect = element.getBoundingClientRect();
        return (
            rect.top >= 0 &&
            rect.left >= 0 &&
            rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
            rect.right <= (window.innerWidth || document.documentElement.clientWidth)
        );
    },

    // API helper functions
    api: {
        // Make API request
        request: function(url, options = {}) {
            const defaultOptions = {
                headers: {
                    'Content-Type': 'application/json',
                    'X-Requested-With': 'XMLHttpRequest'
                },
                credentials: 'include'
            };

            return fetch(url, { ...defaultOptions, ...options })
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`HTTP error! status: ${response.status}`);
                    }
                    return response.json();
                })
                .catch(error => {
                    console.error('API request failed:', error);
                    ForumApp.showToast('Request failed', 'error');
                    throw error;
                });
        },

        // Get topics
        getTopics: function() {
            return this.request('/forum-app/api/topics');
        },

        // Get topic by ID
        getTopic: function(id) {
            return this.request(`/forum-app/api/topics/${id}`);
        },

        // Create topic
        createTopic: function(data) {
            return this.request('/forum-app/api/topics', {
                method: 'POST',
                body: JSON.stringify(data)
            });
        },

        // Get comments for topic
        getComments: function(topicId) {
            return this.request(`/forum-app/api/comments?topicId=${topicId}`);
        },

        // Create comment
        createComment: function(data) {
            return this.request('/forum-app/api/comments', {
                method: 'POST',
                body: JSON.stringify(data)
            });
        }
    }
};

// Initialize when DOM is ready
document.addEventListener('DOMContentLoaded', function() {
    ForumApp.init();
});

// Global error handler
window.addEventListener('error', function(event) {
    console.error('JavaScript error:', event.error);
    ForumApp.showToast('An error occurred', 'error');
});

// Handle unhandled promise rejections
window.addEventListener('unhandledrejection', function(event) {
    console.error('Unhandled promise rejection:', event.reason);
    ForumApp.showToast('Request failed', 'error');
});

// Export for use in other scripts
window.ForumApp = ForumApp;