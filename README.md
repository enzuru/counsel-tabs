# counsel-tabs

**WARNING: This package is no longer maintained. You can get this functionality for free by switching your completion framework to [Vertico](https://github.com/minad/vertico) and using `tab-bar-select-tab-by-name`.**

This package a helpful (counsel-describe-tab) function so that one can search tabs via ivy.

## How to use

```lisp
(straight-use-package '(counsel-tabs :type git :host github :repo "enzuru/counsel-tabs"))
(require 'counsel-tabs)
(global-set-key (kbd "C-x C-n") 'counsel-tabs-describe-tab)
```
