;; border.lsp - Draw an ISO-style sheet border
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
