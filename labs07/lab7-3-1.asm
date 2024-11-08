%include 'in_out.asm'
section .data
msg1 db 'Введите B: ',0h
msg2 db "Наименьшее число: ",0h
A dd 84      ; Числовое значение A
C dd 77      ; Числовое значение C
section .bss
min resd 1   ; Переменная для хранения минимального значения (используем resd для хранения 32-битного числа)
B resb 10    ; Переменная для ввода B
section .text
global _start
_start:
; ---------- Вывод сообщения 'Введите B: '
mov eax, msg1
call sprint
; ---------- Ввод 'B'
mov ecx, B
mov edx, 10
call sread
; ---------- Преобразование 'B' из символа в число
mov eax, B
call atoi ; Вызов подпрограммы перевода символа в число
mov [B], eax ; запись преобразованного числа в 'B'
; ---------- Записываем 'A' в переменную 'min'
mov eax, [A] ; 'eax = A'
mov [min], eax ; 'min = A'
; ---------- Сравниваем 'min' (A) и 'C'
cmp eax, [C] ; Сравниваем 'A' и 'C'
jge check_B ; если 'A >= C', то переход на метку 'check_B'
mov eax, [C] ; иначе 'eax = C'
mov [min], eax ; 'min = C'
; ---------- Проверяем 'B'
check_B:
mov eax, [min] ; 'eax = min'
cmp eax, [B] ; Сравниваем 'min' и 'B'
jle fin ; если 'min <= B', то переход на 'fin'
mov eax, [B] ; иначе 'eax = B'
mov [min], eax ; 'min = B'
; ---------- Вывод результата
fin:
mov eax, msg2
call sprint ; Вывод сообщения 'Наименьшее число: '
mov eax, [min]
call iprintLF ; Вывод 'min(A,B,C)'
call quit ; Выход
