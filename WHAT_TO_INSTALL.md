# 📦 What to Install - Visual Guide

## 📍 Where is the Mods Folder?

**The mods folder is in your Darktide game installation directory, NOT in AppData!**

### Find Your Mods Folder:

**Method 1: Through Steam (Easiest)**
1. Open Steam
2. Right-click "Warhammer 40,000: Darktide" in your library
3. Select "Properties" → "Installed Files" → "Browse"
4. Look for the `mods` folder here

**Method 2: Default Path**
```
C:\Program Files (x86)\Steam\steamapps\common\Warhammer 40,000 DARKTIDE\mods
```

### ⚠️ Mods Folder Doesn't Exist?

**If the `mods` folder doesn't exist in your game directory:**

1. **Install Darktide Mod Framework (DMF) First** ⭐ REQUIRED
   - Go to: https://github.com/Darktide-Mod-Framework/Darktide-Mod-Framework
   - Download and install DMF
   - DMF will create the mods folder

2. **Or Create It Manually**
   - Navigate to your game folder (see above)
   - Create a new folder called `mods`
   - But you still need DMF for mods to work!

---

## The Simple Answer

**Drag and drop THESE TWO things into your Darktide mods folder:**

```
📁 Your Download Folder          →    📁 Darktide Game Install Folder
├── vultures_dodge_tracker.mod  →    [Game]\Warhammer 40,000 DARKTIDE\mods\
├── scripts/                     →    [Game]\Warhammer 40,000 DARKTIDE\mods\
├── README.md (don't copy)
├── INSTALL.md (don't copy)
└── ... (other docs - don't copy)
```

**Example full path:**
```
C:\Program Files (x86)\Steam\steamapps\common\Warhammer 40,000 DARKTIDE\mods\
```

## Visual Installation Steps

### Step 1: Open Your Mods Folder
```
Option A - Through Steam (Recommended):
1. Open Steam
2. Right-click "Warhammer 40,000: Darktide"
3. Properties → Installed Files → Browse
4. Look for the "mods" folder

Option B - Direct Path:
Navigate to: C:\Program Files (x86)\Steam\steamapps\common\Warhammer 40,000 DARKTIDE\mods
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
📁 [Game Install]\Warhammer 40,000 DARKTIDE\mods\
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
[Game Install]\Warhammer 40,000 DARKTIDE\mods\scripts\mods\vultures_dodge_tracker\
```

Example:
```
C:\Program Files (x86)\Steam\steamapps\common\Warhammer 40,000 DARKTIDE\mods\scripts\mods\vultures_dodge_tracker\
```

If this folder exists with .lua files inside, you installed it correctly! 🎉

## Still Confused?

If you see this in your repository download:
- `vultures_dodge_tracker.mod` ← Copy this
- `scripts/` ← Copy this entire folder
- Everything else (README, INSTALL, etc.) ← Leave these

Both items go **directly** into your game's mods folder:
```
[Game Install]\Warhammer 40,000 DARKTIDE\mods\
```

Not into a subfolder, not renamed, just drag and drop those two items.

---

## Troubleshooting: Can't Find Mods Folder?

### Problem: "I can't find my game installation folder!"

**Solution 1: Use Steam to Find It (Easiest)**
1. Open Steam
2. Right-click "Warhammer 40,000: Darktide"
3. Click "Properties"
4. Go to "Installed Files" tab
5. Click "Browse"
6. This opens your game folder - the mods folder should be here

**Solution 2: Common Install Locations**

Default Steam:
```
C:\Program Files (x86)\Steam\steamapps\common\Warhammer 40,000 DARKTIDE\mods
```

Custom Steam Library:
```
[Your Drive]:\SteamLibrary\steamapps\common\Warhammer 40,000 DARKTIDE\mods
```

Microsoft Store Version:
```
C:\Users\[YourUsername]\AppData\Local\Packages\FatsharkAB.Warhammer40000Darktide_[random]\LocalCache\Local\Fatshark\Darktide\mods
```

### Problem: "The mods folder doesn't exist in my game directory!"

**Solution: Install DMF or Create the Folder**
1. Install Darktide Mod Framework: https://github.com/Darktide-Mod-Framework/Darktide-Mod-Framework
2. Or manually create a `mods` folder in your game directory
3. But you MUST have DMF installed for mods to work!

### Problem: "I have the Microsoft Store version"

**Solution: Different Path**
Microsoft Store version uses a different location (in AppData). Use the Steam method to browse to your game files, or check the path listed above.

