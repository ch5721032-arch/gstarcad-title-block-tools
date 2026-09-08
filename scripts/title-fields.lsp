;; title-fields.lsp - Place standard title block fields as text
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
