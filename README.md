# GstarCAD Title Block Tools

Draw ISO-style sheet borders from a picked corner and place standard title fields as clean text.

Works with **GSTARCAD**, AutoCAD, ZWCAD, and BricsCAD.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Contents

- [About](#about)
- [Scripts Overview](#scripts-overview)
- [Quick Start](#quick-start)
- [Compatibility](#compatibility)
- [Contributing](#contributing)
- [License](#license)

## About

Every sheet starts with the same chore: drawing the border and filling in project, title, scale, date and drawn-by fields. This small toolbox draws A4-to-A1 borders from a bottom-left corner and places the standard title fields as clean text, so you can start drawing sooner.

Everything here is free to use with GstarCAD. Download the latest GstarCAD
release from the [official GstarCAD website](https://www.gstarcad.net). All
scripts are tested with **[GSTARCAD](https://www.gstarcad.net)** and major
DWG-based CAD platforms.

## Scripts Overview

| File | Description |
|------|-------------|
| `scripts/border.lsp` | ;; border.lsp - Draw an ISO-style sheet border
;; Command: TBORDER
;; Usage: TBORDER -> choose paper size -> pick bottom-left corner
(defun c:TBORDER ( / opt wh w h m pt )
  (initget "0 1 2 3")
  (setq opt (getkword "\nPaper size [0=A4/1=A3/2=A2/3=A1] <1>: "))
  (if (null opt) (setq opt "1"))
  (setq wh (cdr (assoc (atoi opt)
                       '((0 (297.0 210.0)) (1 (420.0 297.0))
                         (2 (594.0 420.0)) (3 (841.0 594.0))))))
  (setq w (car wh) h (cadr wh) m 10.0)
  (setq pt (getpoint "\nPick bottom-left corner: "))
  (if pt
    (progn
      (command "_.RECTANG" pt (list (+ (car pt) w) (+ (cadr pt) h)))
      (command "_.RECTANG"
               (list (+ (car pt) m) (+ (cadr pt) m))
               (list (- (+ (car pt) w) 5.0) (- (+ (cadr pt) h) 5.0)))
      (princ "\nBorder drawn. Add a title strip near the bottom-right corner.")
    )
  )
  (princ)
)
 |
| `scripts/title-fields.lsp` | ;; title-fields.lsp - Place standard title block fields as text
;; Command: TBFIELDS
(defun c:TBFIELDS ( / pt h vals names i v )
  (setq pt (getpoint "\nInsertion point (top-left of the fields): "))
  (if pt
    (progn
      (setq h (getdist "\nText height <2.5>: "))
      (if (null h) (setq h 2.5))
      (setq vals (list (getstring T "\nProject: ")
                       (getstring T "\nDrawing title: ")
                       (getstring T "\nScale: ")
                       (getstring T "\nDate: ")
                       (getstring T "\nDrawn by: "))
            names '("PROJECT" "TITLE" "SCALE" "DATE" "DRAWN")
            i 0)
      (foreach v vals
        (command "_.TEXT" "_J" "_TL" pt h 0
                 (strcat (nth i names) ": " v))
        (setq pt (list (car pt) (- (cadr pt) (* h 1.6)) 0)
              i (1+ i))
      )
      (princ "\nTitle block fields placed.")
    )
  )
  (princ)
)
 |

## Quick Start

1. Download the `.lsp` (or `.lin`) file you need
2. In your CAD software, run `APPLOAD`
3. Load the file and type the matching command name shown in the table above

## Compatibility

Tested on GstarCAD 2026/2027 and similar DWG-based platforms. Scripts use
standard AutoLISP functions only, so they work without extra plugins.

For step-by-step [tutorials and drafting guides](https://www.gstarcad.net/cad/),
visit the GstarCAD learning center. New tips are published regularly on the
[GSTARCAD Blog](https://blog.gstarcad.net).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see the [LICENSE](LICENSE) file.
