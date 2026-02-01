# 📦 What to Install - Visual Guide

## ⚠️ STOP! Mods Folder Doesn't Exist?

**If you can't find `%AppData%\Fatshark\Darktide\mods`, you need to install DMF first!**

### Install Darktide Mod Framework (DMF) First:
1. Go to: https://github.com/Darktide-Mod-Framework/Darktide-Mod-Framework
2. Download and install DMF
3. Launch Darktide ONCE (this creates the mods folder)
4. Then come back here

**Without DMF, mods won't work - it's required!**

---

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

---

## Troubleshooting: Can't Find Mods Folder?

### Problem: "The mods folder doesn't exist in AppData!"

**Solution 1: Install DMF First (Most Common)**
- You need Darktide Mod Framework installed
- Download from: https://github.com/Darktide-Mod-Framework/Darktide-Mod-Framework
- Launch the game once after installing DMF
- The mods folder will be created automatically

**Solution 2: Create It Manually**
If DMF is installed but folder still missing:
1. Press `Win + R`
2. Type `%AppData%\Fatshark\Darktide`
3. Press Enter
4. Right-click → New → Folder → name it `mods`

**Solution 3: Check Alternative Locations**

Microsoft Store version:
```
C:\Users\[YourUsername]\AppData\Local\Packages\FatsharkAB.Warhammer40000Darktide_[random]\LocalCache\Local\Fatshark\Darktide\mods
```

Look where DMF installed - your mods folder is in the same location.

### Problem: "I don't have DMF"

**You MUST install Darktide Mod Framework first!**
- This mod (and all Darktide mods) require DMF to work
- Get it here: https://github.com/Darktide-Mod-Framework/Darktide-Mod-Framework
- Install DMF → Launch game once → Then install this mod

### Problem: "AppData folder is hidden"

1. Open File Explorer
2. Click "View" tab
3. Check "Hidden items"
4. Now you can navigate to AppData

