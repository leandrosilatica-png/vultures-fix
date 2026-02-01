# 📦 What to Install - Visual Guide

## The Simple Answer

**Drag and drop THESE TWO things into your Darktide mods folder:**

```
📁 Your Download Folder          →    📁 Darktide Mods Folder
├── vultures_dodge_tracker.mod  →    %AppData%\Fatshark\Darktide\mods\
├── scripts/                     →    %AppData%\Fatshark\Darktide\mods\
├── README.md (don't copy)
├── INSTALL.md (don't copy)
└── ... (other docs - don't copy)
```

## Visual Installation Steps

### Step 1: Open Your Mods Folder
```
Press: Windows Key + R
Type:  %AppData%\Fatshark\Darktide\mods
Press: Enter
```

### Step 2: Drag These Files
```
FROM the downloaded repository:
  ✅ vultures_dodge_tracker.mod
  ✅ scripts/ (folder)

TO the mods folder you just opened
```

### Step 3: Final Result
Your mods folder should now contain:
```
📁 %AppData%\Fatshark\Darktide\mods\
   ├── vultures_dodge_tracker.mod  ✅ (this file)
   ├── scripts\                     ✅ (this folder)
   │   └── mods\
   │       └── vultures_dodge_tracker\
   │           ├── vultures_dodge_tracker.lua
   │           ├── vultures_dodge_tracker_data.lua
   │           └── vultures_dodge_tracker_localization.lua
   └── [your other mods...]
```

## Common Mistakes to Avoid

❌ **DON'T** copy the entire repository folder
❌ **DON'T** copy README.md, INSTALL.md, LICENSE, etc.
❌ **DON'T** create a subfolder called "vultures-fix" in mods

✅ **DO** copy just the .mod file and scripts folder
✅ **DO** put them directly in the mods folder
✅ **DO** keep the scripts folder structure intact

## Quick Check

After installation, you should be able to navigate to:
```
%AppData%\Fatshark\Darktide\mods\scripts\mods\vultures_dodge_tracker\
```

If this folder exists with .lua files inside, you installed it correctly! 🎉

## Still Confused?

If you see this in your repository download:
- `vultures_dodge_tracker.mod` ← Copy this
- `scripts/` ← Copy this entire folder
- Everything else (README, INSTALL, etc.) ← Leave these

Both items go **directly** into `%AppData%\Fatshark\Darktide\mods\`

Not into a subfolder, not renamed, just drag and drop those two items.
