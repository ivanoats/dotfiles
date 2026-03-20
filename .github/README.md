# GitHub Actions for Dotfiles Repository

This directory contains automated workflows for maintaining and testing the dotfiles repository.

## 📋 Workflows

### Core CI/CD

#### 🧪 CI - Test Shell Configuration (`ci.yml`)
**Triggers:** Push to main/master, Pull Requests, Manual
- Tests ZSH configuration syntax on Ubuntu and macOS
- Runs comprehensive test suite (`test-zsh-config.sh`)
- Validates Bash configuration syntax
- Runs shellcheck on all shell scripts for quality assurance

**Why it's useful for Netlify:**
- Ensures documentation site won't break due to configuration errors
- Validates examples in documentation are syntactically correct
- Catches issues before they reach production

#### 📝 Markdown Linting (`markdown-lint.yml`)
**Triggers:** Changes to `.md` files, Manual
- Lints all markdown files for consistency and formatting
- Checks all links in documentation to prevent dead links
- Runs spell check on documentation

**Why it's useful for Netlify:**
- Maintains professional documentation quality on your site
- Prevents broken links that hurt user experience and SEO
- Catches typos before they're published

#### 🔒 Security Scanning (`security.yml`)
**Triggers:** Push, Pull Requests, Weekly schedule, Manual
- Scans for accidentally committed secrets using TruffleHog
- Runs security-focused shellcheck analysis
- Weekly automated scans to catch new vulnerabilities

**Why it's useful for Netlify:**
- Prevents accidental exposure of API keys or credentials
- Critical for public repositories
- Automated weekly checks ensure ongoing security

### Automation & Maintenance

#### 🏷️ Auto Label PRs (`label.yml`)
**Triggers:** Pull Request events
- Automatically labels PRs based on changed files
- Labels include: documentation, zsh, bash, neovim, vim, git, tmux, scripts, ci, dependencies

**Why it's useful for Netlify:**
- Organizes contributions automatically
- Makes it easier to track what changed
- Improves project management

#### 🧹 Close Stale Issues (`stale.yml`)
**Triggers:** Daily schedule, Manual
- Marks issues/PRs stale after 60 days of inactivity
- Closes them 7 days later
- Exempts pinned, security, and help-wanted items

**Why it's useful for Netlify:**
- Keeps issue tracker clean and manageable
- Focuses attention on active issues
- Automated maintenance reduces manual work

#### 🌐 Netlify Deploy Status (`netlify-status.yml`)
**Triggers:** Deployment status changes
- Reports deployment success/failure
- Comments on PRs with preview URLs
- Provides quick access to deployed previews

**Why it's useful for Netlify:**
- Direct feedback on deployment status in GitHub
- Easy access to preview deployments for reviews
- Improves review workflow

#### 🔄 Dependabot (`dependabot.yml`)
**Schedule:** Weekly (Monday 9:00 AM UTC)
- Updates GitHub Actions dependencies automatically
- Creates PRs for updates with proper labels
- Monitors git submodules

**Why it's useful for Netlify:**
- Keeps GitHub Actions up-to-date with security patches
- Reduces technical debt
- Automated, no manual intervention needed

## 🎯 Benefits for Netlify-Hosted Repository

### 1. **Documentation Quality**
- Markdown linting ensures professional-looking docs
- Link checking prevents 404 errors on your site
- Spell checking maintains credibility

### 2. **Continuous Integration**
- Every change is tested before deployment
- Prevents broken configurations from reaching production
- Catches cross-platform issues early

### 3. **Security First**
- Automated secret scanning prevents credential leaks
- Weekly security checks catch new issues
- Shell script security analysis

### 4. **Developer Experience**
- Auto-labeling organizes PRs automatically
- Deployment status visible in GitHub
- Quick access to preview deployments

### 5. **Low Maintenance**
- Automated dependency updates
- Stale issue management
- Runs on schedule without intervention

## 🔧 Configuration Files

- `.github/workflows/*.yml` - Workflow definitions
- `.github/dependabot.yml` - Dependency update configuration
- `.github/labeler.yml` - Auto-labeling rules
- `.github/markdown-link-check-config.json` - Link checker settings
- `.github/spellcheck-config.yml` - Spell check configuration
- `.github/wordlist.txt` - Custom dictionary for spell check

## 🚀 Getting Started

All workflows are enabled by default when merged to the main branch. No additional setup required!

### Manual Workflow Triggers

You can manually trigger any workflow from the GitHub Actions tab:
1. Go to Actions tab in your repository
2. Select the workflow you want to run
3. Click "Run workflow" button
4. Select branch and run

### Customization

#### Adding Words to Spell Check
Edit `.github/wordlist.txt` and add your custom terms.

#### Modifying Stale Issue Timing
Edit `.github/workflows/stale.yml` and adjust `days-before-stale` and `days-before-close`.

#### Adding New Labels
Edit `.github/labeler.yml` to add new auto-labeling rules.

## 📊 Viewing Results

- **Actions Tab:** See all workflow runs and their results
- **Pull Requests:** View checks directly on PR pages
- **Badges:** Add workflow status badges to your README

### Example Badge
```markdown
![CI Status](https://github.com/ivanoats/dotfiles/workflows/CI%20-%20Test%20Shell%20Configuration/badge.svg)
```

## 🤝 Contributing

When adding new workflows:
1. Test locally when possible
2. Use appropriate triggers (don't run on every push if not needed)
3. Add documentation to this README
4. Consider resource usage and workflow minutes
5. Use caching when appropriate

## 📚 Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Netlify Deploy Notifications](https://docs.netlify.com/site-deploys/notifications/)
- [Dependabot Documentation](https://docs.github.com/en/code-security/dependabot)

---

**Maintained with ❤️ for automated quality assurance**
