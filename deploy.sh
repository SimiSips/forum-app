#!/bin/bash

# Forum Application Deployment Script
# Automates the build and deployment process to Tomcat
# Author: Simphiwe Radebe

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
APP_NAME="forum-app"
WAR_FILE="target/${APP_NAME}.war"

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if CATALINA_HOME is set
check_catalina_home() {
    if [ -z "$CATALINA_HOME" ]; then
        print_error "CATALINA_HOME environment variable is not set!"
        print_error "Please set CATALINA_HOME to your Tomcat installation directory."
        print_error "Example: export CATALINA_HOME=/usr/local/tomcat"
        exit 1
    fi

    if [ ! -d "$CATALINA_HOME" ]; then
        print_error "CATALINA_HOME directory does not exist: $CATALINA_HOME"
        exit 1
    fi

    print_success "CATALINA_HOME is set to: $CATALINA_HOME"
}

# Function to check if Maven is available
check_maven() {
    if ! command -v mvn &> /dev/null; then
        print_error "Maven is not installed or not in PATH!"
        print_error "Please install Maven and ensure it's in your PATH."
        exit 1
    fi

    print_success "Maven is available: $(mvn --version | head -n 1)"
}

# Function to clean and build the project
build_project() {
    print_status "Starting Maven build process..."

    # Clean previous builds
    print_status "Cleaning previous builds..."
    mvn clean

    # Compile the project
    print_status "Compiling project..."
    mvn compile

    # Package into WAR file
    print_status "Packaging into WAR file..."
    mvn package

    # Check if WAR file was created
    if [ ! -f "$WAR_FILE" ]; then
        print_error "WAR file was not created: $WAR_FILE"
        exit 1
    fi

    print_success "Build completed successfully!"
    print_success "WAR file created: $WAR_FILE"
}

# Function to deploy to Tomcat
deploy_to_tomcat() {
    print_status "Deploying to Tomcat..."

    # Remove existing deployment
    print_status "Removing existing deployment..."
    rm -rf "$CATALINA_HOME/webapps/${APP_NAME}"*

    # Copy new WAR file
    print_status "Copying WAR file to Tomcat webapps..."
    cp "$WAR_FILE" "$CATALINA_HOME/webapps/"

    print_success "Deployment completed!"
    print_success "WAR file deployed to: $CATALINA_HOME/webapps/"
}

# Function to check Tomcat status
check_tomcat_status() {
    if pgrep -f "catalina" > /dev/null; then
        print_success "Tomcat is running"
        return 0
    else
        print_warning "Tomcat is not running"
        return 1
    fi
}

# Function to restart Tomcat
restart_tomcat() {
    print_status "Checking Tomcat status..."

    if check_tomcat_status; then
        print_status "Stopping Tomcat..."
        "$CATALINA_HOME/bin/catalina.sh" stop

        # Wait for Tomcat to stop
        sleep 5

        # Force kill if still running
        if pgrep -f "catalina" > /dev/null; then
            print_warning "Force killing Tomcat processes..."
            pkill -f "catalina"
            sleep 2
        fi
    fi

    print_status "Starting Tomcat..."
    "$CATALINA_HOME/bin/catalina.sh" start

    print_success "Tomcat started successfully!"
}

# Function to show logs
show_logs() {
    if [ -f "$CATALINA_HOME/logs/catalina.out" ]; then
        print_status "Showing Tomcat logs (Press Ctrl+C to exit)..."
        tail -f "$CATALINA_HOME/logs/catalina.out"
    else
        print_warning "Catalina log file not found: $CATALINA_HOME/logs/catalina.out"
    fi
}

# Function to show deployment URL
show_deployment_info() {
    echo ""
    print_success "=== DEPLOYMENT COMPLETED ==="
    echo -e "${GREEN}Application URL:${NC} http://localhost:8080/${APP_NAME}/"
    echo -e "${GREEN}Tomcat Manager:${NC} http://localhost:8080/manager/html"
    echo -e "${GREEN}Logs Location:${NC} $CATALINA_HOME/logs/"
    echo ""
}

# Main deployment function
main() {
    print_status "=== Forum Application Deployment Script ==="
    print_status "Starting deployment process..."

    # Pre-flight checks
    check_catalina_home
    check_maven

    # Build the project
    build_project

    # Deploy to Tomcat
    deploy_to_tomcat

    # Restart Tomcat
    if [ "$1" != "--no-restart" ]; then
        restart_tomcat
    fi

    # Show deployment information
    show_deployment_info

    # Ask if user wants to see logs
    if [ "$1" != "--no-logs" ]; then
        echo -n "Would you like to view the logs? [y/N]: "
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            show_logs
        fi
    fi
}

# Help function
show_help() {
    echo "Forum Application Deployment Script"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --help          Show this help message"
    echo "  --no-restart    Skip Tomcat restart"
    echo "  --no-logs       Don't prompt to show logs"
    echo "  --logs-only     Only show logs (don't build/deploy)"
    echo ""
    echo "Environment Variables:"
    echo "  CATALINA_HOME   Path to Tomcat installation (required)"
    echo ""
    echo "Examples:"
    echo "  $0                    # Full deployment with restart"
    echo "  $0 --no-restart      # Deploy without restarting Tomcat"
    echo "  $0 --logs-only       # Just show the logs"
    echo ""
}

# Parse command line arguments
case "$1" in
    --help|-h)
        show_help
        exit 0
        ;;
    --logs-only)
        check_catalina_home
        show_logs
        exit 0
        ;;
    *)
        main "$@"
        ;;
esac