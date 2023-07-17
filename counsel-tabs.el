;;; counsel-tabs.el --- Counsel support for tabs  -*- lexical-binding:t; coding:utf-8 -*-

;; Copyright (C) enzu.ru

;; Homepage: https://enzu.ru
;; Keywords: convenience matching

;; Package-Version: 1.0.0
;; Package-Requires: ((emacs "27.1"))

;; SPDX-License-Identifier: GPL-3.0

;;; Commentary:

;; A simple way for searching tab names with counsel

;;; Code:

(require 'ivy)

(defun counsel-tabs-index-by-name (name &optional tabs frame)
  "Index TABS by NAME for FRAME."
  (seq-position (or tabs (funcall tab-bar-tabs-function frame))
                name (lambda (a b) (equal (alist-get 'name a) b))))

(defun counsel-tabs-recent-tabs (&optional tabs frame)
  "Get a list of TABS for FRAME organization by time."
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
            :history 'counsel-describe-symbol-history
            :require-match t
            :action (lambda (name)
                      (tab-bar-select-tab (1+ (or (counsel-tabs-index-by-name name) 0))))
            :caller 'counsel-describe-tab))

(provide 'counsel-tabs)

;;; counsel-tabs.el ends here
