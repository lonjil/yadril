(defparameter *height* 10)
(defparameter *width* 10)
(defparameter *entities* nil)
(setq *world* (progn
		(let ((world nil))
		  (loop for x to *height*
			do (loop for y to *width*
				 do (setq world (acons (list x y) 'floor world))))
		  world)))
(defstruct entity
  (hp 10)
  (name "Casimir")
  (x nil)
  (y nil)
  (type 'mob)
  (strength 10)
  (dexterity 10)
  (consitution 10)
  (intelligence 10)
  (wisdom 10)
  (charisma 10)
  (luck 10)
  (easter-egg -10)
  (magic 0))
(defun register-entity (entity &rest keywords)
  (setf *entities* (acons entity (apply #'make-entity keywords) *entities*)))
(defun get-entity-val (entity val)
  (funcall (intern (concatenate 'string "ENTITY-" (string val))) (cdr (assoc entity *entities*))))
(defun entity-gen () nil)
(defun player-gen (&key (name "Casimir") (hp 20) (magic 16)
		(type 'player) (y (random *height*)) (x (random *width*)))
	(make-entity :hp hp :magic magic :type type :x x :y y :name name))
(defun create-stock-entites ()
  (register-entity 'player :name "The Choosen One" :x (random *width*) :y (random *height*))
  (register-entity 'mob :name "The Mob One" :x (random *width*) :y (random *height*)))
(defun draw-map (entities world)
  (loop for y to *height*
	do (loop for x to *width*
		 do (princ (cond ((equal `(,x . ,y) (get-coord 'player)) #\@)
				 ((equal `(,x . ,y) (get-coord 'mob)) #\M)
				 (t #\.))))
		(fresh-line)))
(defun get-coord (entity)
  `(,(entity-x (cdr (assoc entity *entities*))) . ,(entity-y (cdr (assoc 'player *entities*)))))
(defun set-coord (entity coord)
  (setf (entity-x entity) (car coord))
  (setf (entity-y entity) (cdr coord)))
(defun set-coord-relative (entity dir &optional (x 1))
  (case dir 
	('up (decf (entity-y entity) x))
	('down (incf (entity-y entity) x))
	('left (decf (entity-x entity) x))
	('right (incf (entity-x entity) x))))
(defun walk (entity dir &optional (x 1))
  (cond ((<= (entity-dexterity entity) x)
	 (set-coord-relative entity dir x))))

