;;; 現在の行を目立たせる
;(global-hl-line-mode)

;;; modeline に行数と桁数を表示
(line-number-mode t)
(column-number-mode t)

;;; 履歴数を大きくする
(setq history-length 10000)

;;; キーバインド
(global-set-key "\C-h" 'delete-backward-char) ;; BS

