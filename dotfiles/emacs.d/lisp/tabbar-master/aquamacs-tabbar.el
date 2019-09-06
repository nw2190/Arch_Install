;; -*-no-byte-compile: t; -*-
;; Aquamacs-tabbar.el --- "Look and feel" improvements to tabbar.el.  Uses
;;   Window Tabs by default: Tab-set is specific to each window, and tabbar
;;   is hidden when only a single tab exists for that window.

;; This file is part of Aquamacs Emacs.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.


;; Author: Nathaniel Cunningham <nathaniel.cunningham@gmail.com>
;; Maintainer: Nathaniel Cunningham <nathaniel.cunningham@gmail.com>
;; (C) Copyright 2008, 2012, 2014: the Aquamacs Project

;; load original tabbar-mode

(require 'tabbar)
(require 'aquamacs-compat)
(require 'one-buffer-one-frame)
(require 'aquamacs-tools)


;; check version of tabbar
(unless (and (boundp 'tabbar-version)
	     (string< "1.9999" tabbar-version))
  (message "Tabbar version too low. Uninstall %s."
	   (locate-library "tabbar"))
  (let ((load-path (list default-directory)))
    (load "tabbar/tabbar.el")))

(when (and (boundp 'tabbar-version)
	   (not (equal "2.0" tabbar-version)))
  (message "Warning: possibly incompatible tabbar version installed in %s."
	   (locate-library "tabbar")))


;; modify various settings:
;; eliminate gap between header-line and toolbar
;; save current value of tool-bar-border,
;;      to reset when tabbar-mode is turned off
(add-hook 'tabbar-init-hook (lambda ()
			      (setq tool-bar-border-saved tool-bar-border
				    tool-bar-border 0)))
(add-hook 'tabbar-quit-hook (lambda ()
			      (setq tool-bar-border tool-bar-border-saved
				    tool-bar-border-saved nil)))

;; used by tabbar-window-update-tabsets-when-idle
(defmacro fast-screen-refresh (&rest code)
  `(let ((tabbar-window-immediate-screen-fresh
	  (or tabbar-window-immediate-screen-fresh (interactive-p))))
     ,@code
     ))

;; improve tabbar-selected-tab such that it defaults to (tabbar-current-tabset)
;; if no tabset is passed
(defsubst tabbar-selected-tab (&optional tabset)
  "Return the tab selected in TABSET.  If no TABSET is specified,
use (tabbar-current-tabset)."
  (get (or tabset (tabbar-current-tabset) (tabbar-current-tabset t)) 'select))

(defvar tabbar-close-tab-function nil
  "Function to call to close a tabbar tab.  Passed a single argument, the tab
construct to be closed.")

(defvar tabbar-new-tab-function nil
  "Function to call to create a new buffer in tabbar-mode.  Optional single
argument is the MODE for the new buffer.")

;; for buffer tabs, use the usual command to close/kill a buffer
(defun tabbar-buffer-close-tab (tab)
  (let ((buffer (tabbar-tab-value tab))
	(one-buffer-one-frame nil))
    (with-current-buffer buffer
      (close-current-window-asktosave))))

(setq tabbar-close-tab-function 'tabbar-window-close-tab)

(defun tabbar-close-tab (&optional tab)
  "Generic function to close a tabbar tab.  Calls function named in
tabbar-close-tab-function.  Passes a single argument: the tab construct
to be closed.  If no tab is specified, (tabbar-selected-tab) is used"
  (interactive)
  (fast-screen-refresh
    (let ((thetab (or tab (tabbar-selected-tab))))
      (funcall tabbar-close-tab-function thetab))))


;; change faces for better-looking tabs (and more obvious selected tab!)
;; full face specification to avoid inheriting from the frame font
;; or from mode-line
(set-face-attribute 'tabbar-default nil
		    :inherit nil
		    :height 110
		    :weight 'normal
		    :width 'normal
		    :slant 'normal
		    :underline nil
		    :strike-through nil
;; inherit from frame		    :inverse-video
		    :stipple nil
		    :background "gray80"
		    :foreground "black"
;;		    :box '(:line-width 2 :color "white" :style nil)
		    :box nil
		    :family "Lucida Grande")

(set-face-attribute 'tabbar-selected nil
		    :background "gray95"
		    :foreground "gray20"
		    :inherit 'tabbar-default
		    :box '(:line-width 3 :color "grey95" :style nil))
;; 		    :box '(:line-width 2 :color "white" :style released-button))

(set-face-attribute 'tabbar-unselected nil
		    :inherit 'tabbar-default
		    :background "gray80"
		    :box '(:line-width 3 :color "grey80" :style nil))

(defface tabbar-selected-highlight '((t
		    :foreground "black"
		    :background "gray95"))
  "Face for selected, highlighted tabs."
  :group 'tabbar)

(defface tabbar-unselected-highlight '((t
                    ;; :foreground "black"
		    ;; :background "grey75"
		    ;; :box (:line-width 3 :color "grey75" :style nil)
					))
  "Face for unselected, highlighted tabs."
  :group 'tabbar)

(set-face-attribute 'tabbar-button nil
		    :inherit 'tabbar-default
		    :box nil)

(set-face-attribute 'tabbar-separator nil
		    :background "grey50"
 		    :foreground "grey50"
		    :height 1.0)

(setq tabbar-separator '(1)) ;; set tabbar-separator size to 1 pixel

(defface tabbar-selected-modified
  '((t
     :inherit tabbar-selected
     :weight bold
     :height 110
     ))
  "Face used for unselected tabs."
  :group 'tabbar)

(defface tabbar-unselected-modified
  '((t
     :inherit tabbar-unselected
     :weight bold
     :height 110
     ))
  "Face used for unselected tabs."
  :group 'tabbar)

(defface tabbar-key-binding '((t
				 :foreground "white"))
    "Face for unselected, highlighted tabs."
    :group 'tabbar)


;; do not let color themes override tabbar faces
(aquamacs-set-defaults '((color-theme-illegal-faces "^\\(w3-\\|tabbar-\\)")))


  ;; you may redefine these:
(defvar tabbar-key-binding-modifier-list '(alt)
  "List of modifiers to be used for keys bound to tabs.
Must call `tabbar-define-access-keys' or toggle `tabbar-mode' for
changes to this variable to take effect.")

(defvar tabbar-key-binding-keys '((49 kp-1) (50 kp-2) (51 kp-3) (52 kp-4) (53 kp-5) (54 kp-6) (55 kp-7) (56 kp-8) (57 kp-9) (48 kp-0))
  "Codes of ten keys bound to tabs (without modifiers.
This is a list with 10 elements, one for each of the first 10
tabs.  Each element is a list of keys, either of which can be
used in conjunction with the modifiers defined in
`tabbar-key-binding-modifier-list'. Must call
`tabbar-define-access-keys' or toggle `tabbar-mode' for changes
to this variable to take effect.")

(defsubst tabbar-key-command (index)	; command name
  (intern (format "tabbar-select-tab-%s" index)))

(eval-when-compile (require 'cl))
(defun tabbar-define-access-keys (&optional modifiers keys)
  "Set tab access keys for `tabbar-mode'.
MODIFIERS as in `tabbar-key-binding-modifier-list', and
KEYS defines the elements to use for `tabbar-key-binding-keys'."
  (if modifiers (setq tabbar-key-binding-modifier-list modifiers))
  (if keys (setq tabbar-key-binding-keys keys))
  (loop for keys in tabbar-key-binding-keys
	for ni from 1 to 10 do
	(let ((name (tabbar-key-command ni)))
	  (eval `(defun ,name ()
		   "Select tab in selected window."
		   (interactive)
		   (tabbar-select-tab-by-index ,(- ni 1))))
	  ;; store label in property of command name symbol
	  (put name 'label
	       (format "%c" (car keys)))
	  (loop for key in keys do
		(define-key tabbar-mode-map
		  (vector (append
			   tabbar-key-binding-modifier-list
			   (list key)))
		  name)))))

(defun tabbar-select-tab-by-index (index)
  ;; (let ((vis-index (+ index (or (get (tabbar-current-tabset) 'start) 0))))
  (unless (> (length (tabbar-tabs (tabbar-current-tabset))) 1)
    ;; better window (with tabs)in this frame?

    (let ((better-w))
      (walk-windows (lambda (w)
		      (and (not better-w)
			   (with-selected-window w
			     (if (> (length (tabbar-tabs (tabbar-current-tabset t))) 1)
				 (setq better-w w)))))
		    'avoid-minibuf (selected-frame))
      (if better-w (select-window better-w))))

  (tabbar-window-select-a-tab
   (nth index (tabbar-tabs (tabbar-current-tabset)))))

(defun tabbar-window-select-a-tab (tab)
  "Select TAB"
  (let ((one-buffer-one-frame nil)
	(buffer (tabbar-tab-value tab)))
    (when buffer

      (set-window-dedicated-p (selected-window) nil)
      (let ((prevtab (tabbar-get-tab (window-buffer (selected-window))
				     (tabbar-tab-tabset tab)))
	    (marker (cond ((bobp) (point-min-marker))
				((eobp) (point-max-marker))
				(t (point-marker)))))
	(set-marker-insertion-type marker t)
	(assq-set prevtab marker
		  'tab-points))
      (switch-to-buffer buffer)
      (let ((new-pt (cdr (assq tab tab-points))))
	(and new-pt
	     (eq (marker-buffer new-pt) (window-buffer (selected-window)))
	     (let ((pos (marker-position new-pt)))
	       (unless (eq pos (point))
		 (if transient-mark-mode
		     (deactivate-mark))
		 (goto-char pos))
	       (set-marker new-pt nil) ;; delete marker
	       ))))))
; (marker-insertion-type (cdr (car tab-points)))


;; function for closing a tab via context menu.  Kills buffer if doesn't
;;  appear in other tabs.
(defun tabbar-close-clicked-tab (event)
  (interactive "@e")
  (when (tabbar-click-p event)
    (let* ((clicklocation (posn-string (event-start event)))
	   (clickedtab (get-text-property (cdr clicklocation)
						  'tabbar-tab (car clicklocation))))
      (save-current-buffer
;;	(tabbar-window-close-tab clickedtab)))))
	(tabbar-close-tab clickedtab)))))

;; function for closing all other tabs via context menu
(defun tabbar-close-other-tabs (event)
  "Close all tabs except the one where context menu was generated via click"
  (interactive "@e")
  (when (tabbar-click-p event)
    (let* ((clicklocation (posn-string (event-start event)))
	   (clickedtab (get-text-property (cdr clicklocation)
					  'tabbar-tab (car clicklocation)))
	   (tablist (tabbar-tabs (tabbar-tab-tabset clickedtab))))
;      (save-current-buffer
	(dolist (thistab tablist (tabbar-tab-value clickedtab))
	  (unless (equal thistab clickedtab)
;;	    (tabbar-window-close-tab thistab))))));)
	(tabbar-close-tab thistab))))))

;; function for removing a tab via context menu, without killing buffer
(defun tabbar-delete-clicked-tab (event)
  (interactive "@e")
  (when (tabbar-click-p event)
    (let* ((clicklocation (posn-string (event-start event)))
	   (clickedtab (get-text-property (cdr clicklocation)
						  'tabbar-tab (car clicklocation))))
;;       (save-current-buffer
;;	(tabbar-window-close-tab clickedtab)))))
	(tabbar-window-delete-tab clickedtab))))

(defun tabbar-delete-current-tab ()
  "Delete the current tab."
  (interactive)
  (if tabbar-mode
      (tabbar-window-delete-tab (tabbar-selected-tab))
    (delete-window)))

;; function to open a new tab, suppressing new frame creation
(defun tabbar-new-tab (&optional mode)
  "Creates a new tab, containing an empty buffer (with major-mode MODE
if specified), in current window."
  (interactive)
  (let ((one-buffer-one-frame nil))
    (new-empty-buffer nil mode)))

(setq tabbar-new-tab-function 'tabbar-new-tab)

;; function for duplicating an existing tab in a new frame
(defun tabbar-new-frame-with-clicked-buffer (event)
  (interactive "@e")
  (when (tabbar-click-p event)
    (let* ((clicklocation (posn-string (event-start event)))
	   (clickedtab (get-text-property (cdr clicklocation)
					  'tabbar-tab (car clicklocation)))
	   (buffer (tabbar-tab-value clickedtab)))
      (with-current-buffer buffer
	(make-frame-command)))))

;; Opens clicked tab in a new frame, and deletes clicked tab
;; This function/implementation is specific to `window tabs' -- can't be done
;;   with `buffer tabs'
(defun tabbar-move-clicked-buffer-to-new-frame (event)
  (interactive "@e")
  (when (tabbar-click-p event)
    (let* ((clicklocation (posn-string (event-start event)))
	   (clickedtab (get-text-property (cdr clicklocation)
					  'tabbar-tab (car clicklocation)))
	   (buffer (tabbar-tab-value clickedtab))
	   (wnumber (string-to-number (symbol-name (tabbar-tab-tabset tab))))
	   (wind (window-number-get-window wnumber)))
      (with-current-buffer buffer
	(make-frame-command))
      (with-selected-window wind
	(tabbar-close-tab clickedtab)))))

(defun tabbar-move-current-buffer-to-new-frame ()
  (interactive)
  (let* ((tab (tabbar-selected-tab (tabbar-current-tabset t)))
	 (buffer (tabbar-tab-value tab))
	 (wnumber (string-to-number (symbol-name (tabbar-tab-tabset tab))))
	 (wind (window-number-get-window wnumber)))
    (with-current-buffer buffer
	(make-frame-command))
    (with-selected-window wind
	(tabbar-close-tab tab))))

;; keymap for tabbar context menu
(defvar tabbar-context-menu-map
  (let ((map (make-sparse-keymap)))
    (define-key map [removetab] (cons "Hide Tab" 'tabbar-delete-clicked-tab))
    (define-key map [duptab]
      (cons "Duplicate Tab in New Frame" 'tabbar-new-frame-with-clicked-buffer))
    (define-key map [movetab]
      (cons "Move Tab to New Frame" 'tabbar-move-clicked-buffer-to-new-frame))
    (define-key map [closeothers] (cons "Close Other Tabs" 'tabbar-close-other-tabs))
    (define-key map [closetab] (cons "Close Tab" 'tabbar-close-clicked-tab))
    (define-key map [newtab] (cons "New Buffer in New Tab" 'tabbar-new-tab))
    map) "Keymap for the Tabbar context menu.")

;; keymap for tabbar context menu
(defvar tabbar-empty-context-menu-map
  (let ((map (make-sparse-keymap)))
    (define-key map [mergetabs] (cons "Merge All Windows" 'tabbar-window-merge-windows))
    (define-key map [newtab] (cons "New Buffer in New Tab" 'tabbar-new-tab))
    map) "Keymap for the context menu of the empty portion of tab bar.")

;; modify hints to give only the buffer name
(defun tabbar-buffer-help-on-tab (tab)
  "Return the help string shown when mouse is onto TAB."
  (if tabbar--buffer-show-groups
      (let* ((tabset (tabbar-tab-tabset tab))
             (tab (tabbar-selected-tab tabset)))
        (format "click: switch to buffer %S in group [%s]"
                (buffer-name (tabbar-tab-value tab)) tabset))
    (format "%s"
            (buffer-name (tabbar-tab-value tab)))
    ))

;; provide new actions for middle-click/right-click on tabs
(defun tabbar-buffer-select-tab (event tab &optional prefix)
  "On mouse EVENT, select TAB."
  (let ((mouse-button (event-basic-type event))
		      (one-buffer-one-frame nil)
        (buffer (tabbar-tab-value tab)))
    (cond
     ((eq mouse-button 'mouse-3)
      (popup-menu tabbar-context-menu-map event prefix))
     (t
      (switch-to-buffer buffer)))
    ;; Don't show groups.
    (tabbar-buffer-show-groups nil)
    ))

(defsubst tabbar-normalize-image (image &optional margin nomask)
  "Make IMAGE centered and transparent.
If optional MARGIN is non-nil, it must be a number of pixels to add as
an extra margin around the image.  If optional NOMASK is non-nil, no mask
property is included."
  (let ((plist (cdr image)))
    (or (plist-get plist :ascent)
        (setq plist (plist-put plist :ascent 'center)))
    (or (plist-get plist :mask)
        (unless nomask
	    (setq plist (plist-put plist :mask '(heuristic t)))))
    (or (not (natnump margin))
        (plist-get plist :margin)
        (plist-put plist :margin margin))
    (setcdr image plist))
  image)

;; use images for tabbar buttons
(defun tabbar-button-label (name)
 ;; redefine tabbar-button-label to eliminate 1-pixel border around images
  "Return a label for button NAME.
That is a pair (ENABLED . DISABLED), where ENABLED and DISABLED are
respectively the appearance of the button when enabled and disabled.
They are propertized strings which could display images, as specified
by the variable `tabbar-NAME-button'."
  (let* ((btn (symbol-value
               (intern-soft (format "tabbar-%s-button" name))))
         (on  (tabbar-find-image (cdar btn)))
         (off (and on (tabbar-find-image (cddr btn)))))
    (when on
      (tabbar-normalize-image on 0 t)
      (if off
          (tabbar-normalize-image off 0 t)
        ;; If there is no disabled button image, derive one from the
        ;; button enabled image.
        (setq off (tabbar-disable-image on))))
    (cons
     (propertize (or (caar btn) " ") 'display on)
     (propertize (or (cadr btn) " ") 'display off))))

(defun tabbar-buffer-button-label (name)
 ;; redefine tabbar-buffer-button-label to eliminate 1-pixel border around images
  "Return a label for button NAME.
That is a pair (ENABLED . DISABLED), where ENABLED and DISABLED are
respectively the appearance of the button when enabled and disabled.
They are propertized strings which could display images, as specified
by the variable `tabbar-button-label'.
When NAME is 'home, return a different ENABLED button if showing tabs
or groups.  Call the function `tabbar-button-label' otherwise."
  (let ((lab (tabbar-button-label name)))
    (when (eq name 'home)
      (let* ((btn tabbar-buffer-home-button)
             (on  (tabbar-find-image (cdar btn)))
             (off (tabbar-find-image (cddr btn))))
        ;; When `tabbar-buffer-home-button' does not provide a value,
        ;; default to the enabled value of `tabbar-home-button'.
        (if on
            (tabbar-normalize-image on 0 t)
          (setq on (get-text-property 0 'display (car lab))))
        (if off
            (tabbar-normalize-image off 0 t)
          (setq off (get-text-property 0 'display (car lab))))
        (setcar lab
                (if tabbar--buffer-show-groups
                    (propertize (or (caar btn) (car lab)) 'display on)
                  (propertize (or (cadr btn) (car lab)) 'display off)))
        ))
    lab))

(setq tabbar-home-button-enabled-image
  '((:type png :file "down.png")))

(setq tabbar-home-button-disabled-image
  '((:type png :file "up.png")))

(setq tabbar-home-button
  (cons (cons "[o]" tabbar-home-button-enabled-image)
        (cons "[x]" tabbar-home-button-disabled-image)))

(setq tabbar-buffer-home-button
  (cons (cons "[+]" tabbar-home-button-enabled-image)
        (cons "[-]" tabbar-home-button-disabled-image)))

(setq tabbar-scroll-left-button-enabled-image
  '((:type tiff :file "left.tiff")))

(setq tabbar-scroll-left-button-disabled-image
  '((:type tiff :file "left_disabled.tiff")))

(setq tabbar-scroll-left-button
  (cons (cons " <" tabbar-scroll-left-button-enabled-image)
        (cons " =" tabbar-scroll-left-button-disabled-image)))

(setq tabbar-scroll-right-button-enabled-image
  '((:type tiff :file "right.tiff")))

(setq tabbar-scroll-right-button-disabled-image
  '((:type tiff :file "right_disabled.tiff")))

(setq tabbar-scroll-right-button
  (cons (cons " >" tabbar-scroll-right-button-enabled-image)
        (cons " =" tabbar-scroll-right-button-disabled-image)))

(setq tabbar-close-tab-button
      '((:type tiff :file "close-tab.tiff")))

;; allow fast-clicking through lists of tabs
(defsubst tabbar-click-p (event)
  "Return non-nil if EVENT is a mouse click event."
  ;;counts as a click even if it's the last of a double- or triple-click;
  ;;allows fast cycling through tabs with the mouse.
  (and (or
	(memq 'click (event-modifiers event))
	(memq 'double (event-modifiers event))
	(memq 'triple (event-modifiers event)))
       ;; don't count double- or triple-drag events
       (not (memq 'drag (event-modifiers event))))
  )

(defun tabbar-check-overflow (tabset &optional noscroll)
  "Return t if the current tabbar is longer than the header line.
If NOSCROLL is non-nil, exclude the tabbar-scroll buttons in the
check."
  (let ((tabs (tabbar-view tabset))
	elts)
    (while tabs
      (setq elts  (cons (tabbar-line-tab (car tabs)) elts)
	    tabs  (cdr tabs)))
    (setq elts (nreverse elts))
    (with-temp-buffer
      (let ((truncate-partial-width-windows nil)
	    (inhibit-modification-hooks t)
	    deactivate-mark ;; Prevent deactivation of the mark!
	    start)
	(setq truncate-lines nil
	      buffer-undo-list t)
	(apply 'insert (tabbar-dummy-line-buttons noscroll))
	(setq start (point))
	(delete-region start (point-max))
	(goto-char (point-max))
	(apply 'insert elts)
	(goto-char (point-min))
	(> (vertical-motion 1) 0)))))

;; redefine tabbar-click-on-tab with an additional argument that can
;; trigger closing the tab instead of selecting it!
(defsubst tabbar-click-on-tab (tab &optional type action)
  "Handle a mouse click event on tab TAB.
Call `tabbar-select-tab-function' with the received, or simulated
mouse click event, and TAB.
Optional argument TYPE is a mouse click event type (see the function
`tabbar-make-mouse-event' for details)."
  (let* ((mouse-event (tabbar-make-mouse-event type))
	 (mouse-button (event-basic-type mouse-event)))
    (if (eq action 'close-tab)
	(when (and (eq mouse-button 'mouse-1) tabbar-close-tab-function)
	  (funcall tabbar-close-tab-function tab))
      (when tabbar-select-tab-function
	(funcall tabbar-select-tab-function
		 (tabbar-make-mouse-event type) tab)
	(tabbar-display-update)))))

(defun tabbar-select-tab-callback (event)
  "Handle a mouse EVENT on a tab.
Pass mouse click events on a tab to `tabbar-click-on-tab'."
  (interactive "@e")
  (when (tabbar-click-p event)
    (let ((target (posn-string (event-start event))))
      (tabbar-click-on-tab
       (get-text-property (cdr target) 'tabbar-tab (car target))
       event
       (get-text-property (cdr target) 'tabbar-action (car target))))))

(defcustom tabbar-show-key-bindings t
  "Decide whether to number the tabs showing their key bindings."
  :group 'Aquamacs)

(defsubst tabbar-line-tab (tab)
    "Return the display representation of tab TAB.
That is, a propertized string used as an `header-line-format' template
element.
Call `tabbar-tab-label-function' to obtain a label for TAB."
    (let* ((selected-p (tabbar-selected-p tab (tabbar-current-tabset)))
	   (close-button-image (tabbar-find-image tabbar-close-tab-button))
	   (mouse-face (if selected-p
			   'tabbar-selected-highlight
			 'tabbar-unselected-highlight))

	   (text-face (if selected-p
			  'tabbar-selected
			'tabbar-unselected))
	   (close-button
	    (propertize "[x]"
			'tabbar-tab tab
			'local-map (tabbar-make-tab-keymap tab)
			'tabbar-action 'close-tab
			;;	  'help-echo 'tabbar-help-on-tab ;; no help echo: it's redundant
			'mouse-face mouse-face
			'face text-face
			'pointer 'arrow
			'display (tabbar-normalize-image close-button-image 0 'nomask)))

	   (display-label
	    (propertize (if tabbar-tab-label-function
			    (funcall tabbar-tab-label-function tab)
			  tab)
			'tabbar-tab tab
			'local-map (tabbar-make-tab-keymap tab)
			;;	  'help-echo 'tabbar-help-on-tab ;; no help echo: it's redundant
			'mouse-face mouse-face
			'face (cond ((and selected-p
					  (buffer-modified-p (tabbar-tab-value tab)))
				     'tabbar-selected-modified)
				    ((and (not selected-p)
					  (buffer-modified-p (tabbar-tab-value tab)))
				     'tabbar-unselected-modified)
				    ((and selected-p
					  (not (buffer-modified-p (tabbar-tab-value tab))))
				     'tabbar-selected)
				    (t 'tabbar-unselected))
			'pointer 'arrow))
	   (key-label
	    (if (and tabbar-show-key-bindings (boundp 'tabbar-line-tabs) tabbar-line-tabs)
		(let* ((mm (member tab tabbar-line-tabs) )
		       ;; calc position (i.e., like position from cl-seq)
		       (index (if mm (- (length tabbar-line-tabs) (length mm)))))
		  (if (and index (fboundp (tabbar-key-command (+ 1 index))))
		      (propertize
		       (get (tabbar-key-command (+ 1 index)) 'label)
		       ;(format "%s" (+ 1 index))
		       'mouse-face mouse-face
		       ;; same mouse-face leads to joint mouse activation for all elements
		       'face (list 'tabbar-key-binding text-face) ;; does not work
		       )
		    "")
		  ) "")))
      (concat close-button display-label key-label tabbar-separator-value)))

(defun tabbar-dummy-line-buttons (&optional noscroll)
  "Return a list of propertized strings for placeholders for the tab bar buttons.
These are used to determine the size of the tab bar -- and hence the enabled/
disabled state of the tab bar buttons -- so they always carry a disabled state.
This avoids an infinite loop.  If NOSCROLL is non-nil, exclude the tabbar-scroll
buttons."
  (cons
   (cdr tabbar-home-button-value)
   (unless noscroll
     (list
      (cdr tabbar-scroll-left-button-value)
      (cdr tabbar-scroll-right-button-value)))))

(defun tabbar-line-separator ()
  "Return the display representation of a tab bar separator.
That is, a propertized string used as an `header-line-format' template
element."
  (let ((image (tabbar-find-image (cdr tabbar-separator))))
    ;; Cache the separator display value in variable
    ;; `tabbar-separator-value'.
    (setq tabbar-separator-value
          (cond
           (image
            (propertize " "
                        'face 'tabbar-separator
                        'pointer 'arrow
                        'display (tabbar-normalize-image image)))
           ((numberp (car tabbar-separator))
            (propertize " "
                        'face 'tabbar-separator
                        'pointer 'arrow
                        'display (list 'space
                                       :width (list (car tabbar-separator)))))
           ((propertize (or (car tabbar-separator) " ")
                        'face 'tabbar-separator
                        'pointer 'arrow))))
    ))

(defsubst tabbar-line-buttons (tabset &optional noscroll)
  "Return a list of propertized strings for tab bar buttons.
TABSET is the tab set used to choose the appropriate buttons.  If
NOSCROLL is non-nil, exclude the tabbar-scroll buttons."
  (cons
   (if tabbar-home-function
       (car tabbar-home-button-value)
     (cdr tabbar-home-button-value))
   (if noscroll
       (list (propertize " "
                        'face 'tabbar-default
                        'display (list 'space :width (list 8)))
	     ) ;; insert tabbar-separator-value here?
     (list (if (> (tabbar-start tabset) 0)
	       (car tabbar-scroll-left-button-value)
	     (cdr tabbar-scroll-left-button-value))
	   (if (tabbar-check-overflow tabset)
	       (car tabbar-scroll-right-button-value)
	     (cdr tabbar-scroll-right-button-value))
	   tabbar-separator-value))))

(defun tabbar-line-format (tabset)
    "Return the `header-line-format' value to display TABSET."
    (let* ((sel (tabbar-selected-tab tabset))
	   (tabs (tabbar-view tabset))
	   (padcolor (tabbar-background-color))
	   (noscroll t)
	   (tabbar-line-tabs (tabbar-tabs tabset))
	   atsel elts scrolled)
      ;; Initialize buttons and separator values.
      (or tabbar-separator-value
	  (tabbar-line-separator))
      (or tabbar-home-button-value
	  (tabbar-line-button 'home))
      (or tabbar-scroll-left-button-value
	  (tabbar-line-button 'scroll-left))
      (or tabbar-scroll-right-button-value
	  (tabbar-line-button 'scroll-right))
      ;; Make sure we're showing as many tabs as possible.  If we're
      ;; not showing the 1st tab, and we're not overflowing the tab
      ;; bar, then scroll backward.  If this leads to overflowing the
      ;; tab bar, scroll forward 1 at the end.
      (while (and (> (get tabset 'start) 0)
		  (not (tabbar-check-overflow tabset)))
	(tabbar-scroll tabset -1)
	(setq scrolled t))
      ;; if we scrolled until the tabbar overflowed, we went too far.
      ;; Back up 1 slot.
      (when (and scrolled (tabbar-check-overflow tabset))
	(tabbar-scroll tabset 1))
      (when (or (> (tabbar-start tabset) 0) (tabbar-check-overflow tabset))
	;; not all tabs fit -- include scroll buttons
	(setq noscroll nil))
      ;; Track the selected tab to ensure it is always visible.
      (when tabbar--track-selected
	(while (not (memq sel tabs))
	  (tabbar-scroll tabset -1)
	  (setq tabs (tabbar-view tabset)))
	(while (and tabs (not atsel))
	  (setq elts  (cons (tabbar-line-tab (car tabs)) elts)
		atsel (eq (car tabs) sel)
		tabs  (cdr tabs)))
	(setq elts (nreverse elts))
	;; At this point the selected tab is the last elt in ELTS.
	;; Scroll TABSET and ELTS until the selected tab becomes
	;; visible.

	;; because of the post-hoc scrolling,
	;; we can't determine the line index beforehand


	(with-temp-buffer
	  (let ((truncate-partial-width-windows nil)
		(inhibit-modification-hooks t)
		deactivate-mark ;; Prevent deactivation of the mark!
		start)
	    (setq truncate-lines nil
		  buffer-undo-list t)
	    (apply 'insert (tabbar-line-buttons tabset noscroll))
	    (setq start (point))
	    (while (and (cdr elts) ;; Always show the selected tab!
			(progn
			  (delete-region start (point-max))
			  (goto-char (point-max))
			  (apply 'insert elts)
			  (goto-char (point-min))
			  (> (vertical-motion 1) 0)))
	      (tabbar-scroll tabset 1)
	      (setq elts (cdr elts)))))
	(setq elts (nreverse elts))
	(setq tabbar--track-selected nil))
      ;; Format remaining tabs.
      (while tabs
	(setq elts (cons (tabbar-line-tab (car tabs)) elts)
	      tabs (cdr tabs)))
      ;; Cache and return the new tab bar.
      (tabbar-set-template
       tabset
       (list (tabbar-line-buttons tabset noscroll)
	     (nreverse elts)
	     (propertize "%-"
			 'face (list :inherit 'tabbar-default
				     :background padcolor
				     :foreground padcolor)
			 'pointer 'arrow
			 'local-map (tabbar-make-tab-keymap "empty tab bar"))))
      ))

(defun tabbar-reformat-tabset (tabset)
  (tabbar-set-template tabset nil))

(defun tabbar-reformat-all-tabsets ()
  (tabbar-map-tabsets 'tabbar-reformat-tabset))


;; to do:
;; tabbar-expand should really be done in `tabbar-line-tab' or afterwards,
;; because only then do we know how wide (in pixels) the tab is going to be
;; as it stands, we're duplicating some functions (buffer-modified check, e.g.)
;; and we're just guessing what face is going to be used.

(defvar tabbar-char-width 5)
;; (defun tabbar-char-width (&optional tab)
;;   "Big Hack."
;;   ;; average width of Lucida Grande character. Hack!
;;   (if (and tab (buffer-modified-p (tabbar-tab-value tab)))
;;       7  ;; in bold
;;     5))

(defun tabbar-expand (str width &optional tab)
    "Return an expanded string from STR that fits in the given display WIDTH.
WIDTH is specified in terms of character display width in the current
buffer; see also `char-width'."

    (let* ((n  (length str))
	   (sw (string-width str))
	   (el "...")
	   (ew (string-width el))
	   (w  0)
	   (i  0))
      (cond
       ((< sw width)
	(let* ((l-l (max 4 (min (- 75 (/ (* tabbar-char-width n) 2) )
				(floor (/ (* (frame-char-width)
					     (- width sw)) 2)))))
	       (sp-r  (propertize
		       " " 'display
		       `(space
			 :width
			 ;; subtract width of numbers
			 (, (max 4 (- l-l
				      (if tabbar-show-key-bindings
					  7 0)))))))
	       (sp-l  (propertize
		       " " 'display
		       `(space
			 :width
			 ;; subtract the width of closer button. hard-coded for speed.
			 (,(max 4 (- l-l 14)))))))
	  (concat sp-l str sp-r)))
       (t str))))


;; function to unconditionally open a new tab
(defun new-tab (&optional major-mode)
  "Creates a new tab.
Turns on `tabbar-mode'."
  (interactive)
  (fast-screen-refresh
    (tabbar-mode 1)
    (tabbar-new-tab major-mode)))

(defun new-tab-or-buffer (&optional mode)
  "Calls tabbar-new-tab-function if tabbar-mode is on; otherwise,
creates a new buffer.  Mode for new buffer can optionally be specified."
    (interactive)
  (if (and (boundp tabbar-mode) tabbar-mode)
       (fast-screen-refresh
	(funcall tabbar-new-tab-function mode))
    (new-frame-with-new-scratch one-buffer-one-frame mode)))

(defun next-tab-or-buffer ()
  "Call (tabbar-forward) if tabbar-mode is on; otherwise, call (next-buffer)."
  (interactive)
  (fast-screen-refresh
    (if (and (boundp tabbar-mode) tabbar-mode)
	(tabbar-forward)
      (next-buffer))))

(defun previous-tab-or-buffer ()
  "Call (tabbar-forward) if tabbar-mode is on; otherwise, call (next-buffer)."
  (interactive)
  (fast-screen-refresh
    (if (and (boundp tabbar-mode) tabbar-mode)
	(tabbar-backward)
      (previous-buffer))))

;;; Tabbar-Mwheel mode: redefine mwheel actions
;
(defcustom tabbar-mwheel-mode-action nil
 "*Specify the behavior mouse wheel is used in tab bar.
The following options are available:

- `cycle-tabs'
   Mouse wheel down/up selects next/previous tab in window's tab set.
- default
   Mouse wheel scrolls current buffer."
 :group 'tabbar
 :type '(choice :tag "Mouse wheel in tab bar..."
                (const :tag "Cycles through tabs" cycle-tabs)
                (const :tag "Scrolls current buffer" nil)))

(defun tabbar-mwheel-up-action (event)
 (interactive "@e")
 (if tabbar-mwheel-mode-action
     (tabbar-mwheel-forward-tab event)
   (mwheel-scroll event)))

(defun tabbar-mwheel-down-action (event)
 (interactive "@e")
 (if tabbar-mwheel-mode-action
     (tabbar-mwheel-backward-tab event)
   (mwheel-scroll event)))

(if (get 'mouse-wheel 'event-symbol-elements)
   ;; Use one generic mouse wheel event
   (define-key tabbar-mwheel-mode-map [A-mouse-wheel]
     'tabbar-mwheel-switch-tab)
 ;; Use separate up/down mouse wheel events
 (let ((up   (tabbar--mwheel-key tabbar--mwheel-up-event))
	(down (tabbar--mwheel-key tabbar--mwheel-down-event)))
   (define-key tabbar-mwheel-mode-map `[header-line ,down]
     'tabbar-mwheel-down-action)
   (define-key tabbar-mwheel-mode-map `[header-line ,up]
     'tabbar-mwheel-up-action)
   (define-key tabbar-mwheel-mode-map `[header-line (control ,down)]
     nil)
   (define-key tabbar-mwheel-mode-map `[header-line (control ,up)]
     nil)
   (define-key tabbar-mwheel-mode-map `[header-line (shift ,down)]
     nil)
   (define-key tabbar-mwheel-mode-map `[header-line (shift ,up)]
     nil)))


(defun tabbar-order-tabs-by-file ()
  (interactive)
  (tabbar-order-by-fun 'tabbar--order-by-buffer-path))

(defun tabbar-order-by-file-type ()
  (interactive)
  (tabbar-order-by-fun 'tabbar--order-by-file-type))

(defun tabbar-reverse-tabs ()
  (interactive)
  (tabbar-order-by-fun 'reverse))

(defun tabbar-order-by-fun (fun)
  (let* ((tabset (tabbar-current-tabset)))

    (setf (symbol-value tabset)
	  (funcall fun (tabbar-tabs tabset))))
  (tabbar-window-update-tabsets)
)

(defun tabbar--order-by-buffer-path (list)
  (sort list (lambda (a b)
	       (string-lessp (tabbar--path a) (tabbar--path b))))
)

(defun tabbar--order-by-file-type (list)
  (sort list (lambda (a b)
	       (let* ((a (tabbar--path a)) (b (tabbar--path b))
		      (ae (file-name-extension a))
		      (be  (file-name-extension b)))
		 (if (string= ae be)
		     (string-lessp a b)
		   (string-lessp ae be))))
))

(defun tabbar--path (el)
  (let ((buffer (car el)))
    (buffer-file-name buffer)))

;; (symbol-value (tabbar-current-tabset))
;; (tabbar-line-format (tabbar-get-tabset (number-to-string (window-number (selected-window)))))
;; (tabbar-tabs                                (tabbar-current-tabset))

;; default tabbar behavior (buffer tabs grouped by major-mode) can be
;;  retained by setting tabbar-inhibit-window-tabs to non-nil
;; (unless (and (boundp 'tabbar-inhibit-window-tabs) tabbar-inhibit-window-tabs)
;;   ;; changes behavior of "buffer tabs", so that tabs are associated with a
;;   ;;   window instead of a major mode.
;;   (require 'tabbar-window))

;; will have to do a bit more work to make different tabbar styles work smoothly.
;; (i.e., no conditional loading of lisp!)
;; for now, stick with window tabs
(condition-case nil
(require 'tabbar-window)
(error nil))

;; start out with hidden window
(add-hook 'after-init-hook
	  (lambda ()
	    (if tabbar-mode
		(add-to-list
		 'header-line-inhibit-window-list
		 (selected-window))) 'append))


(provide 'aquamacs-tabbar)
