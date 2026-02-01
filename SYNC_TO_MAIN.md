# How to Sync to Main Branch for ChatGPT Visibility

## Current Situation
All the Vulture's Dodge Tracker mod work is currently on the `copilot/add-vultures-dodge-tracker` branch. To make it visible to ChatGPT and other GitHub AI services, you need to merge this into the `main` branch.

## What Has Been Created
This repository now contains a complete Darktide mod with:
- ✅ Mod files: `vultures_dodge_tracker.mod` and `scripts/` folder
- ✅ Documentation: README.md, INSTALL.md, WHAT_TO_INSTALL.md
- ✅ Troubleshooting guides: DEBUG_GUIDE.md, ASSUMPTIONS.md, QUICK_START.md
- ✅ License: MIT License

## To Make This Visible to ChatGPT (Manual Steps Required)

Since I don't have push permissions to create a main branch directly, you'll need to do one of these:

### Option 1: Merge via GitHub Web Interface (Easiest)

1. Go to: https://github.com/leandrosilatica-png/vultures-fix
2. Click on "Pull requests" tab
3. Click "New pull request"
4. Set:
   - Base: `main` (create it if it doesn't exist)
   - Compare: `copilot/add-vultures-dodge-tracker`
5. Click "Create pull request"
6. Add title: "Add Vulture's Dodge Tracker Mod"
7. Click "Create pull request"
8. Click "Merge pull request"
9. Confirm merge

### Option 2: Set Default Branch (Simplest)

If you just want ChatGPT to see the current work:

1. Go to: https://github.com/leandrosilatica-png/vultures-fix/settings
2. Click "Branches" in the left sidebar
3. Under "Default branch", click the switch icon
4. Select `copilot/add-vultures-dodge-tracker` as the default branch
5. Click "Update"

This makes the feature branch the main one that ChatGPT will read.

### Option 3: Via Command Line (If You Have Access)

```bash
git checkout copilot/add-vultures-dodge-tracker
git checkout -b main
git push -u origin main
```

Then set it as the default branch in GitHub settings.

## What This Accomplishes

Once on the main/default branch:
- ✅ ChatGPT can read all documentation files
- ✅ Other GitHub AI services can access the code
- ✅ The repository appears more official/complete
- ✅ Direct links work better for sharing

## Files Available After Merge

All these will be visible to AI services:

**Core Mod Files:**
- `vultures_dodge_tracker.mod` - Mod definition
- `scripts/mods/vultures_dodge_tracker/*.lua` - Mod logic, settings, localization

**User Documentation:**
- `README.md` - Overview and quick start
- `INSTALL.md` - Detailed installation guide
- `WHAT_TO_INSTALL.md` - Visual installation guide
- `QUICK_START.md` - Quick debugging reference

**Developer Documentation:**
- `ASSUMPTIONS.md` - Implementation uncertainties
- `DEBUG_GUIDE.md` - Comprehensive troubleshooting
- `IMPLEMENTATION_SUMMARY.md` - Technical overview

**Legal:**
- `LICENSE` - MIT License

## Current Branch Status

Branch: `copilot/add-vultures-dodge-tracker`
Commits: 11+ commits with full mod implementation
Status: ✅ Complete and ready to merge
