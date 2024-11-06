;--------------------------------
; Программа вычисления выражения
;--------------------------------
%include 'in_out.asm' ; подключение внешнего файла
SECTION .data
msg: DB 'Введите значение переменной Х: ',0
rem: DB 'Результат: ',0
SECTION .bss
x: RESB 80 ;
SECTION .text
GLOBAL _start
_start:
; ---- Вычисление выражения
mov eax, msg
call sprint
mov ecx, x
mov edx, 80
call sread
mov eax,x
call atoi
mov ebx,8
mul ebx; eax=eax*8
add eax,6; eax=eax+6
mov ebx,10
mul ebx ; eax =eax*10 
; ---- Вывод результата на экран
mov edi,eax ;
mov eax,rem ;
call sprint ;
mov eax,edi ;
call iprint ;
call quit ;
