;;; counsel-tabs.el --- counsel support for tabs

;; Copyright (C) Salma Karama, LLC
;; SPDX-License-Identifier: GPL-3.0

;;; Code:

(defun counsel-describe-tab ()
  "Forward to `describe-tab'."
  (interactive)
  (ivy-read "Describe tab: "
            (let* ((recent-tabs (mapcar (lambda (tab)
                                          (alist-get 'name tab))
                                        (tab-bar--tabs-recent))))
              recent-tabs)
            ;; :keymap counsel-describe-map
            :history 'counsel-describe-symbol-history
            :require-match t
            :action (lambda (name)
                      (tab-bar-select-tab (1+ (or (tab-bar--tab-index-by-name name) 0))))
            :caller 'counsel-describe-tab))

(provide 'counsel-tabs)
