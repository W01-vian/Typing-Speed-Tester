.686
.MODEL flat, stdcall
.STACK 4096
INCLUDE Irvine32.inc

; =============================================================================
;
;   ¦¦¦¦¦¦¦¦+¦¦+   ¦¦+¦¦¦¦¦¦+ ¦¦+¦¦¦+   ¦¦+ ¦¦¦¦¦¦+
;      ¦¦+--++¦¦+ ¦¦++¦¦+--¦¦+¦¦¦¦¦¦¦+  ¦¦¦¦¦+----+
;      ¦¦¦    +¦¦¦¦++ ¦¦¦¦¦¦++¦¦¦¦¦+¦¦+ ¦¦¦¦¦¦  ¦¦¦+
;      ¦¦¦     +¦¦++  ¦¦+---+ ¦¦¦¦¦¦+¦¦+¦¦¦¦¦¦   ¦¦¦
;      ¦¦¦      ¦¦¦   ¦¦¦     ¦¦¦¦¦¦ +¦¦¦¦¦+¦¦¦¦¦¦++
;      +-+      +-+   +-+     +-++-+  +---+ +-----+
;
;   ¦¦¦¦¦¦¦+¦¦¦¦¦¦+ ¦¦¦¦¦¦¦+¦¦¦¦¦¦¦+¦¦¦¦¦¦+
;   ¦¦+----+¦¦+--¦¦+¦¦+----+¦¦+----+¦¦+--¦¦+
;   ¦¦¦¦¦¦¦+¦¦¦¦¦¦++¦¦¦¦¦+  ¦¦¦¦¦+  ¦¦¦  ¦¦¦
;   +----¦¦¦¦¦+---+ ¦¦+--+  ¦¦+--+  ¦¦¦  ¦¦¦
;   ¦¦¦¦¦¦¦¦¦¦¦     ¦¦¦¦¦¦¦+¦¦¦¦¦¦¦+¦¦¦¦¦¦++
;   +------++-+     +------++------++-----+
;
;   ¦¦¦¦¦¦¦¦+¦¦¦¦¦¦¦+¦¦¦¦¦¦¦+¦¦¦¦¦¦¦¦+¦¦¦¦¦¦¦+¦¦¦¦¦¦+
;      ¦¦+--+¦¦+----+¦¦+----++--¦¦+--+¦¦+----+¦¦+--¦¦+
;      ¦¦¦   ¦¦¦¦¦+  ¦¦¦¦¦¦¦+   ¦¦¦   ¦¦¦¦¦+  ¦¦¦¦¦¦++
;      ¦¦¦   ¦¦+--+  +----¦¦¦   ¦¦¦   ¦¦+--+  ¦¦+--¦¦+
;      ¦¦¦   ¦¦¦¦¦¦¦+¦¦¦¦¦¦¦¦   ¦¦¦   ¦¦¦¦¦¦¦+¦¦¦  ¦¦¦
;      +-+   +------++------+   +-+   +------++-+  +-+
;
;   +---------------------------------------------------------+
;   |   v3.0  --  MASM Console Edition  |  NUTECH CS Dept.   |
;   |   .686  |  Irvine32  |  32-bit Flat Model              |
;   +---------------------------------------------------------+
;
;   NEW IN v3.0 vs v2.0:
;   - Session best WPM tracker with NEW BEST banner
;   - 5-star rating system based on WPM
;   - Colour-coded accuracy percentage
;   - Dotted / thin separator variety for visual rhythm
;   - Y = retry same sentence, N = new sentence, Q = quit
;   - Goodbye screen with session summary
;   - Improved colour palette (16 distinct roles)
;   - 5 instruction lines instead of 4
;   - Wider result label column
;
; =============================================================================

; =============================================================================
;  COLOUR CONSTANTS  (background * 16 + foreground)
;  All use black (0) background so we just store the foreground nibble.
; =============================================================================
COL_DEFAULT     EQU  15    ; Bright White    -- base text
COL_BORDER      EQU  11    ; Bright Cyan     -- main box lines
COL_BORDER_DIM  EQU   3    ; Cyan            -- dimmer box accent
COL_TITLE       EQU  13    ; Bright Magenta  -- ASCII banner
COL_SUBTITLE    EQU   5    ; Magenta         -- sub-headers
COL_TAGLINE     EQU   9    ; Bright Blue     -- tagline rows
COL_INSTRUCT    EQU  10    ; Bright Green    -- instruction text
COL_INSTR_NUM   EQU  14    ; Yellow          -- numbered steps
COL_TARGET_HDR  EQU  13    ; Bright Magenta  -- "TARGET LINE" header
COL_TARGET      EQU  14    ; Yellow          -- the sentence to type
COL_PROMPT      EQU  15    ; Bright White    -- prompt text
COL_INPUT       EQU  11    ; Bright Cyan     -- user input cursor line
COL_RESULT_HDR  EQU  13    ; Bright Magenta  -- "YOUR RESULTS" header
COL_RESULT_VAL  EQU  15    ; Bright White    -- raw result numbers
COL_LABEL       EQU   7    ; Gray            -- result row labels
COL_WPM_LOW     EQU  12    ; Bright Red      -- WPM < 35
COL_WPM_MED     EQU  14    ; Yellow          -- WPM 35-59
COL_WPM_HIGH    EQU  10    ; Bright Green    -- WPM >= 60
COL_WPM_BEST    EQU  11    ; Bright Cyan     -- personal best display
COL_WARN        EQU  12    ; Bright Red      -- empty-input warning
COL_REPEAT      EQU  11    ; Bright Cyan     -- replay prompt
COL_GOOD        EQU  10    ; Bright Green    -- positive messages
COL_STAR_FULL   EQU  14    ; Yellow          -- filled star (*)
COL_STAR_EMPTY  EQU   8    ; Dark Gray       -- empty star (-)
COL_SEPARATOR   EQU   8    ; Dark Gray       -- dotted/thin seps
COL_ACCENT      EQU   9    ; Bright Blue     -- accent details
COL_GOODBYE     EQU  13    ; Bright Magenta  -- goodbye header
COL_NEW_BEST    EQU  14    ; Yellow          -- new best banner

; =============================================================================
;  ASCII CHARS USED
; =============================================================================
CHAR_PIPE   EQU  '|'
CHAR_PLUS   EQU  '+'
CHAR_EQ     EQU  '='
CHAR_DASH   EQU  '-'
CHAR_SPACE  EQU  ' '
CHAR_STAR   EQU  '*'
CHAR_HASH   EQU  '#'
CHAR_DOT    EQU  '.'

; =============================================================================
;  LAYOUT
; =============================================================================
BOX_WIDTH   EQU  78    ; total columns (including the two corner chars)
INNER_WIDTH EQU  74    ; printable text columns between "| " and " |"

; =============================================================================
.DATA
; =============================================================================

; ---- Frame / border strings (all exactly 78 chars + NUL) -------------------
topBorder  BYTE "+", 76 DUP('='), "+", 0
botBorder  BYTE "+", 76 DUP('='), "+", 0
midLine    BYTE "+", 76 DUP('-'), "+", 0
dblLine    BYTE "|", 76 DUP('='), "|", 0
emptyRow   BYTE "|", 76 DUP(' '), "|", 0
thinSep    BYTE "|", 76 DUP('-'), "|", 0
dotSep     BYTE "|  ", "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -", "  |", 0
leftBar    BYTE "|  ", 0

; ---- ASCII art banner lines (printed inside leftBar frame) -----------------
ban1  BYTE " _____ _   _ ____  ___ _   _  ____   ____  ____  _____ _____ ____  ", 0
ban2  BYTE "|_   _| | | |  _ \|_ _| \ | |/ ___| / ___||  _ \| ____|  ___|  _ \ ", 0
ban3  BYTE "  | | | |_| | |_) || ||  \| | |  _   \___ \| |_) |  _| | |_  | | | |", 0
ban4  BYTE "  | | |  _  |  __/ | || |\  | |_| |   ___) |  __/| |___|  _| | |_| |", 0
ban5  BYTE "  |_| |_| |_|_|   |___|_| \_|\____| |____/|_|   |_____|_|   |____/ ", 0

; ---- Title / taglines ------------------------------------------------------
titleLine BYTE "        [ TYPING SPEED TESTER ]  v3.0  --  MASM Console Edition      ", 0
tagLine1  BYTE "        ~ Test Your Fingers.  Track Progress.  Beat Your Record. ~    ", 0
tagLine2  BYTE "             NUTECH Computer Science  |  32-bit x86 Assembly          ", 0

; ---- Section header strings ------------------------------------------------
hdrInstr   BYTE "  [ INSTRUCTIONS ]    ", 0
hdrTarget  BYTE "  [ TARGET LINE ]     ", 0
hdrInput   BYTE "  [ START TYPING ]    ", 0
hdrResult  BYTE "  [ YOUR RESULTS ]    ", 0
hdrGoodbye BYTE "  [ SEE YOU SOON! ]   ", 0

; ---- Instruction lines (5 steps) -------------------------------------------
instr1 BYTE "  [1]  Read the TARGET LINE below very carefully before typing.       ", 0
instr2 BYTE "  [2]  Type it EXACTLY -- every space and punctuation mark counts.    ", 0
instr3 BYTE "  [3]  Timer starts automatically on your FIRST keystroke.            ", 0
instr4 BYTE "  [4]  Press ENTER when done to see WPM, accuracy and grade.          ", 0
instr5 BYTE "  [5]  Y = retry same line  |  N = new sentence  |  Q = quit          ", 0

; ---- Result labels ---------------------------------------------------------
lblTime    BYTE "   Time Taken    :", 0
lblChars   BYTE "   Chars Typed   :", 0
lblCorrect BYTE "   Correct Chars :", 0
lblErrors  BYTE "   Errors        :", 0
lblAccStat BYTE "   Accuracy      :", 0
lblWPMStat BYTE "   Speed (WPM)   :", 0
lblGrade   BYTE "   Grade         :", 0
lblRating  BYTE "   Star Rating   :", 0
lblBestWPM BYTE "   Session Best  :", 0
lblTests   BYTE "   Tests Done    :", 0

; ---- Grade messages (letter + text) ----------------------------------------
gradeS BYTE " [S]  Speed Demon! Simply Incredible -- Top 1% Worldwide!    ", 0
gradeA BYTE " [A]  Excellent Typist!  Well Above Average.                 ", 0
gradeB BYTE " [B]  Good Speed!  Keep Pushing -- Grade A is within reach.  ", 0
gradeC BYTE " [C]  Average Speed.  Daily Practice Will Help You Improve.  ", 0
gradeD BYTE " [D]  Keep Practising! Every Expert Was Once a Beginner.     ", 0

; ---- Misc strings ----------------------------------------------------------
newBestMsg  BYTE "  *** NEW PERSONAL BEST!  Outstanding!  Keep it up! ***  ", 0
promptStr   BYTE "   >> Type below and press ENTER when finished:", 0
arrowStr    BYTE "   --> ", 0
emptyWarn   BYTE "   [!]  Nothing typed -- test skipped.  Please try again!", 0
repeatMsg   BYTE "   Play again?  Y = same line  |  N = new line  |  Q = quit  -->  ", 0
gdbyMsg1    BYTE "   Thank you for using Typing Speed Tester v3.0!                   ", 0
gdbyMsg2    BYTE "   Keep practising -- great typists are made, not born.  :)        ", 0
gdbyMsg3    BYTE "   NUTECH CS Dept.  |  More MASM projects coming soon!             ", 0

; ---- Unit suffix strings ---------------------------------------------------
strWPM    BYTE " WPM", 0
strPct    BYTE "%", 0
strSec    BYTE "s", 0
strSlash  BYTE " / ", 0
strChars  BYTE " chars", 0
strTests  BYTE " tests", 0

; ---- Practice sentences (8 lines, pointers in array) ----------------------
line1 BYTE "The quick brown fox jumps over the lazy dog.", 0
line2 BYTE "How much wood would a woodchuck chuck if a woodchuck could chuck wood?", 0
line3 BYTE "She sells seashells by the seashore on sunny summer days.", 0
line4 BYTE "Peter Piper picked a peck of pickled peppers from a pepper patch.", 0
line5 BYTE "I saw Susie sitting in a shoeshine shop shining shoes.", 0
line6 BYTE "Can you keep a secret from your closest and dearest friend?", 0
line7 BYTE "A journey of a thousand miles begins with a single step forward.", 0
line8 BYTE "All that glitters is not gold, but every great effort shines.", 0
NUM_LINES EQU 8

linePtrs DWORD OFFSET line1, OFFSET line2, OFFSET line3, OFFSET line4,
               OFFSET line5, OFFSET line6, OFFSET line7, OFFSET line8

; ---- Working buffers -------------------------------------------------------
refLine   BYTE 256 DUP(?)
refLen    DWORD 0
userInput BYTE 512 DUP(?)

; ---- Per-round stats -------------------------------------------------------
totalTyped    DWORD 0
correctCnt    DWORD 0
errorCnt      DWORD 0
startTimeMS   DWORD 0
elapsedMS     DWORD 0
elapsedSec    DWORD 0
elapsedTenths DWORD 0
wpm           DWORD 0
accWhole      DWORD 0
accFrac       DWORD 0

; ---- Session-persistent stats ----------------------------------------------
bestWPM     DWORD 0     ; personal best WPM this session
testCount   DWORD 0     ; completed tests
lastSentIdx DWORD 99    ; prevents same sentence twice in a row
isNewBest   DWORD 0     ; 1 = new best achieved this round

; =============================================================================
.CODE
; =============================================================================

; =============================================================================
;  MACRO  WriteColor  --  EAX = colour byte, calls SetTextColor
; =============================================================================
WriteColor MACRO colVal
    mov  eax, colVal
    call SetTextColor
ENDM

; =============================================================================
;  MACRO  PrintStr  --  print null-terminated string at strAddr (no CRLF)
; =============================================================================
PrintStr MACRO strAddr
    mov  edx, OFFSET strAddr
    call WriteString
ENDM

; =============================================================================
;  MACRO  PrintStrLn  --  print string + CRLF
; =============================================================================
PrintStrLn MACRO strAddr
    mov  edx, OFFSET strAddr
    call WriteString
    call Crlf
ENDM

; =============================================================================
;  DrawTopBorder
; =============================================================================
DrawTopBorder PROC
    pushad
    WriteColor COL_BORDER
    PrintStrLn topBorder
    popad
    ret
DrawTopBorder ENDP

; =============================================================================
;  DrawBotBorder
; =============================================================================
DrawBotBorder PROC
    pushad
    WriteColor COL_BORDER
    PrintStrLn botBorder
    popad
    ret
DrawBotBorder ENDP

; =============================================================================
;  DrawMidLine  -- +------ divider
; =============================================================================
DrawMidLine PROC
    pushad
    WriteColor COL_BORDER
    PrintStrLn midLine
    popad
    ret
DrawMidLine ENDP

; =============================================================================
;  DrawDblLine  -- |====== divider
; =============================================================================
DrawDblLine PROC
    pushad
    WriteColor COL_BORDER
    PrintStrLn dblLine
    popad
    ret
DrawDblLine ENDP

; =============================================================================
;  DrawThinSep  -- |----- thin separator
; =============================================================================
DrawThinSep PROC
    pushad
    WriteColor COL_SEPARATOR
    PrintStrLn thinSep
    popad
    ret
DrawThinSep ENDP

; =============================================================================
;  DrawDotSep  -- |.- dotted separator
; =============================================================================
DrawDotSep PROC
    pushad
    WriteColor COL_SEPARATOR
    PrintStrLn dotSep
    popad
    ret
DrawDotSep ENDP

; =============================================================================
;  DrawEmptyRow  -- |    blank row    |
; =============================================================================
DrawEmptyRow PROC
    pushad
    WriteColor COL_BORDER
    PrintStrLn emptyRow
    popad
    ret
DrawEmptyRow ENDP

; =============================================================================
;  SelectRandomLine
;    Picks a sentence index using GetMSeconds % NUM_LINES,
;    skipping the lastSentIdx to avoid immediate repeats.
;    Copies sentence into refLine and sets refLen.
; =============================================================================
SelectRandomLine PROC
    pushad

retry_pick:
    call GetMSeconds
    xor  edx, edx
    mov  ecx, NUM_LINES
    div  ecx                    ; EDX = 0 .. NUM_LINES-1

    cmp  edx, lastSentIdx
    je   retry_pick             ; avoid same sentence twice in a row

    mov  lastSentIdx, edx

    ; copy sentence into refLine
    mov  esi, linePtrs[edx*4]
    lea  edi, refLine
    xor  ecx, ecx
copy_loop:
    mov  al, [esi]
    mov  [edi], al
    cmp  al, 0
    je   copy_done
    inc  esi
    inc  edi
    inc  ecx
    jmp  copy_loop
copy_done:
    mov  refLen, ecx

    popad
    ret
SelectRandomLine ENDP

; =============================================================================
;  CompareStrings  -- populates correctCnt, errorCnt
; =============================================================================
CompareStrings PROC
    pushad
    mov  correctCnt, 0
    mov  errorCnt,   0
    mov  esi, OFFSET refLine
    mov  edi, OFFSET userInput
    mov  ecx, totalTyped
    cmp  ecx, 0
    je   cmp_done
cmp_loop:
    mov  al, [esi]
    cmp  al, 0
    je   cmp_done
    cmp  al, [edi]
    jne  cmp_err
    inc  correctCnt
    jmp  cmp_next
cmp_err:
    inc  errorCnt
cmp_next:
    inc  esi
    inc  edi
    dec  ecx
    jnz  cmp_loop
cmp_done:
    popad
    ret
CompareStrings ENDP

; =============================================================================
;  ComputeStats
;    Fills: accWhole, accFrac, elapsedSec, elapsedTenths, wpm
;    Also updates bestWPM and isNewBest flag
; =============================================================================
ComputeStats PROC
    pushad

    ; --- Accuracy (whole.frac %) ---
    ; accuracy = (correctCnt * 1000) / totalTyped  -> divide by 10 for decimal
    mov  eax, correctCnt
    mov  ebx, 1000
    mul  ebx
    mov  ebx, totalTyped
    cmp  ebx, 0
    je   acc_zero
    xor  edx, edx
    div  ebx                ; EAX = accuracy * 100  (e.g. 975 = 97.5%)
    xor  edx, edx
    mov  ecx, 10
    div  ecx
    mov  accWhole, eax      ; e.g. 97
    mov  accFrac,  edx      ; e.g. 5
    jmp  acc_done
acc_zero:
    mov  accWhole, 0
    mov  accFrac,  0
acc_done:

    ; --- Elapsed: whole seconds + tenths ---
    mov  eax, elapsedMS
    xor  edx, edx
    mov  ecx, 1000
    div  ecx
    mov  elapsedSec, eax    ; whole seconds
    mov  eax, edx           ; remainder ms
    xor  edx, edx
    mov  ecx, 100
    div  ecx
    mov  elapsedTenths, eax ; tenths of a second

    ; --- WPM = (correctCnt * 12) / elapsedSec ---
    ;   Derivation: WPM = (chars/5) / (secs/60) = chars*12/secs
    cmp  elapsedSec, 0
    jne  do_wpm
    mov  wpm, 0
    jmp  wpm_done
do_wpm:
    mov  eax, correctCnt
    mov  ebx, 12
    mul  ebx
    xor  edx, edx
    div  elapsedSec
    mov  wpm, eax
wpm_done:

    ; --- Update best WPM ---
    mov  isNewBest, 0
    mov  eax, wpm
    cmp  eax, bestWPM
    jle  no_new_best
    mov  bestWPM, eax
    mov  isNewBest, 1
no_new_best:

    popad
    ret
ComputeStats ENDP

; =============================================================================
;  DrawStarRating
;    Prints star rating inline (no CRLF). Caller provides leading space.
;    Stars: wpm>=80 -> 5*, >=60 -> 4*, >=40 -> 3*, >=20 -> 2*, else 1*
; =============================================================================
DrawStarRating PROC
    pushad

    ; determine number of filled stars in EBX
    mov  eax, wpm
    mov  ebx, 1
    cmp  eax, 20
    jl   sr_decided
    mov  ebx, 2
    cmp  eax, 40
    jl   sr_decided
    mov  ebx, 3
    cmp  eax, 60
    jl   sr_decided
    mov  ebx, 4
    cmp  eax, 80
    jl   sr_decided
    mov  ebx, 5
sr_decided:

    ; draw filled stars
    mov  ecx, ebx
sr_fill:
    WriteColor COL_STAR_FULL
    mov  al, '*'
    call WriteChar
    mov  al, ' '
    call WriteChar
    dec  ecx
    jnz  sr_fill

    ; draw empty stars
    mov  ecx, 5
    sub  ecx, ebx
    cmp  ecx, 0
    je   sr_fraction
sr_empty:
    WriteColor COL_STAR_EMPTY
    mov  al, '-'
    call WriteChar
    mov  al, ' '
    call WriteChar
    dec  ecx
    jnz  sr_empty

sr_fraction:
    ; append "(N/5)" in gray
    WriteColor COL_LABEL
    mov  al, ' '
    call WriteChar
    mov  al, '('
    call WriteChar
    WriteColor COL_RESULT_VAL
    mov  eax, ebx
    call WriteDec
    WriteColor COL_LABEL
    mov  al, '/'
    call WriteChar
    mov  al, '5'
    call WriteChar
    mov  al, ')'
    call WriteChar

    popad
    ret
DrawStarRating ENDP

; =============================================================================
;  DrawBanner  -- logo + title block
; =============================================================================
DrawBanner PROC
    pushad

    call DrawTopBorder
    call DrawEmptyRow

    ; ASCII art (5 lines, bright magenta)
    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_TITLE
    PrintStrLn ban1

    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_TITLE
    PrintStrLn ban2

    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_TITLE
    PrintStrLn ban3

    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_TITLE
    PrintStrLn ban4

    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_TITLE
    PrintStrLn ban5

    call DrawEmptyRow
    call DrawDblLine

    ; Title
    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_TITLE
    PrintStrLn titleLine

    ; Tagline 1
    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_TAGLINE
    PrintStrLn tagLine1

    ; Tagline 2
    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_SEPARATOR
    PrintStrLn tagLine2

    call DrawEmptyRow
    call DrawDblLine

    popad
    ret
DrawBanner ENDP

; =============================================================================
;  DrawInstructions
; =============================================================================
DrawInstructions PROC
    pushad

    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_INSTRUCT
    PrintStrLn hdrInstr

    call DrawThinSep

    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_INSTR_NUM
    PrintStrLn instr1

    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_INSTR_NUM
    PrintStrLn instr2

    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_INSTRUCT
    PrintStrLn instr3

    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_INSTRUCT
    PrintStrLn instr4

    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_ACCENT
    PrintStrLn instr5

    call DrawEmptyRow
    call DrawDblLine

    popad
    ret
DrawInstructions ENDP

; =============================================================================
;  DrawTargetLine  -- shows the sentence the user must type
; =============================================================================
DrawTargetLine PROC
    pushad

    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_TARGET_HDR
    PrintStrLn hdrTarget

    call DrawThinSep
    call DrawEmptyRow

    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_TARGET
    mov  al, ' '
    call WriteChar
    mov  edx, OFFSET refLine
    call WriteString
    call Crlf

    call DrawEmptyRow
    call DrawDblLine

    popad
    ret
DrawTargetLine ENDP

; =============================================================================
;  DrawInputPrompt  -- prompt + arrow for user to type after
; =============================================================================
DrawInputPrompt PROC
    pushad

    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_INPUT
    PrintStrLn hdrInput

    call DrawThinSep

    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_PROMPT
    PrintStrLn promptStr

    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_INPUT
    mov  edx, OFFSET arrowStr
    call WriteString

    popad
    ret
DrawInputPrompt ENDP

; =============================================================================
;  DrawResultBox  -- full results panel after typing
; =============================================================================
DrawResultBox PROC
    pushad

    call Crlf
    call DrawTopBorder
    call DrawEmptyRow

    ; ---- Header ----
    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_RESULT_HDR
    PrintStrLn hdrResult

    call DrawDblLine

    ; ---- Time ----
    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_LABEL
    PrintStr lblTime
    WriteColor COL_RESULT_VAL
    mov  al, ' '
    call WriteChar
    mov  eax, elapsedSec
    call WriteDec
    WriteColor COL_SEPARATOR
    mov  al, '.'
    call WriteChar
    WriteColor COL_RESULT_VAL
    mov  eax, elapsedTenths
    call WriteDec
    WriteColor COL_LABEL
    PrintStr strSec
    call Crlf

    call DrawDotSep

    ; ---- Chars Typed ----
    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_LABEL
    PrintStr lblChars
    WriteColor COL_RESULT_VAL
    mov  al, ' '
    call WriteChar
    mov  eax, totalTyped
    call WriteDec
    call Crlf

    ; ---- Correct ----
    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_LABEL
    PrintStr lblCorrect
    WriteColor COL_WPM_HIGH
    mov  al, ' '
    call WriteChar
    mov  eax, correctCnt
    call WriteDec
    call Crlf

    ; ---- Errors ----
    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_LABEL
    PrintStr lblErrors
    WriteColor COL_WPM_LOW
    mov  al, ' '
    call WriteChar
    mov  eax, errorCnt
    call WriteDec
    call Crlf

    call DrawThinSep

    ; ---- Accuracy (colour-coded) ----
    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_LABEL
    PrintStr lblAccStat
    ; pick colour by accuracy
    mov  eax, accWhole
    cmp  eax, 90
    jge  acc_col_high
    cmp  eax, 70
    jge  acc_col_med
    WriteColor COL_WPM_LOW
    jmp  acc_col_set
acc_col_med:
    WriteColor COL_WPM_MED
    jmp  acc_col_set
acc_col_high:
    WriteColor COL_WPM_HIGH
acc_col_set:
    mov  al, ' '
    call WriteChar
    mov  eax, accWhole
    call WriteDec
    WriteColor COL_SEPARATOR
    mov  al, '.'
    call WriteChar
    mov  eax, accFrac
    call WriteDec
    WriteColor COL_LABEL
    PrintStr strPct
    call Crlf

    call DrawThinSep

    ; ---- WPM (colour-coded) ----
    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_LABEL
    PrintStr lblWPMStat
    mov  eax, wpm
    cmp  eax, 60
    jge  wpm_col_high
    cmp  eax, 35
    jge  wpm_col_med
    WriteColor COL_WPM_LOW
    jmp  wpm_col_set
wpm_col_med:
    WriteColor COL_WPM_MED
    jmp  wpm_col_set
wpm_col_high:
    WriteColor COL_WPM_HIGH
wpm_col_set:
    mov  al, ' '
    call WriteChar
    mov  eax, wpm
    call WriteDec
    WriteColor COL_LABEL
    PrintStr strWPM
    call Crlf

    call DrawThinSep

    ; ---- Grade ----
    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_LABEL
    PrintStr lblGrade
    mov  eax, wpm
    cmp  eax, 80
    jge  grade_s
    cmp  eax, 60
    jge  grade_a
    cmp  eax, 40
    jge  grade_b
    cmp  eax, 20
    jge  grade_c
    WriteColor COL_WPM_LOW
    PrintStrLn gradeD
    jmp  grade_done
grade_s:
    WriteColor COL_WPM_HIGH
    PrintStrLn gradeS
    jmp  grade_done
grade_a:
    WriteColor COL_WPM_HIGH
    PrintStrLn gradeA
    jmp  grade_done
grade_b:
    WriteColor COL_WPM_MED
    PrintStrLn gradeB
    jmp  grade_done
grade_c:
    WriteColor COL_WPM_MED
    PrintStrLn gradeC
grade_done:

    call DrawThinSep

    ; ---- Star Rating ----
    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_LABEL
    PrintStr lblRating
    mov  al, ' '
    call WriteChar
    call DrawStarRating
    call Crlf

    call DrawThinSep

    ; ---- Session Best WPM ----
    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_LABEL
    PrintStr lblBestWPM
    WriteColor COL_WPM_BEST
    mov  al, ' '
    call WriteChar
    mov  eax, bestWPM
    call WriteDec
    WriteColor COL_LABEL
    PrintStr strWPM
    call Crlf

    ; ---- New Best Banner (shown only when achieved) ----
    cmp  isNewBest, 1
    jne  skip_new_best
    call DrawDotSep
    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_NEW_BEST
    PrintStrLn newBestMsg
skip_new_best:

    call DrawEmptyRow
    call DrawBotBorder

    popad
    ret
DrawResultBox ENDP

; =============================================================================
;  DrawGoodbyeScreen  -- session summary + farewell
; =============================================================================
DrawGoodbyeScreen PROC
    pushad
    call Crlf
    call DrawTopBorder
    call DrawEmptyRow

    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_GOODBYE
    PrintStrLn hdrGoodbye

    call DrawDblLine

    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_GOOD
    PrintStrLn gdbyMsg1

    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_INSTRUCT
    PrintStrLn gdbyMsg2

    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_TAGLINE
    PrintStrLn gdbyMsg3

    call DrawThinSep

    ; Session best WPM
    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_LABEL
    PrintStr lblBestWPM
    WriteColor COL_WPM_BEST
    mov  al, ' '
    call WriteChar
    mov  eax, bestWPM
    call WriteDec
    WriteColor COL_LABEL
    PrintStr strWPM
    call Crlf

    ; Tests completed
    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_LABEL
    PrintStr lblTests
    WriteColor COL_RESULT_VAL
    mov  al, ' '
    call WriteChar
    mov  eax, testCount
    call WriteDec
    WriteColor COL_LABEL
    PrintStr strTests
    call Crlf

    call DrawEmptyRow
    call DrawBotBorder
    call Crlf

    popad
    ret
DrawGoodbyeScreen ENDP

; =============================================================================
;  RunOneTest
;    Draws the full typing UI, captures input, scores it, draws results.
;    EBX must = 1 if sentence was pre-loaded (retry), 0 if fresh pick needed.
;    Returns in EAX:  0=quit, 1=retry same, 2=new sentence
; =============================================================================
RunOneTest PROC
    pushad

    ; Draw full UI
    call DrawBanner
    call DrawInstructions
    call DrawTargetLine
    call DrawInputPrompt

    ; Start timer and read input
    WriteColor COL_INPUT
    call GetMSeconds
    mov  startTimeMS, eax

    mov  edx, OFFSET userInput
    mov  ecx, 511
    call ReadString
    mov  totalTyped, eax

    call GetMSeconds
    sub  eax, startTimeMS
    mov  elapsedMS, eax

    ; Empty check
    cmp  totalTyped, 0
    jne  rot_score

    call Crlf
    WriteColor COL_BORDER
    PrintStr leftBar
    WriteColor COL_WARN
    PrintStrLn emptyWarn
    call DrawBotBorder
    jmp  rot_ask

rot_score:
    call CompareStrings
    call ComputeStats
    call DrawResultBox
    inc  testCount

rot_ask:
    call Crlf
    WriteColor COL_REPEAT
    mov  edx, OFFSET repeatMsg
    call WriteString
    WriteColor COL_INPUT
    call ReadChar
    call Crlf

    ; Store chosen action in local var via stack then popad trick:
    ; We need to return in EAX but pushad saved it -- use memory
    cmp  al, 'Y'
    je   rot_retry
    cmp  al, 'y'
    je   rot_retry
    cmp  al, 'N'
    je   rot_new
    cmp  al, 'n'
    je   rot_new
    ; Q or anything else -> quit
    mov  [esp+28], DWORD PTR 0   ; overwrite saved EAX on stack
    jmp  rot_done

rot_retry:
    mov  [esp+28], DWORD PTR 1
    jmp  rot_done

rot_new:
    mov  [esp+28], DWORD PTR 2

rot_done:
    popad   ; EAX now has the return value we wrote above
    ret
RunOneTest ENDP

; =============================================================================
;  main
; =============================================================================
main PROC
    WriteColor COL_DEFAULT
    call Clrscr

    ; ---- Pick first sentence ----
    call SelectRandomLine

main_loop:
    call RunOneTest          ; EAX = 0 quit / 1 retry / 2 new

    cmp  eax, 0
    je   main_exit

    cmp  eax, 1
    je   main_retry

    ; New sentence
    WriteColor COL_DEFAULT
    call Clrscr
    call SelectRandomLine
    jmp  main_loop

main_retry:
    WriteColor COL_DEFAULT
    call Clrscr
    ; refLine still holds the same sentence -- no re-pick needed
    jmp  main_loop

main_exit:
    call DrawGoodbyeScreen
    WriteColor COL_DEFAULT
    exit

main ENDP
END main