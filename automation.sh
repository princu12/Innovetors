#!/bin/bash

# Automation script runner
# This script manages the execution of test automation scripts

set -e

# Configuration
PLAYWRIGHT_CONFIG="playwright.config.ts"
TEST_DIR="tests"
REPORT_DIR="playwright-report"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Function to run tests
run_tests() {
    local test_pattern=$1
    echo "Running tests matching pattern: $test_pattern"
    
    npx playwright test "$test_pattern" \
        --config="$PLAYWRIGHT_CONFIG" \
        --reporter=html
}

# Function to generate report
generate_report() {
    echo -e "${GREEN}Generating test report...${NC}"
    if [ -d "$REPORT_DIR" ]; then
        echo "Report available at: $REPORT_DIR/index.html"
    else
        echo -e "${RED}Error: Report directory not found${NC}"
        exit 1
    fi
}

# Main execution
main() {
    local test_pattern=${1:-"*"}
    
    # Install dependencies if needed
    if [ ! -d "node_modules" ]; then
        echo "Installing dependencies..."
        npm install
    fi
    
    # Install browsers if needed
    npx playwright install --with-deps
    
    # Run tests
    run_tests "$test_pattern"
    
    # Generate report
    generate_report
}

# Execute main function with all arguments
main "$@"