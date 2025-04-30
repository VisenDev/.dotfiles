(in-package :lem-user)

(lem-vi-mode:vi-mode)

(lem:define-key lem-vi-mode:*normal-keymap* "Space" 'next-buffer)
(lem:define-key lem-vi-mode:*normal-keymap* "C-w o" 'delete-other-windows)
(lem:define-key lem-vi-mode:*visual-keymap* ">" 'indent-region)
  

