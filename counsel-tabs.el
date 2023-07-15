;;; counsel-tabs.el --- counsel support for tabs

;; Copyright (C) enzu.ru
;; SPDX-License-Identifier: GPL-3.0

(defun counsel-tabs-index-by-name (name &optional tabs frame)
  ;; Return the index of TAB by the its NAME.
  (seq-position (or tabs (funcall tab-bar-tabs-function frame))
                name (lambda (a b) (equal (alist-get 'name a) b))))

(defun counsel-tabs-recent-tabs (&optional tabs frame)
  (let* ((tabs (or tabs (funcall tab-bar-tabs-function frame))))
    (seq-sort-by (lambda (tab) (alist-get 'time tab)) #'>
                 (seq-remove (lambda (tab)
                               (eq (car tab) 'current-tab))
                             tabs))))

(defun counsel-tabs-describe-tab ()
  "Forward to `describe-tab'."
  (interactive)
  (ivy-read "Describe tab: "
            (let* ((recent-tabs (mapcar (lambda (tab)
                                          (alist-get 'name tab))
                                        (counsel-tabs-recent-tabs))))
              recent-tabs)
            ;; :keymap counsel-describe-map
            :history 'counsel-describe-symbol-history
            :require-match t
            :action (lambda (name)
                      (tab-bar-select-tab (1+ (or (counsel-tabs-index-by-name name) 0))))
            :caller 'counsel-describe-tab))

(provide 'counsel-tabs)
