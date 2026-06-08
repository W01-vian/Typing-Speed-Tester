# ⌨️ Typing Speed Tester  
### *Web + x86 Assembly – Two flavors, one goal*

> **Test your fingers. Track your progress. Beat your own record.**  
> This repository contains **two complete implementations** of a typing speed tester:  
> — 🌐 **modern web app** (HTML/CSS/JS, real‑time feedback)  
> — 🧩 **retro console edition** (x86 MASM, colourful terminal UI)

---

## ✨ Features (both versions)

- 🧠 **Randomised sentences** – never practise the same line twice in a row  
- ⏱️ **Auto‑start timer** – begins on your first keystroke  
- 📊 **Live WPM & accuracy** – instant feedback while you type (web) / after submission (ASM)  
- 🏆 **Star rating system** – 1–5 stars based on your WPM  
- 📈 **Session best WPM** – keeps track of your personal record  
- 🎨 **Colour‑coded results** – green = excellent, yellow = average, red = needs practice  
- 🔁 **Retry / new sentence / quit** – full control over your training session  

---

## 🌐 Web Version (HTML/JS)

A **real‑time typing playground** with a sleek dark UI, character‑by‑character highlighting, and live error tracking.

### 🖥️ How to run

1. Save `index.html` anywhere on your computer.  
2. Double‑click the file – it opens in your default browser.  
3. Start typing! No internet connection or server needed.

### 🎯 Key features (web)

- **Cursor animation** & progress bar  
- Instant **error highlighting** (red underline for mistakes)  
- **WPM, accuracy, grade** calculated live  
- **Grade banners** (S, A, B, C, D) with motivational messages  
- **Shuffle button** to change sentence anytime  
- **Responsive design** – works on desktop & tablet


---

## 🕹️ Assembly Version (MASM / Irvine32)

A **true console experience** – type inside a beautifully framed ASCII box, get your score, and watch your session best climb.

### ⚙️ Requirements

- **MASM** (Microsoft Macro Assembler)  
- **Irvine32 library** (for colour, keyboard, and timer functions)  
- A 32‑bit Windows environment (or DOSBox with MASM setup)

### 🛠️ Build & run

```bash
# Assemble and link (using MASM with Irvine32)
ml /coff /Zi tst.asm /link /SUBSYSTEM:CONSOLE kernel32.lib Irvine32.lib

# Run the executable
tst.exe
```

> 💡 *If you're new to MASM, use Visual Studio’s **Developer Command Prompt** or a pre‑configured environment like **MASM32 SDK**.*

### ⌨️ Assembly‑specific goodies

- **5‑step instructions** shown inside a bordered terminal  
- **Star rating** (★ filled / ☆ empty) displayed as `* * * - - (3/5)`  
- **Colour palette** – 16 distinct colours for borders, headers, numbers, warnings  
- **Separator variety** – dotted lines (`-.-`), thin lines (`-----`), double lines (`=====`) for visual rhythm  
- **New best banner** – lights up when you break your session record  
- **Goodbye screen** – shows total tests taken & best WPM before exiting  

---

## 📊 Comparison at a glance

| Feature                     | Web Version       | Assembly Version       |
|-----------------------------|-------------------|------------------------|
| Real‑time character highlight| ✅                | ❌ (submission‑based)  |
| Live error counter           | ✅                | ❌                     |
| Session best WPM             | ✅ (display only) | ✅ (saved during run)  |
| Star rating system           | ✅ (5‑star)       | ✅ (5‑star)            |
| Colour‑coded output          | ✅ (CSS)          | ✅ (Irvine32 colours)  |
| No installation required     | ✅                | ❌ (needs MASM)        |
| Retro terminal aesthetic     | ❌                | ✅ (full ASCII frame)  |

---

## 🧠 How the scoring works

- **WPM (Words Per Minute)** = (correct characters / 5) / (time in minutes)  
  *Simplified: `(correctChars * 12) / seconds`*  
- **Accuracy** = (correct chars / total typed chars) × 100%  
- **Grade** is derived purely from WPM:  
  - `≥80` → **S** (Speed Demon)  
  - `60–79` → **A** (Excellent)  
  - `40–59` → **B** (Good)  
  - `20–39` → **C** (Average)  
  - `<20` → **D** (Keep practising)

- **Star rating**:  
  `5★` ≥80 WPM · `4★` ≥60 · `3★` ≥40 · `2★` ≥20 · `1★` <20

---
```
+==============================================================================+
|  _____ _   _ ____  ___ _   _  ____   ____  ____  _____ _____ ____            |
| |_   _| | | |  _ \|_ _| \ | |/ ___| / ___||  _ \| ____|  ___|  _ \           |
|   | | | |_| | |_) || ||  \| | |  _   \___ \| |_) |  _| | |_  | | | |          |
|   | | |  _  |  __/ | || |\  | |_| |   ___) |  __/| |___|  _| | |_| |          |
|   |_| |_| |_|_|   |___|_| \_|\____| |____/|_|   |_____|_|   |____/           |
|                                                                              |
|        [ TYPING SPEED TESTER ]  v3.0  --  MASM Console Edition               |
|        ~ Test Your Fingers.  Track Progress.  Beat Your Record. ~            |
|             NUTECH Computer Science  |  32-bit x86 Assembly                  |
+==============================================================================+
```

---

## 🙌 Credits & licence

- **Web version** – pure HTML/CSS/JS, no external libraries.  
- **Assembly version** – built with Irvine32 library, inspired by classic DOS typing tutors.  
- Designed and implemented as a **fun coding challenge** – feel free to modify, extend, or port to other languages.

📜 **MIT License** – use, share, and improve as you like.

---

## 🚀 Future ideas

- [ ] Add a **leaderboard** (localStorage for web, file storage for ASM)  
- [ ] Include **difficulty levels** (longer sentences, punctuation‑heavy)  
- [ ] **Sound effects** on completion (web: Web Audio, ASM: Beep)  
- [ ] **Export session stats** to CSV  

---

## 💬 Feedback

If you find a bug or have a cool idea, open an **Issue** or submit a **Pull Request**.  
Typing fast is a skill – this tool wants to make practise fun and measurable.

**Happy typing! ⌨️⚡**
