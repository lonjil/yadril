;;;; This file is part of cl-charms, providing CFFI bindings to libcurses.
;;;;
;;;; Copyright (c) 2010 Abhishek Reddy <http://abhishek.geek.nz>
;;;;
;;;; This file includes portions of code from cl-ncurses, an ncurses
;;;; interface for Common Lisp.  The copyright notices from cl-ncurses
;;;; are reproduced below.
;;;;
;;;; Copyright (c) 2003 Nikodemus Siivola
;;;; Copyright (c) 2004 Marcelo Ramos <mramos@montevideo.com.uy>
;;;; Copyright (c) 2007 Jacob Gabrielson <jacobg23@pobox.com>
;;;;
;;;; Permission is hereby granted, free of charge, to any person obtaining
;;;; a copy of this software and associated documentation files (the
;;;; "Software"), to deal in the Software without restriction, including
;;;; without limitation the rights to use, copy, modify, merge, publish,
;;;; distribute, sublicense, and/or sell copies of the Software, and to
;;;; permit persons to whom the Software is furnished to do so, subject to
;;;; the following conditions:
;;;;
;;;; The above copyright notice and this permission notice shall be included
;;;; in all copies or substantial portions of the Software.
;;;;
;;;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;;;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;;;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
;;;; IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
;;;; CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
;;;; TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
;;;; SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


(cl:in-package :cl-charms)

(define-foreign-library libcurses
    (:unix (:or "libcurses.so" "libncurses.so"))
  (t (:default "curses")))
   
(use-foreign-library libcurses)


;; The following definitions are largely direct translations of UFFI
;; definitions from cl-ncurses.  That includes constants, feature
;; conditionals and relevant comments.


;; Based on `def' from cl-ncurses
(defmacro define-exported-cfuns (names &body body)
  "Define libcurses functions using cffi:defcfun.  If given multiple names,
   define each as a distinct C function but otherwise with the same signature.
   The resulting function names are exported from the current package."
  `(progn
     ,@(loop :for name :in names
             :collect `(export (defcfun ,name ,@body)))))

(defmacro define-exported-constant (&body body)
  `(export (define-constant ,@body)))


;; types
(defctype bool :int)
(defctype char-ptr :pointer)
(defctype chtype :int)
(defctype file-ptr :pointer)
(defctype screen-ptr :pointer)
(defctype window-ptr :pointer)


;; add_wch
; TODO
; C Prototype: int add_wch( const cchar_t *wch );
; C Prototype: int wadd_wch( WINDOW *win, const cchar_t *wch );
; C Prototype: int mvadd_wch( int y, int x, const cchar_t *wch );
; C Prototype: int mvwadd_wch( WINDOW *win, int y, int x, const cchar_t *wch );
; C Prototype: int echo_wchar( const cchar_t *wch );
; C Prototype: int wecho_wchar( WINDOW *win, const cchar_t *wch );


;; add_wchstr
; TODO
; C Prototype: int add_wchstr(const cchar_t *wchstr);
; C Prototype: int add_wchnstr(const cchar_t *wchstr, int n);
; C Prototype: int wadd_wchstr(WINDOW * win, const cchar_t *wchstr);
; C Prototype: int wadd_wchnstr(WINDOW * win, const cchar_t *wchstr, int n);
; C Prototype: int mvadd_wchstr(int y, int x, const cchar_t *wchstr);
; C Prototype: int mvadd_wchnstr(int y, int x, const cchar_t *wchstr, int n);
; C Prototype: int mvwadd_wchstr(WINDOW *win, int y, int x, const cchar_t *wchstr);
; C Prototype: int mvwadd_wchnstr(WINDOW *win, int y, int x, const cchar_t *wchstr, int n);


;; addch
(define-exported-cfuns ("addch" "echochar")
    :int
  (ch chtype))

(define-exported-cfuns ("waddch" "wechochar")
    :int
  (win window-ptr)
  (ch chtype))

(define-exported-cfuns ("mvaddch")
    :int
  (y :int)
  (x :int)
  (ch chtype))


;; addchstr
; TODO
; C Prototype: int addchstr(const chtype *chstr);
; C Prototype: int addchnstr(const chtype *chstr, int n);
; C Prototype: int waddchstr(WINDOW *win, const chtype *chstr);

; C Prototype: int waddchnstr(WINDOW *win, const chtype *chstr, int n);
; C Prototype: int mvaddchstr(int y, int x, const chtype *chstr);
; C Prototype: int mvaddchnstr(int y, int x, const chtype *chstr, int n);
; C Prototype: int mvwaddchstr(WINDOW *win, int y, int x, const chtype *chstr);
; C Prototype: int mvwaddchnstr(WINDOW *win, int y, int x, const chtype *chstr, int n);


;; addstr
(define-exported-cfuns ("addstr")
    :int
  (str :string))

(define-exported-cfuns ("addnstr")
    :int
  (str :string)
  (n :int))

(define-exported-cfuns ("waddstr")
    :int
  (win window-ptr)
  (str :string))

(define-exported-cfuns ("waddnstr")
    :int
  (win window-ptr)
  (str :string)
  (n :int))

(define-exported-cfuns ("mvaddstr")
    :int
  (y :int)
  (x :int)
  (str :string))

(define-exported-cfuns ("mvaddnstr")
    :int
  (y :int)
  (x :int)
  (str :string)
  (n :int))

(define-exported-cfuns ("mvwaddstr")
    :int
  (win window-ptr)
  (y :int)
  (x :int)
  (str :string))

(define-exported-cfuns ("mvwaddnstr")
    :int
  (win window-ptr)
  (y :int)
  (x :int)
  (str :string)
  (n :int))


;; addwstr
; TODO
; C Prototype: int addwstr(const wchar_t *wstr);
; C Prototype: int addnwstr(const wchar_t *wstr, int n);
; C Prototype: int waddwstr(WINDOW *win, const wchar_t *wstr);
; C Prototype: int waddnwstr(WINDOW *win, const wchar_t *wstr, int n);
; C Prototype: int mvaddwstr(int y, int x, const wchar_t *wstr);
; C Prototype: int mvaddnwstr(int y, int x, const wchar_t *wstr, int n);
; C Prototype: int mvwaddwstr(WINDOW *win, int y, int x, const wchar_t *wstr);
; C Prototype: int mvwaddnwstr(WINDOW *win, int y, int x, const wchar_t *wstr, int n);


;; attr
(define-exported-cfuns ("attroff" "attron" "attrset")
    :int
  (attrs :int))

(define-exported-cfuns ("wattrof" "wattron" "wattrset")
    :int
  (win window-ptr)
  (attrs :int))

(define-exported-cfuns ("color_set")
    :int
  (color_pair_number :short)
  (opts :pointer))

(define-exported-cfuns ("wcolor_set")
    :int
  (win window-ptr)
  (color :short)
  (opts :pointer))

(define-exported-cfuns ("standend" "standout")
    :int)

(define-exported-cfuns ("wstandend" "wstandout")
    :int)

; TODO
; We need to define a attr_t structure type......
; C Prototype: int attr_get(attr_t *attrs, short *pair, void *opts);
; C Prototype: int wattr_get(WINDOW *win, attr_t *attrs, short *pair, void *opts);
; C Prototype: int attr_off(attr_t attrs, void *opts);
; C Prototype: int wattr_off(WINDOW *win, attr_t attrs, void *opts);
; C Prototype: int attr_on(attr_t attrs, void *opts);
; C Prototype: int wattr_on(WINDOW *win, attr_t attrs, void *opts);
; C Prototype: int attr_set(attr_t attrs, short pair, void *opts);
; C Prototype: int wattr_set(WINDOW *win, attr_t attrs, short pair, void *opts);
; C Prototype: int chgat(int n, attr_t attr, short color, const void *opts)
; C Prototype: int wchgat(WINDOW *win, int n, attr_t attr, short color, const void *opts)
; C Prototype: int mvchgat(int y, int x, int n, attr_t attr, short color, const void *opts)
; C Prototype: int mvwchgat(WINDOW *win, int y, int x, int n, attr_t attr, short color, const void *opts)


;; beep
(define-exported-cfuns ("beep" "flash")
    :int)


;; bkgd
(define-exported-cfuns ("bkgdset")
    :void
  (ch chtype))

(define-exported-cfuns ("bkgd")
    :int
  (ch chtype))

(define-exported-cfuns ("wbkgdset")
    :void
  (win window-ptr)
  (ch chtype))

(define-exported-cfuns ("wbkgd")
    :int
  (win window-ptr)
  (ch chtype))

(define-exported-cfuns ("getbkgd")
    chtype
  (win window-ptr))


;; bkgrnd
; TODO
; C Prototype: int bkgrnd( const cchar_t *wch);
; C Prototype: int wbkgrnd( WINDOW *win, const cchar_t *wch);
; C Prototype: void bkgrndset(const cchar_t *wch );
; C Prototype: void wbkgrndset(WINDOW *win, const cchar_t *wch);
; C Prototype: int getbkgrnd(cchar_t *wch);
; C Prototype: int wgetbkgrnd(WINDOW *win, cchar_t *wch);


;;
(define-exported-cfuns ("border")
    :int
  (ls chtype)
  (rs chtype)
  (ts chtype)
  (bs chtype)
  (tl chtype)
  (tr chtype)
  (bl chtype)
  (br chtype))

(define-exported-cfuns ("wborder")
    :int
  (win window-ptr)
  (ls chtype)
  (rs chtype)
  (ts chtype)
  (bs chtype)
  (tl chtype)
  (tr chtype)
  (bl chtype)
  (br chtype))

(define-exported-cfuns ("box")
    :int
  (win window-ptr)
  (verch chtype)
  (horch chtype))

(define-exported-cfuns ("hline" "vline")
    :int
  (ch chtype)
  (n :int))

(define-exported-cfuns ("whline" "wvline")
    :int
  (win window-ptr)
  (ch chtype)
  (n :int))

(define-exported-cfuns ("mvhline" "mvvline")
    :int
  (y :int)
  (x :int)
  (ch chtype)
  (n :int))

(define-exported-cfuns ("mvwhline" "mvwvline")
    :int
  (win window-ptr)
  (y :int)
  (x :int)
  (ch chtype)
  (n :int))


;; border_set
; TODO
; cchar_t * ???
; C Prototype: int border_set(
;	  const cchar_t *ls, const cchar_t *rs,
;	  const cchar_t *ts, const cchar_t *bs,
;         const cchar_t *tl, const cchar_t *tr,
;	  const cchar_t *bl, const cchar_t *br );
; C Prototype: int wborder_set(
;	  WINDOW *win,
;	  const cchar_t *ls, const cchar_t *rs,
;	  const cchar_t *ts, const cchar_t *bs,
;	  const cchar_t *tl, const cchar_t *tr,
;	  const cchar_t *bl, const cchar_t *br);
; C Prototype: int box_set(
;	  WINDOW *win,
;	  const cchar_t *verch,
;	  const cchar_t *horch);
; C Prototype: int hline_set(
;	  const cchar_t *wch, int n);
; C Prototype: int whline_set(
;	  WINDOW *win,
;	  const cchar_t *wch, int n);
; C Prototype: int mvhline_set(
;         int y, int x,
;	  const cchar_t *wch, int n);
; C Prototype: int mvwhline_set(
;	  WINDOW *win,
;         int y, int x,
;	  const cchar_t *wch, int n);
; C Prototype: int vline_set(
;	  const cchar_t *wch, int n);
; C Prototype: int wvline_set(
;	  WINDOW *win,
;	  const cchar_t *wch, int n);
; C Prototype: int mvvline_set(
;         int y, int x,
;	  const cchar_t *wch, int n);
; C Prototype: int mvwvline_set(
;	  WINDOW *win,
;         int y, int x,
;	  const cchar_t *wch, int n);


;; clear
(define-exported-cfuns ("erase" "clear" "clrtobot" "clrtoeol")
    :int)

(define-exported-cfuns ("werase" "wclear" "wclrtobot" "wclrtoeol")
    :int
  (win window-ptr))


;; color
(define-exported-cfuns ("start_color")
    :int)

#-(or win32 mswindows)
(define-exported-cfuns ("COLOR_PAIR")
    :int
  (pair :int))
;;; Win32 TODO: implement defun based on macro in pdcurses' curses.h

(define-exported-cfuns ("init_pair")
    :int
  (pair :short)
  (f :short)
  (b :short))

(define-exported-cfuns ("init_color")
    :int
  (color :short)
  (r :short)
  (g :short)
  (b :short))

(define-exported-cfuns ("has_colors" "can_change_color")
    bool)

(define-exported-cfuns ("color_content")
    :int
  (color :int)
  (r (:pointer :short))
  (g (:pointer :short))
  (b (:pointer :short)))

(define-exported-cfuns ("pair_content")
    :int
  (pair :short)
  (f (:pointer :short))
  (b (:pointer :short)))


;; constants
; Predefined colors
(define-exported-constant COLOR_BLACK 0)
(define-exported-constant COLOR_RED 1)
(define-exported-constant COLOR_GREEN 2)
(define-exported-constant COLOR_YELLOW 3)
(define-exported-constant COLOR_BLUE 4)
(define-exported-constant COLOR_MAGENTA 5)
(define-exported-constant COLOR_CYAN 6)
(define-exported-constant COLOR_WHITE 7)

(define-exported-constant TRUE 1)
(define-exported-constant FALSE 0)
(define-exported-constant ERR -1)
(define-exported-constant OK 0)
(define-exported-constant KEY_RESIZE 0632)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; XSI attributes.  In the ncurses implementation, they are identical to the   ;;
; A_ attributes.                                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-exported-constant WA_ATTRIBUTES #xffffff00)
(define-exported-constant WA_ATTRIBUTES #xffffff00)
(define-exported-constant WA_NORMAL #x00000000)
(define-exported-constant WA_STANDOUT #x00010000)
(define-exported-constant WA_UNDERLINE #x00020000)
(define-exported-constant WA_REVERSE #x00040000)
(define-exported-constant WA_BLINK #x00080000)
(define-exported-constant WA_DIM #x00100000)
(define-exported-constant WA_BOLD #x00200000)
(define-exported-constant WA_ALTCHARSET #x00400000)
(define-exported-constant WA_INVIS #x00800000)
(define-exported-constant WA_PROTECT #x01000000)
(define-exported-constant WA_HORIZONTAL #x02000000) ;XSI Curses attr -- not yet used 
(define-exported-constant WA_LEFT #x04000000) ;XSI Curses attr -- not yet used 
(define-exported-constant WA_LOW #x08000000) ;XSI Curses attr -- not yet used 
(define-exported-constant WA_RIGHT #x10000000) ;XSI Curses attr -- not yet used 
(define-exported-constant WA_TOP #x20000000) ;XSI Curses attr -- not yet used 
(define-exported-constant WA_VERTICAL #x40000000) ;XSI Curses attr -- not yet used 

(define-exported-constant A_ATTRIBUTES #xffffff00)
(define-exported-constant A_ATTRIBUTES #xffffff00)
(define-exported-constant A_NORMAL #x00000000)
(define-exported-constant A_STANDOUT #x00010000)
(define-exported-constant A_UNDERLINE #x00020000)
(define-exported-constant A_REVERSE #x00040000)
(define-exported-constant A_BLINK #x00080000)
(define-exported-constant A_DIM #x00100000)
(define-exported-constant A_BOLD #x00200000)
(define-exported-constant A_ALTCHARSET #x00400000)
(define-exported-constant A_INVIS #x00800000)
(define-exported-constant A_PROTECT #x01000000)
(define-exported-constant A_HORIZONTAL #x02000000) ;XSI Curses attr -- not yet used 
(define-exported-constant A_LEFT #x04000000) ;XSI Curses attr -- not yet used 
(define-exported-constant A_LOW #x08000000) ;XSI Curses attr -- not yet used 
(define-exported-constant A_RIGHT #x10000000) ;XSI Curses attr -- not yet used 
(define-exported-constant A_TOP #x20000000) ;XSI Curses attr -- not yet used 
(define-exported-constant A_VERTICAL #x40000000) ;XSI Curses attr -- not yet used 

; VT100 symbols
(define-exported-constant ACS_ULCORNER #\l) ; upper left corner
(define-exported-constant ACS_LLCORNER #\m) ; lower left corner 
(define-exported-constant ACS_URCORNER #\k) ; upper right corner 
(define-exported-constant ACS_LRCORNER #\j) ; lower right corner 
(define-exported-constant ACS_LTEE #\t) ; tee pointing right 
(define-exported-constant ACS_RTEE #\u) ; tee pointing left 
(define-exported-constant ACS_BTEE #\v) ; tee pointing up 
(define-exported-constant ACS_TTEE #\w) ; tee pointing down 
(define-exported-constant ACS_HLINE #\q) ; horizontal line 
(define-exported-constant ACS_VLINE #\x) ; vertical line 
(define-exported-constant ACS_PLUS #\n) ; large plus or crossover 
(define-exported-constant ACS_S1 #\o) ; scan line 1 
(define-exported-constant ACS_S9 #\s) ; scan line 9 
(define-exported-constant ACS_DIAMOND #\`) ; diamond 
(define-exported-constant ACS_CKBOARD #\a) ; checker board (stipple) 
(define-exported-constant ACS_DEGREE #\f) ; degree symbol 
(define-exported-constant ACS_PLMINUS #\g) ; plus/minus 
(define-exported-constant ACS_BULLET #\~) ; bullet 


;; default_colors
(define-exported-cfuns ("use_default_colors")
    :int)

(define-exported-cfuns ("assume_default_colors")
    :int
  (fg :int)
  (bg :int))


;; delch
(define-exported-cfuns ("delch")
    :int)

(define-exported-cfuns ("wdelch")
    :int
  (win window-ptr))

(define-exported-cfuns ("mvdelch")
    :int
  (y :int)
  (x :int))

(define-exported-cfuns ("mvwdelch")
    :int
  (win window-ptr)
  (y :int)
  (x :int))


;; deleteln
(define-exported-cfuns ("deleteln" "insertln")
    :int)

(define-exported-cfuns ("wdeleteln" "winsertln")
    :int
  (win window-ptr))

(define-exported-cfuns ("insdelln")
    :int
  (n :int))

(define-exported-cfuns ("winsdelln")
    :int
  (win window-ptr)
  (n :int))


;; extensions
(define-exported-cfuns ("curses_version")
    :string)

#-(or win32 mswindows) ;; doesn't exist in pdcurses
(define-exported-cfuns ("use_extended_names")
    :int
  (enable bool))


;; get_wch
; TODO

; C Prototype: int get_wch(wint_t *wch);
; C Prototype: int wget_wch(WINDOW *win, wint_t *wch);
; C Prototype: int mvget_wch(int y, int x, wint_t *wch);
; C Prototype: int mvwget_wch(WINDOW *win, int y, int x, wint_t *wch);
; C Prototype: int unget_wch(const wchar_t wch);


;; get_wstr
; TODO
; C Prototype: int get_wstr(wint_t *wstr);
; C Prototype: int getn_wstr(wint_t *wstr, int n);
; C Prototype: int wget_wstr(WINDOW *win, wint_t *wstr);
; C Prototype: int wgetn_wstr(WINDOW *win, wint_t *wstr, int n);
; C Prototype: int mvget_wstr(int y, int x, wint_t *wstr);
; C Prototype: int mvgetn_wstr(int y, int x, wint_t *wstr, int n);
; C Prototype: int mvwget_wstr(WINDOW *win, int y, int x, wint_t *wstr);
; C Prototype: int mvwgetn_wstr(WINDOW *win, int y, int x, wint_t *wstr, int n);


;; getcchar
; TODO
; C Prototype: int getcchar(
;	       const cchar_t *wcval,
;	       wchar_t *wch,
;	       attr_t *attrs,
;	       short *color_pair,
;	       void *opts );

; C Prototype: int setcchar(
;	       cchar_t *wcval,
;	       const wchar_t *wch,
;	       const attr_t attrs,
;	       short color_pair,
;	       void *opts );


;; getch
(define-exported-cfuns ("wgetch")
    :int
  (win window-ptr))

#-(or win32 mswindows) ;; macro in pdcurses
(define-exported-cfuns ("getch")
    :int)

#+(or win32 mswindows)
(defun getch ()
  (wgetch *stdscr*))

(define-exported-cfuns ("mvgetch")
    :int
  (y :int)
  (x :int))

(define-exported-cfuns ("mvwgetch")
    :int
  (win window-ptr)
  (y :int)
  (x :int))

(define-exported-cfuns (#-(or win32 mswindows)
             "ungetch"
           #+(or win32 mswindows)
           "PDC_ungetch"
           "has_key")
    :int
  (ch :int))

#+(or win32 mswindows)
(defun ungetch (ch)
  (PDC_ungetch ch))


;; getstr
(define-exported-cfuns ("getstr")
    :int
  (str :string))

(define-exported-cfuns ("getnstr")
    :int
  (str :string)
  (n :int))

(define-exported-cfuns ("wgetstr")
    :int
  (win window-ptr)
  (str :string))

(define-exported-cfuns ("wgetnstr")
    :int
  (win window-ptr)
  (str :string)
  (n :int))

(define-exported-cfuns ("mvgetstr")
    :int
  (y :int)
  (x :int)
  (str :string))

(define-exported-cfuns ("mvwgetstr")
    :int
  (win window-ptr)
  (y :int)
  (x :int)
  (str :string))

(define-exported-cfuns ("mvgetnstr")
    :int
  (y :int)
  (x :int)
  (str :string)
  (n :int))

(define-exported-cfuns ("mvwgetnstr")
    :int
  (win window-ptr)
  (y :int)
  (x :int)
  (str :string)
  (n :int))


;; getyx
(define-exported-cfuns ("getcurx" "getcury" "getbegx" "getbegy"
           "getmaxx" "getmaxy" "getparx" "getpary")
    :int
  (win window-ptr))

(defmacro generate-getyx-macro (name yfun xfun values-function-name)
  `(progn
     (defmacro ,name (win y x)
       (let ((win-value (gensym)))
         `(let ((,win-value ,win))
            (setf ,y (,',yfun ,win-value))
            (setf ,x (,',xfun ,win-value)))))

     (defun ,values-function-name (win)
       (values (,yfun win) (,xfun win)))

     (export '(,name ,values-function-name))))

(defmacro generate-getyx-macros (&rest names)
  `(progn
     ,@(mapcar #'(lambda (args)
                   `(generate-getyx-macro ,@args))
               names)))

(generate-getyx-macros (getyx getcury getcurx get-yx)
                       (getparyx getpary getparx get-paryx)
                       (getmaxyx getmaxy getmaxx get-maxyx)
                       (getbegyx getbegy getbegx get-begyx))


;; in_wch
; TODO
; C-prototype: int in_wch(cchar_t *wcval);
; C-prototype: int mvin_wch(int y, int x, cchar_t *wcval);
; C-prototype: int mvwin_wch(WINDOW *win, int y, int x, cchar_t *wcval);
; C-prototype: int win_wch(WINDOW *win, cchar_t *wcval);


;; in_wchstr
; TODO
; C-prototype: int in_wchstr(cchar_t *wchstr);
; C-prototype: int in_wchnstr(cchar_t *wchstr, int n);
; C-prototype: int win_wchstr(WINDOW *win, cchar_t *wchstr);
; C-prototype: int win_wchnstr(WINDOW *win, cchar_t *wchstr, int n);
; C-prototype: int mvin_wchstr(int y, int x, cchar_t *wchstr);
; C-prototype: int mvin_wchnstr(int y, int x, cchar_t *wchstr, int n);
; C-prototype: int mvwin_wchstr(WINDOW *win, int y, int x, cchar_t *wchstr);
; C-prototype: int mvwin_wchnstr(WINDOW *win, int y, int x, cchar_t *wchstr, int n);


;; inch
(define-exported-cfuns ("inch")
    chtype)

(define-exported-cfuns ("winch")
    chtype
  (win window-ptr))

(define-exported-cfuns ("mvinch")
    chtype
  (y :int)
  (x :int))

(define-exported-cfuns ("mvwinch")
    chtype
  (win window-ptr)
  (y :int)
  (x :int))


;; inchstr
(define-exported-cfuns ("inchstr")
    :int
  (chstr char-ptr))

(define-exported-cfuns ("inchnstr")
    :int
  (chstr char-ptr)
  (n :int))

(define-exported-cfuns ("winchstr")
    :int
  (win window-ptr)
  (chstr char-ptr))

(define-exported-cfuns ("winchnstr")
    :int
  (win window-ptr)
  (chstr char-ptr)
  (n :int))

(define-exported-cfuns ("mvinchstr")
    :int
  (y :int)
  (x :int)
  (chstr char-ptr))

(define-exported-cfuns ("mvwinchstr")
    :int
  (win window-ptr)
  (y :int)
  (x :int)
  (chstr char-ptr))

(define-exported-cfuns ("mvwinchnstr")
    :int
  (win window-ptr)
  (y :int)
  (x :int)
  (chstr char-ptr)
  (n :int))


;; initscr
(define-exported-cfuns ("initscr")
    window-ptr)

(define-exported-cfuns ("endwin")
    :int)

(define-exported-cfuns ("isendwin")
    bool)

(define-exported-cfuns ("newterm")
    screen-ptr
  (type char-ptr)
  (outfd file-ptr)
  (infd file-ptr))

(define-exported-cfuns ("set_term")
    screen-ptr
  (new screen-ptr))

(define-exported-cfuns ("delscreen")
    :void
  (sp screen-ptr))


;; inopts
(define-exported-cfuns ("cbreak" "nocbreak" "echo" "noecho" "raw" "noraw")
    :int)

(define-exported-cfuns ("halfdelay")
    :int
  (tenths :int))

(define-exported-cfuns ("intrflush" "keypad" "meta" "nodelay" "notimeout")
    :int
  (window window-ptr)
  (bf bool))

(define-exported-cfuns ("noqiflush" "qiflush")
    :void)

(define-exported-cfuns ("timeout")
    :void
  (delay :int))

(define-exported-cfuns ("wtimeout")
    :void
  (win window-ptr)
  (delay :int))

(define-exported-cfuns ("typeahead")
    :int
  (fd :int))


;; ins_wch
; TODO
; C-prototype: int ins_wch(const cchar_t *wch);
; C-prototype: int wins_wch(WINDOW *win, const cchar_t *wch);
; C-prototype: int mvins_wch(int y, int x, const cchar_t *wch);
; C-prototype: int mvwins_wch(WINDOW *win, int y, int x, const cchar_t *wch);


;; ins_wstr
; TODO
; C-prototype: int ins_wstr(const wchar_t *wstr);
; C-prototype: int ins_nwstr(const wchar_t *wstr, int n);
; C-prototype: int wins_wstr(WINDOW *win, const wchar_t *wstr);
; C-prototype: int wins_nwstr(WINDOW *win, const wchar_t *wstr, int n);
; C-prototype: int mvins_wstr(int y, int x, const wchar_t *wstr);
; C-prototype: int mvins_nwstr(int y, int x, const wchar_t *wstr, int n);
; C-prototype: int mvwins_wstr(WINDOW *win, int y, int x, const wchar_t *wstr);
; C-prototype: int mvwins_nwstr(WINDOW *win, int y, int x, const wchar_t *wstr, int n);


;; insch
(define-exported-cfuns ("insch")
    :int
  (ch chtype))

(define-exported-cfuns ("winsch")
    :int
  (win window-ptr)
  (ch chtype))

(define-exported-cfuns ("mvinsch")
    :int
  (y :int)
  (x :int)
  (ch chtype))

(define-exported-cfuns ("mvwinsch")
    :int
  (win window-ptr)
  (y :int)
  (x :int)
  (ch chtype))


;; insstr
(define-exported-cfuns ("insstr")
    :int
  (str :string))

(define-exported-cfuns ("insnstr")
    :int
  (str :string)
  (n :int))

(define-exported-cfuns ("winsstr")
    :int
  (win window-ptr)
  (str :string))

(define-exported-cfuns ("winsnstr")
    :int
  (win window-ptr)
  (str :string)
  (n :int))

(define-exported-cfuns ("mvinsstr")
    :int
  (y :int)
  (x :int)
  (str :string))

(define-exported-cfuns ("mvinsnstr")
    :int
  (y :int)
  (x :int)
  (str :string)
  (n :int))

(define-exported-cfuns ("mvwinsstr")
    :int
  (win window-ptr)
  (y :int)
  (x :int)
  (str :string))

(define-exported-cfuns ("mvwinsnstr")
    :int
  (win window-ptr)
  (y :int)
  (x :int)
  (str :string)
  (n :int))


;; instr
(define-exported-cfuns ("instr")
    :int
  (str :string))

(define-exported-cfuns ("innstr")
    :int
  (str :string)
  (n :int))

(define-exported-cfuns ("winstr")
    :int
  (win window-ptr)
  (str :string))

(define-exported-cfuns ("winnstr")
    :int
  (win window-ptr)
  (str :string)
  (n :int))

(define-exported-cfuns ("mvinstr")
    :int
  (y :int)
  (x :int)
  (str :string))

(define-exported-cfuns ("mvinnstr")
    :int
  (y :int)
  (x :int)
  (str :string)
  (n :int))


;; inwstr
; TODO
; C-prototype: int inwstr(wchar_t *str);
; C-prototype: int innwstr(wchar_t *str, int n);
; C-prototype: int winwstr(WINDOW *win, wchar_t *str);
; C-prototype: int winnwstr(WINDOW *win, wchar_t *str, int n);
; C-prototype: int mvinwstr(int y, int x, wchar_t *str);
; C-prototype: int mvinnwstr(int y, int x, wchar_t *str, int n);
; C-prototype: int mvwinwstr(WINDOW *win, int y, int x, wchar_t *str);
; C-prototype: int mvwinnwstr(WINDOW *win, int y, int x, wchar_t *str, int n);


;; kernel
(define-exported-cfuns ("def_prog_mode" "def_shell_mode" "reset_prog_mode"
           "reset_shell_mode" "resetty" "savetty")
    :int)

;; Something about getsyx/setsyx and ripoffline.  Definitions look either
;; broken or missing in cl-ncurses.
;;   -- arbscht 2010-10-26

(define-exported-cfuns ("curs_set")
    :int
  (visibility :int))

(define-exported-cfuns ("napms")
    :int
  (ms :int))


;; keybound
#-(or win32 mswindows)
(define-exported-cfuns ("keybound")
    :string
  (keycode :int)
  (count :int))


;; keyok
#-(or win32 mswindows)
(define-exported-cfuns ("keyok")
    :int
  (keycode :int)
  (enable bool))


;; key_defined
; TODO: wrap this function if the local C ncurses library supports EXTENSIONS.
; C-prototype: int key_defined(const char *definition);
;(def :int ((definition :cstring))
;     "key_defined")


;; mouse
; TODO
; C-prototype: typedef unsigned long mmask_t;

; C-prototype: typedef struct
;        {
; 	   short id;	     /* ID to distinguish multiple devices */
; 	   int x, y, z;      /* event coordinates */
; 	   mmask_t bstate;   /* button state bits */
;        }
;        MEVENT;
; C-prototype: int getmouse(MEVENT *event);
; C-prototype: int ungetmouse(MEVENT *event);
; C-prototype: mmask_t mousemask(mmask_t newmask, mmask_t *oldmask);
; C-prototype: bool wenclose(const WINDOW *win, int y, int x);
; C-prototype: bool mouse_trafo(int* pY, int* pX, bool to_screen);
; C-prototype: bool wmouse_trafo(const WINDOW* win, int* pY, int* pX, bool to_screen);
; C-prototype: int mouseinterval(int erval);


;; move
(define-exported-cfuns ("move")
    :int
  (y :int)
  (x :int))

(define-exported-cfuns ("wmove")
    :int
  (win window-ptr)
  (y :int)
  (x :int))

(define-exported-cfuns ("clearok" "idlok" "leavok" "scrollok")
    :int
  (win window-ptr)
  (bf bool))

(define-exported-cfuns ("idcok" "immedok")
    :void
  (win window-ptr)
  (bf bool))

(define-exported-cfuns ("setscrreg")
    :int
  (top :int)
  (bot :int))

(define-exported-cfuns ("wsetscrreg")
    :int
  (win window-ptr)
  (top :int)
  (bot :int))

(define-exported-cfuns ("nl nonl")
    :int)


;; overlay
(define-exported-cfuns ("overlay")
    :int
  (srcwin window-ptr)
  (dstwin window-ptr))

(define-exported-cfuns ("overwrite")
    :int
  (srcwin window-ptr)
  (dstwin window-ptr))

;TODO
; C-prototype: int copywin(const WINDOW *srcwin, WINDOW *dstwin, int sminrow,
;              int smincol, int dminrow, int dmincol, int dmaxrow,
;              int dmaxcol, int overlay);


;; pad
(define-exported-cfuns ("newpad")
    window-ptr
  (nlines :int)
  (ncols :int))

(define-exported-cfuns ("subpad")
    window-ptr
  (orig window-ptr)
  (nlines :int)
  (ncols :int)
  (begin_y :int)
  (begin_x :int))

(define-exported-cfuns ("prefresh")
    :int
  (pad window-ptr)
  (pminrow :int)
  (pmincol :int)
  (sminrow :int)
  (smincol :int)
  (smaxrow :int)
  (smaxcol :int))

(define-exported-cfuns ("pnoutrefresh")
    :int
  (pad window-ptr)
  (pminrow :int)
  (pmincol :int)
  (sminrow :int)
  (smincol :int)
  (smaxrow :int)
  (smaxcol :int))

(define-exported-cfuns ("pechochar")
    :int
  (pad window-ptr)
  (ch chtype))


;; print
#-(or win32 mswindows)
(define-exported-cfuns ("mcprint")
    :int
  (data :string)
  (len :int))


;; printw
; TODO: support a variable number of args
(define-exported-cfuns ("printw")
    :int
  (fmt :string))

(define-exported-cfuns ("wprintw")
    :int
  (win window-ptr)
  (fmt :string))

(define-exported-cfuns ("mvprintw")
    :int
  (y :int)
  (x :int)
  (fmt :string))

(define-exported-cfuns ("mvwprintw")
    :int
  (win window-ptr)
  (y :int)
  (x :int)
  (fmt :string))

; C-prototype: int vwprintw(WINDOW *win, const char *fmt, va_list varglist);
; C-prototype: int vw_printw(WINDOW *win, const char *fmt, va_list varglist);


;; refresh
(define-exported-cfuns ("refresh" "doupdate")
    :int)

(define-exported-cfuns ("wrefresh" "wnoutrefresh" "redrawwin")
    :int
  (win window-ptr))

(define-exported-cfuns ("wredrawln")
    :int
  (win window-ptr)
  (beg_line :int)
  (num_lines :int))


;; resizeterm
#-(or win32 mswindows)
(define-exported-cfuns ("is_term_resized")
    bool
  (lines :int)
  (columns :int))

(define-exported-cfuns ("resize_term"
           #-(or win32 mswindows)
           "resizeterm")
    :int
  (lines :int)
  (columns :int))


;; scanw
; TODO
; C-prototype: int scanw(char *fmt, ...);
; C-prototype: int wscanw(WINDOW *win, char *fmt, ...);
; C-prototype: int mvscanw(int y, int x, char *fmt, ...);
; C-prototype: int mvwscanw(WINDOW *win, int y, int x, char *fmt, ...);
; C-prototype: int vw_scanw(WINDOW *win, char *fmt, va_list varglist);
; C-prototype: int vwscanw(WINDOW *win, char *fmt, va_list varglist);


;; scr_dump
(define-exported-cfuns ("scr_dump" "scr_restore" "scr_init" "scr_set")
    :int
  (filename char-ptr))


;; scroll
(define-exported-cfuns ("scroll")
    :int
  (win window-ptr))

(define-exported-cfuns ("scrl")
    :int
  (n :int))

(define-exported-cfuns ("wscrl")
    :int
  (win window-ptr)
  (n :int))


;; slk
(define-exported-cfuns ("slk_init")
    :int
  (fmt :int))

(define-exported-cfuns ("slk_set")
    :int
  (labnum :int)
  (label :string)
  (fmt :int))

(define-exported-cfuns ("slk_refresh" "slk_noutrefresh" "slk_clear" "slk_restore" "slk_touch")
    :int)

(define-exported-cfuns ("slk_label")
    :string
  (labnum :int))

(define-exported-cfuns ("slk_atttron" "slk_attroff" "slt_attrset")
    :int
  (attrs chtype))

; TODO
; C-prototype: int slk_attr_on(attr_t attrs, void* opts);
; C-prototype: int slk_attr_off(const attr_t attrs, void * opts);
; C-prototype: int slk_attr_set(const attr_t attrs, short color_pair_number, void* opts);
; C-prototype: attr_t slk_attr(void);

(define-exported-cfuns ("slk_color")
    :int
  (color_pair_number :short))


;; termattrs
(define-exported-cfuns ("baudrate")
    :int)

(define-exported-cfuns ("erasechar" "killchar")
    :char)

; TODO
; C-prototype: int erasewchar(wchar_t *ch);

(define-exported-cfuns ("has_ic" "has_il")
    bool)

; TODO
; C-prototype: int killwchar(wchar_t *ch);
; C-prototype: attr_t term_attrs(void);

(define-exported-cfuns ("termattrs")
    chtype)

(define-exported-cfuns ("longname" "termname")
    char-ptr)


;; termcap
; TODO
; C-prototype: extern char PC; extern char *  UP;  extern  char  *  BC;  extern  short ospeed;
; C-prototype: int tgetent(char *bp, const char *name);

#-(or win32 mswindows)
(define-exported-cfuns ("tgetflag" "tgetnum")
    :int
  (id char-ptr))

; TODO
; C-prototype: char *tgetstr(char *id, char **area);
; C-prototype: char *tgoto(const char *cap, int col, int row);
; C-prototype: int tputs(const char *str, int affcnt, int (*putc)(int));


;; terminfo
; TODO
; C-prototype: int setupterm(char *term, int fildes, int *errret);
; C-prototype: int setterm(char *term);
; C-prototype: TERMINAL *set_curterm(TERMINAL *nterm);
; C-prototype: int del_curterm(TERMINAL *oterm);
; C-prototype: int restartterm(const char *term, int fildes, int *errret);
; C-prototype: char *tparm(char *str, ...);
; C-prototype: int tputs(const char *str, int affcnt, int (*putc)(int));
; C-prototype: int putp(const char *str);
; C-prototype: int vidputs(chtype attrs, int (*putc)(int));
; C-prototype: int vidattr(chtype attrs);
; C-prototype: int vid_puts(attr_t attrs, short pair, void *opts, int (*putc)(char));
; C-prototype: int vid_attr(attr_t attrs, short pair, void *opts);
; C-prototype: int mvcur(int oldrow, int oldcol, int newrow, int newcol);
; C-prototype: int tigetflag(char *capname);
; C-prototype: int tigetnum(char *capname);
; C-prototype: char *tigetstr(char *capname);


;; touch
(define-exported-cfuns ("touchwin" "untouchwin")
    :int
  (win window-ptr))

(define-exported-cfuns ("is_untouched")
    bool
  (win window-ptr))

(define-exported-cfuns ("touchline")
    :int
  (win window-ptr)
  (start :int)
  (count :int))

(define-exported-cfuns ("wtouchln")
    :int
  (win window-ptr)
  (y :int)
  (n :int)
  (changed :int))

(define-exported-cfuns ("is_linetouched")
    bool
  (win window-ptr)
  (line :int))


;; util
(define-exported-cfuns ("unctrl")
    char-ptr
  (c chtype))

(define-exported-cfuns ("keyname")
    char-ptr
  (c :int))

(define-exported-cfuns ("filter")
    :void)

(define-exported-cfuns ("use_env")
    :void
  (f bool))

(define-exported-cfuns ("delay_output")
    :int
  (ms :int))

(define-exported-cfuns ("flushinp")
    :int)

; TODO
; C-prototype: char *wunctrl(cchar_t *c);
; C-prototype: char *key_name(wchar_t w);
; C-prototype: int putwin(WINDOW *win, FILE *filep);
; C-prototype: WINDOW *getwin(FILE *filep);


;; variables
(export '(*COLORS* *COLOR-PAIRS* *LINES* *COLS* *TABSIZE* 
	  *ECSDELAY* *STDSCR* *CURSCR* *NEWSCR*))

(defcvar ("COLORS" *COLORS* :library libcurses) :int)
(defcvar ("COLOR_PATHS" *COLOR-PATHS* :library libcurses) :int)

(defcvar ("LINES" *LINES* :library libcurses) :int)
(defcvar ("COLS" *COLS* :library libcurses) :int)
(defcvar ("TABSIZE" *TABSIZE* :library libcurses) :int)
(defcvar ("ESCDELAY" *ESCDELAY* :library libcurses) :int)

(defcvar ("stdscr" *STDSCR* :library libcurses) window-ptr)
(defcvar ("curscr" *CURSCR* :library libcurses) window-ptr)
(defcvar ("newscr" *NEWSCR* :library libcurses) window-ptr)


;; window
(define-exported-cfuns ("newwin")
    window-ptr
  (nlines :int)
  (ncols :int)
  (begin_y :int)
  (begin_x :int))

(define-exported-cfuns ("delwin")
    :int
  (win window-ptr))

(define-exported-cfuns ("wsyncup" "wcursyncup" "wsyncdown")
    :void
  (win window-ptr))

(define-exported-cfuns ("mvwin" "mvderwin")
    :int
  (win window-ptr)
  (y :int)
  (x :int))

(define-exported-cfuns ("subwin" "derwin")
    window-ptr
  (orig window-ptr)
  (nlines :int)
  (ncols :int)
  (begin_y :int)
  (begin_x :int))

(define-exported-cfuns ("dupwin")
    window-ptr
  (win window-ptr))

(define-exported-cfuns ("syncok")
    :int
  (win window-ptr)
  (bf bool))


;; wresize
(define-exported-cfuns ("wresize")
    :int
  (win window-ptr)
  (lines :int)
  (columns :int))
