%include 'in_out.asm'  ; Подключаем необходимые библиотеки для ввода/вывода
section .data
msg1 db 'Введите значение a: ', 0
msg2 db 'Введите значение x: ', 0
msg3 db 'Результат f(x): ', 0
result db 10 dup(0)  ; Место для хранения результата в виде строки
section .bss
a resd 1              ; Переменная для хранения значения a
x resd 1              ; Переменная для хранения значения x
f resd 1              ; Переменная для хранения результата функции
section .text
global _start
_start:
    ; Ввод значения a
    mov eax, msg1
    call sprint
    mov eax, a
    mov ecx, 10
    call sread
    mov eax, a
    call atoi          ; Преобразование строки в число
    mov [a], eax      ; Сохранение значения a
    ; Ввод значения x
    mov eax, msg2
    call sprint
    mov eax, x
    mov ecx, 10
    call sread
    mov eax, x
    call atoi          ; Преобразование строки в число
    mov [x], eax      ; Сохранение значения x
    ; Вычисление f(x)
    mov eax, [a]      ; Загружаем значение a
    cmp eax, 7        ; Сравниваем a с 7
    jge case1         ; Если a >= 7, переходим к case1
    ; case2: a < 7
    mov eax, [x]      ; Загружаем значение x
    imul eax, [a]     ; Умножаем x на a
    mov [f], eax      ; Сохраняем результат в f
    jmp print_result   ; Переходим к выводу результата
case1:
    ; case1: a >= 7
    sub eax, 7        ; Вычисляем a - 7
    mov [f], eax      ; Сохраняем результат в f
print_result:
    mov eax, msg3
    call sprint        ; Выводим сообщение о результате
    ; Выводим результат f(x)
    mov eax, [f]      ; Загружаем результат
    call print_number  ; Выводим число
    call quit         ; Завершаем программу
; Подпрограмма для вывода числа
print_number:
    ; Предполагается, что результат в eax
    ; Делаем преобразование числа в строку для вывода
    mov ecx, 10       ; База для преобразования (десятичная)
    mov ebx, 0        ; Индекс для строки результата
.convert_loop:
    xor edx, edx      ; Обнуляем edx перед делением
    div ecx            ; Делим eax на 10
    add dl, '0'       ; Преобразуем остаток в символ
    push dx           ; Сохраняем символ на стеке
    inc ebx           ; Увеличиваем индекс
    test eax, eax     ; Проверяем, не закончились ли цифры
    jnz .convert_loop  ; Если не закончились, продолжаем
.print_loop:
    pop dx            ; Получаем символ из стека
    mov [result + ebx - 1], dl ; Сохраняем символ в строке
    dec ebx           ; Уменьшаем индекс
    jnz .print_loop   ; Если есть еще символы, продолжаем
    mov eax, result   ; Загружаем адрес строки результата
    mov ecx, 10       ; Длина строки
    call sprint       ; Выводим строку результата
    ret
