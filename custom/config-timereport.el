;;; config-timereport.el --- General editor configuration -*- lexical-binding: t; -*-

(defun print-month-days (&optional year month)
  "Print each day of MONTH in YEAR with its weekday."
  (interactive)
  (let* ((year (or year (string-to-number (format-time-string "%Y"))))
         (month (or month (string-to-number (format-time-string "%m"))))
         (days-in-month (calendar-last-day-of-month month year))
         (weekday '(("Monday" . "Måndag ")
                    ("Tuesday" . "Tisdag ")
                    ("Wednesday" . "Onsdag ")
                    ("Thursday" . "Torsdag")
                    ("Friday" . "Fredag ")
                    ("Saturday" . "Lördag ")
                    ("Sunday" . "Söndag "))))
    (point-max)
    (dotimes (i days-in-month)
      (let* ((day (1+ i))
             (date (encode-time 0 0 0 day month year))
             (day-string (alist-get (format-time-string "%A" date) weekday nil nil #'string=)))
        (insert (concat (format-time-string "%Y-%m-%d" date)
                        " "
                        day-string
                        " -\n"))
        (when (equal day-string "Söndag ")
          (insert "\n"))
        (when (equal day-string "Fredag ")
          (insert "\n"))))))




(provide 'config-timereport)

;;; config-timereport ends here
