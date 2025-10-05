# GitHub Actions Extension Guide

The GitHub Actions extension (`github.vscode-github-actions`) is now integrated into your dev container, providing seamless workflow management directly from VS Code.

## Getting Started

### 1. **Authentication**
- The extension will prompt you to authenticate with GitHub
- Use your GitHub account credentials
- Grant necessary permissions for workflow management

### 2. **Accessing Workflows**
- **Sidebar**: Look for the GitHub Actions icon in the Activity Bar
- **Command Palette**: `Ctrl+Shift+P` → "GitHub Actions: Show Workflows"
- **Status Bar**: Shows current workflow status

## Key Features

### 🔄 **Workflow Management**

#### **Pin Workflows:**
- Right-click on `.github/workflows/ci.yml`
- Select "Pin Workflow"
- Quick access from the sidebar

#### **Re-run Workflows:**
- Click the refresh icon next to failed workflows
- Re-run specific jobs or entire workflows
- Useful for debugging CI issues

#### **Cancel Workflows:**
- Stop running workflows with one click
- Prevents resource waste on broken builds

### 📊 **Real-time Monitoring**

#### **Workflow Status:**
- **Green**: ✅ Successful
- **Red**: ❌ Failed
- **Yellow**: ⏳ Running
- **Gray**: ⏸️ Cancelled

#### **Auto-refresh:**
- Updates every 30 seconds (configurable)
- Real-time status in sidebar
- Push notifications for status changes

### 📋 **Log Integration**

#### **View Logs:**
- Click on any workflow step
- Logs open in VS Code terminal
- Syntax highlighting for better readability

#### **Log Features:**
- **Search** within logs
- **Copy** log sections
- **Download** complete logs
- **Navigate** between steps

### 📦 **Artifact Management**

#### **Download Artifacts:**
- Right-click on workflow runs
- Select "Download Artifacts"
- Artifacts saved to local workspace

#### **Browse Artifacts:**
- View artifact contents in VS Code
- Access Valgrind reports locally
- Inspect build outputs

## Configuration

### **Settings Added to devcontainer.json:**

```json
{
    "github-actions.workflows.pinned": [
        ".github/workflows/ci.yml"
    ],
    "github-actions.workflows.showLogs": true,
    "github-actions.workflows.refreshInterval": 30
}
```

### **Customization Options:**

#### **Pin Additional Workflows:**
```json
"github-actions.workflows.pinned": [
    ".github/workflows/ci.yml",
    ".github/workflows/deploy.yml",
    ".github/workflows/test.yml"
]
```

#### **Adjust Refresh Rate:**
```json
"github-actions.workflows.refreshInterval": 60  // seconds
```

#### **Enable/Disable Logs:**
```json
"github-actions.workflows.showLogs": false
```

## Workflow Development

### **YAML IntelliSense:**
- **Auto-completion** for GitHub Actions syntax
- **Validation** of workflow structure
- **Error highlighting** for invalid YAML

### **Quick Actions:**
- **Insert workflow** templates
- **Add common steps** (build, test, deploy)
- **Validate** workflow syntax

### **Integration with Git:**
- **Commit and push** workflow changes
- **Create pull requests** with workflow updates
- **Review** workflow changes in diff view

## Troubleshooting

### **Authentication Issues:**
1. Sign out: `Ctrl+Shift+P` → "GitHub Actions: Sign Out"
2. Sign in again: `Ctrl+Shift+P` → "GitHub Actions: Sign In"
3. Check GitHub token permissions

### **Workflow Not Showing:**
1. Ensure `.github/workflows/` directory exists
2. Check YAML syntax validity
3. Refresh the extension: `Ctrl+Shift+P` → "Developer: Reload Window"

### **Performance Issues:**
1. Increase refresh interval: `"refreshInterval": 60`
2. Disable auto-refresh: `"showLogs": false`
3. Pin only essential workflows

## Best Practices

### **Workflow Organization:**
- **Pin frequently used** workflows
- **Use descriptive names** for workflow files
- **Group related** workflows in folders

### **Development Workflow:**
1. **Edit** workflow files in VS Code
2. **Validate** syntax before committing
3. **Test** workflows on feature branches
4. **Monitor** execution in real-time
5. **Download artifacts** for local inspection

### **CI/CD Integration:**
- **Monitor builds** during development
- **Debug failures** using integrated logs
- **Re-run** workflows after fixes
- **Download artifacts** for analysis

## Example Usage

### **Daily Development:**
1. **Open** GitHub Actions sidebar
2. **Check** workflow status
3. **View logs** for any failures
4. **Download artifacts** if needed
5. **Re-run** workflows after fixes

### **Debugging CI Issues:**
1. **Click** on failed workflow
2. **Expand** failed step
3. **View logs** in VS Code
4. **Identify** the issue
5. **Fix** and commit changes
6. **Re-run** workflow

The GitHub Actions extension transforms your VS Code into a complete CI/CD management environment! 🚀
