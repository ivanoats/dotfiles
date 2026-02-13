#!/usr/bin/env zsh
# Comprehensive test script for zshrc configuration
# Tests compatibility on Ubuntu 24.04.3 LTS

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║  ZSH Configuration Test Suite for Ubuntu 24.04.3 LTS         ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

TESTS_PASSED=0
TESTS_FAILED=0
WARNINGS=0

# Test 1: Check OS version
echo "📋 Test 1: Checking OS Version"
if grep -q "Ubuntu 24.04" /etc/os-release 2>/dev/null; then
    echo "   ${GREEN}✓${NC} Running on Ubuntu 24.04.3 LTS"
    ((TESTS_PASSED++))
else
    echo "   ${YELLOW}⚠${NC} Not running on Ubuntu 24.04 (but continuing tests)"
    ((WARNINGS++))
fi
echo ""

# Test 2: Check zsh installation
echo "📋 Test 2: Checking zsh Installation"
if command -v zsh &> /dev/null; then
    ZSH_VERSION_INFO=$(zsh --version)
    echo "   ${GREEN}✓${NC} zsh is installed: $ZSH_VERSION_INFO"
    ((TESTS_PASSED++))
else
    echo "   ${RED}✗${NC} zsh is not installed"
    ((TESTS_FAILED++))
    exit 1
fi
echo ""

# Test 3: Check zshrc syntax
echo "📋 Test 3: Validating zshrc Syntax"
cd ~/dotfiles 2>/dev/null || cd /home/runner/work/dotfiles/dotfiles
if zsh -n zshrc 2>&1; then
    echo "   ${GREEN}✓${NC} zshrc syntax is valid"
    ((TESTS_PASSED++))
else
    echo "   ${RED}✗${NC} zshrc has syntax errors"
    ((TESTS_FAILED++))
fi
echo ""

# Test 4: Check required files exist
echo "📋 Test 4: Checking Required Files"
REQUIRED_FILES=(
    "zshrc"
    "zsh/env"
    "zsh/aliases"
    "zsh/zshenv"
    "zsh/zsh_plugins.txt"
    "zsh/functions/auto-switch-node-version"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [[ -f "$file" ]]; then
        echo "   ${GREEN}✓${NC} $file exists"
        ((TESTS_PASSED++))
    else
        echo "   ${RED}✗${NC} $file is missing"
        ((TESTS_FAILED++))
    fi
done
echo ""

# Test 5: Check private_keys handling
echo "📋 Test 5: Checking Private Keys Setup"
if [[ -f "zsh/private_keys.template" ]]; then
    echo "   ${GREEN}✓${NC} private_keys.template exists"
    ((TESTS_PASSED++))
else
    echo "   ${RED}✗${NC} private_keys.template is missing"
    ((TESTS_FAILED++))
fi

if [[ -f "zsh/private_keys" ]]; then
    echo "   ${GREEN}✓${NC} private_keys file exists (created from template)"
    ((TESTS_PASSED++))
else
    echo "   ${YELLOW}⚠${NC} private_keys doesn't exist (will be created from template)"
    ((WARNINGS++))
fi
echo ""

# Test 6: Check for macOS-only commands without proper guards
echo "📋 Test 6: Checking for Unguarded macOS-Specific Commands"
ISSUES=0

# Check for brew without guards (but inside command -v brew blocks is OK)
if grep -n "brew --prefix\|brew info" zshrc | grep -v "command -v brew" | grep -v "if.*brew"; then
    echo "   ${YELLOW}⚠${NC} Found potentially unguarded brew commands (review manually)"
    ((WARNINGS++))
    ISSUES=1
fi

if [[ $ISSUES -eq 0 ]]; then
    echo "   ${GREEN}✓${NC} No unguarded macOS-specific commands found"
    ((TESTS_PASSED++))
fi
echo ""

# Test 7: Check for OS-specific conditionals
echo "📋 Test 7: Verifying OS-Specific Conditionals"
if grep -q "OSTYPE_REAL.*darwin" zshrc && grep -q "OSTYPE_REAL.*linux-gnu" zshrc; then
    echo "   ${GREEN}✓${NC} OS-specific conditionals present"
    ((TESTS_PASSED++))
else
    echo "   ${RED}✗${NC} OS-specific conditionals missing"
    ((TESTS_FAILED++))
fi
echo ""

# Test 8: Check for existence checks on sourced files
echo "📋 Test 8: Checking File Existence Guards"
UNGUARDED=0

# Check if sourcing operations have guards
if grep -E "^\s*source [^|]" zshrc | grep -v "\[\[.*-f\|if.*-f\|if.*-s\|test -f\|test -e" > /dev/null 2>&1; then
    echo "   ${YELLOW}⚠${NC} Some source commands may lack existence checks"
    ((WARNINGS++))
    UNGUARDED=1
fi

if grep -E "^\s*\. .*zsh/(env|aliases|private_keys)" zshrc | grep -v "\[\[.*-f" > /dev/null 2>&1; then
    echo "   ${YELLOW}⚠${NC} Some dot-sourcing commands may lack existence checks"
    ((WARNINGS++))
    UNGUARDED=1
fi

if [[ $UNGUARDED -eq 0 ]]; then
    echo "   ${GREEN}✓${NC} Source commands have proper guards"
    ((TESTS_PASSED++))
fi
echo ""

# Test 9: Test NVM path detection
echo "📋 Test 9: Checking NVM Configuration"
if grep -q "NVM_DIR.*nvm.sh" zshrc && grep -q 'OSTYPE_REAL.*darwin.*homebrew.*nvm' zshrc; then
    echo "   ${GREEN}✓${NC} NVM configuration supports both macOS and Linux"
    ((TESTS_PASSED++))
else
    echo "   ${RED}✗${NC} NVM configuration may not support both platforms"
    ((TESTS_FAILED++))
fi
echo ""

# Test 10: Test pnpm path configuration
echo "📋 Test 10: Checking pnpm Path Configuration"
if grep -q "PNPM_HOME.*Library.*darwin" zshrc && grep -q "PNPM_HOME.*local/share" zshrc; then
    echo "   ${GREEN}✓${NC} pnpm paths configured for both macOS and Linux"
    ((TESTS_PASSED++))
else
    echo "   ${YELLOW}⚠${NC} pnpm paths may not be optimal for both platforms"
    ((WARNINGS++))
fi
echo ""

# Test 11: Check for antidote guard
echo "📋 Test 11: Checking Plugin Manager Guards"
if grep -q "if.*antidote.zsh.*then" zshrc; then
    echo "   ${GREEN}✓${NC} Antidote loading has existence check"
    ((TESTS_PASSED++))
else
    echo "   ${RED}✗${NC} Antidote loading lacks existence check"
    ((TESTS_FAILED++))
fi
echo ""

# Test 12: Check fzf and zoxide guards
echo "📋 Test 12: Checking Tool Integration Guards"
if grep -q "command -v fzf" zshrc && grep -q "command -v zoxide" zshrc; then
    echo "   ${GREEN}✓${NC} fzf and zoxide have command checks"
    ((TESTS_PASSED++))
else
    echo "   ${RED}✗${NC} Missing command checks for fzf or zoxide"
    ((TESTS_FAILED++))
fi
echo ""

# Test 13: Simulate sourcing zshrc
echo "📋 Test 13: Testing zshrc Loading (Dry Run)"
# Create a minimal test environment
TEST_OUTPUT=$(ZSH_DISABLE_COMPFIX=true ZDOTDIR=$(pwd) zsh -c 'source zshrc 2>&1' 2>&1 | head -20)
if echo "$TEST_OUTPUT" | grep -i "error.*fatal\|No such file.*required" > /dev/null; then
    echo "   ${RED}✗${NC} Critical errors when loading zshrc:"
    echo "$TEST_OUTPUT" | grep -i "error\|fatal" | head -5
    ((TESTS_FAILED++))
else
    echo "   ${GREEN}✓${NC} zshrc loads without critical errors"
    ((TESTS_PASSED++))
fi
echo ""

# Summary
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║                        TEST SUMMARY                           ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
echo "Tests Passed:  ${GREEN}$TESTS_PASSED${NC}"
echo "Tests Failed:  ${RED}$TESTS_FAILED${NC}"
echo "Warnings:      ${YELLOW}$WARNINGS${NC}"
echo ""

if [[ $TESTS_FAILED -eq 0 ]]; then
    echo "${GREEN}✓ All critical tests passed!${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Install antidote: git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote"
    echo "2. Copy private_keys template: cp zsh/private_keys.template zsh/private_keys"
    echo "3. Install optional tools: fzf, zoxide, eza, bat, fd, ripgrep"
    echo "4. Run: zsh -c 'source ~/dotfiles/zshrc' to test full loading"
    exit 0
else
    echo "${RED}✗ Some tests failed. Please review and fix the issues above.${NC}"
    exit 1
fi
