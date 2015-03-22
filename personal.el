;; defining all personal information in this file
;; at some point this should be variables only, so the config could be made more public.

(setq user-full-name "Martin Stendorf")
(setq user-email-address "mas@bnaa.dk")
(setq mail-host-address "bnaa.dk")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "84.238.0.3")
 '(smtpmail-smtp-service 25))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;setup org2blog info
(setq org2blog/wp-blog-alist
      '(("dorfzone"
         :url "http://dorfzone.dk/xmlrpc.php"
         :username "admin"
         :default-categories ("Uncategorized")
         :default-options "toc:4 h:4"
         :default-title "TITLE HERE!")))
