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

**Drag and drop THIS ONE FOLDER into your Darktide mods folder:**

```
📁 Your Download Folder          →    📁 Darktide Game Install Folder
└── vultures_dodge_tracker/      →    [Game]\Warhammer 40,000 DARKTIDE\mods\
    (entire folder)
    
Don't copy:
├── README.md (don't copy)
├── INSTALL.md (don't copy)
└── ... (other docs - don't copy)
```

**Example full path:**
```
C:\Program Files (x86)\Steam\steamapps\common\Warhammer 40,000 DARKTIDE\mods\vultures_dodge_tracker\
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

### Step 2: Drag the Mod Folder
```
FROM the downloaded repository:
  ✅ vultures_dodge_tracker/ (the entire folder)

TO the mods folder you just opened
```

### Step 3: Final Result
Your mods folder should now contain:
```
📁 [Game Install]\Warhammer 40,000 DARKTIDE\mods\
   └── vultures_dodge_tracker\          ✅ (this folder)
       ├── vultures_dodge_tracker.mod   ✅ (.mod file inside)
       └── scripts\                     ✅ (scripts inside)
           └── mods\
               └── vultures_dodge_tracker\
                   ├── vultures_dodge_tracker.lua
                   ├── vultures_dodge_tracker_data.lua
                   └── vultures_dodge_tracker_localization.lua
```

## Common Mistakes to Avoid

### ❌ CRITICAL ERROR: Wrong Installation Method

**DO NOT do this:**
```
❌ WRONG - Copying individual files:
mods\
├── vultures_dodge_tracker.mod   ← Don't copy files individually!
└── scripts\

❌ ALSO WRONG - Copying the entire repository:
mods\
└── vultures-fix\                 ← Don't copy the whole repo!
    ├── vultures_dodge_tracker\
    ├── README.md
    └── ...
```

**These will cause the error:**
```
[ModManager][error] Mod file is invalid or missing. 
```

**Instead, do this:**
```
✅ CORRECT - Copy the mod folder:
mods\
└── vultures_dodge_tracker\       ← The mod folder
    ├── vultures_dodge_tracker.mod
    └── scripts\
        └── mods\
            └── vultures_dodge_tracker\
```

### Other Common Mistakes:

❌ **DON'T** copy individual files (the .mod file alone won't work)
❌ **DON'T** copy README.md, INSTALL.md, LICENSE, etc.  
❌ **DON'T** copy the entire downloaded/cloned repository folder
❌ **DON'T** create extra subfolders

✅ **DO** copy the vultures_dodge_tracker folder (the whole thing)
✅ **DO** put it directly in the mods folder
✅ **DO** keep the folder structure intact

## Quick Check

After installation, you should be able to navigate to:
```
[Game Install]\Warhammer 40,000 DARKTIDE\mods\vultures_dodge_tracker\
```

Example:
```
C:\Program Files (x86)\Steam\steamapps\common\Warhammer 40,000 DARKTIDE\mods\vultures_dodge_tracker\
```

Inside should be the .mod file and scripts folder. If this exists, you installed it correctly! 🎉

## Still Confused?

If you see this in your repository download:
- `vultures_dodge_tracker/` ← Copy this ENTIRE folder
- Everything else (README, INSTALL, etc.) ← Leave these

The folder goes into your game's mods folder:
```
[Game Install]\Warhammer 40,000 DARKTIDE\mods\vultures_dodge_tracker\
```

---

## 🚨 TROUBLESHOOTING: Common Errors

### Error: "Mod file is invalid or missing"

**You see this error:**
```
[Lua] [Mod] Error opening './../mods/...'
[ModManager][error] Mod file is invalid or missing.
```

**What went wrong:** You copied individual files or the wrong folder.

**How to fix:**
1. Go to your mods folder: `[Game Install]\Warhammer 40,000 DARKTIDE\mods\`
2. **DELETE** any incorrect folders or files (like `vultures-fix` or individual files)
3. Copy the **vultures_dodge_tracker** folder (the entire folder) into the mods directory
4. Launch the game again

**Visual fix:**
```
BEFORE (Wrong):
mods\
├── vultures_dodge_tracker.mod  ← Delete individual files!
└── scripts\

OR:
mods\
└── vultures-fix\                ← Delete the repo folder!
    └── vultures_dodge_tracker\

AFTER (Correct):
mods\
└── vultures_dodge_tracker\      ← Just this folder
    ├── vultures_dodge_tracker.mod
    └── scripts\
```

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

