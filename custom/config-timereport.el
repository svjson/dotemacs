;;; config-timereport.el --- General editor configuration -*- lexical-binding: t; -*-

(require 'calendar)

(defcustom svjson/timereport-directory (expand-file-name "time-reports" (getenv "HOME"))
  "Directory to store time report sheets"
  :type 'string
  :group 'user)

(defcustom svjson/timereport-file-pattern "time-report-%s.txt"
  "Pattern for time report sheets"
  :type 'string
  :group 'user)

(defun svjson/print-month-days (&optional year month)
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
                    ("Sunday" . "Söndag ")
                    ("måndag" . "Måndag ")
                    ("tisdag" . "Tisdag ")
                    ("onsdag" . "Onsdag ")
                    ("torsdag" . "Torsdag")
                    ("fredag" . "Fredag ")
                    ("lördag" . "Lördag ")
                    ("söndag" . "Söndag "))))
    (point-max)
    (dotimes (i days-in-month)
      (let* ((day (1+ i))
             (date (encode-time 0 0 0 day month year))
             (day-string (alist-get (format-time-string "%A" date) weekday nil nil #'string=)))
        (insert (concat (format-time-string "%Y-%m-%d" date)
                        " "
                        (or day-string (format-time-string "%A" date))
                        " -\n"))
        (when (equal day-string "Söndag ")
          (insert "\n"))
        (when (equal day-string "Fredag ")
          (insert "\n"))))))


(defun svjson/open-timereport ()
  "Open the time report sheet for the current month"
  (interactive)
  (find-file (expand-file-name (format svjson/timereport-file-pattern (format-time-string "%Y-%m")) svjson/timereport-directory) ))



(provide 'config-timereport)

;;; config-timereport ends here
