
.model small
.stack 100h
.data
    Row_no db 0
    Index dw 0
    Count3 db 0
    K dw 0 
    Rcon db 01H , 02H , 04H , 08H , 10H , 20H , 40H , 80H , 1BH , 36H
         db 00H , 00H , 00H , 00H , 00H , 00H , 00H , 00H , 00H , 00H
         db 00H , 00H , 00H , 00H , 00H , 00H , 00H , 00H , 00H , 00H
         db 00H , 00H , 00H , 00H , 00H , 00H , 00H , 00H , 00H , 00H
     

    Round_key db 2BH , 28H , 0ABH , 09H 
              db 7EH , 0AEH , 0F7H , 0CFH
              db 15H , 0D2H , 15H , 4FH 
              db 16H , 0A6H , 88H , 3CH  
          
    Template db 00H,00H,00H,00H          
             
             
    Round_no dw 1
    Count2 dw 0 
SBox     db 63h,  7ch,  77h,  7bh,  0f2h, 6bh,  6fh,  0c5h, 30h,  01h,  67h,  2bh,  0feh, 0d7h, 0abh, 76h
         db 0cah, 82h,  0c9h, 7dh,  0fah, 59h,  47h,  0f0h, 0adh, 0d4h, 0a2h, 0afh, 9ch,  0a4h, 72h,  0c0h
         db 0b7h, 0fdh, 93h,  26h,  36h,  3fh,  0f7h, 0cch, 34h,  0a5h, 0e5h, 0f1h, 71h,  0d8h, 31h,  15h
         db 04h,  0c7h, 23h,  0c3h, 18h,  96h,  05h,  9ah,  07h,  12h,  80h,  0e2h, 0ebh, 27h,  0b2h, 75h
         db 09h,  83h,  2ch,  1ah,  1bh,  6eh,  5ah,  0a0h, 52h,  3bh,  0d6h, 0b3h, 29h,  0e3h, 2fh,  84h
         db 53h,  0d1h, 00h,  0edh, 20h,  0fch, 0b1h, 5bh,  6ah,  0cbh, 0beh, 39h,  4ah,  4ch,  58h,  0cfh
         db 0d0h, 0efh, 0aah, 0fbh, 43h,  4dh,  33h,  85h,  45h,  0f9h, 02h,  7fh,  50h,  3ch,  9fh,  0a8h
         db 51h,  0a3h, 40h,  8fh,  92h,  9dh,  38h,  0f5h, 0bch, 0b6h, 0dah, 21h,  10h,  0ffh, 0f3h, 0d2h
         db 0cdh, 0ch,  13h,  0ech, 5fh,  97h,  44h,  17h,  0c4h, 0a7h, 7eh,  3dh,  64h,  5dh,  19h,  73h
         db 60h,  81h,  4fh,  0dch, 22h,  2ah,  90h,  88h,  46h,  0eeh, 0b8h, 14h,  0deh, 5eh,  0bh,  0dbh
         db 0e0h, 32h,  3ah,  0ah,  49h,  06h,  24h,  5ch,  0c2h, 0d3h, 0ach, 62h,  91h,  95h,  0e4h, 79h
         db 0e7h, 0c8h, 37h,  6dh,  8dh,  0d5h, 4eh,  0a9h, 6ch,  56h,  0f4h, 0eah, 65h,  7ah,  0aeh, 08h
         db 0bah, 78h,  25h,  2eh,  1ch,  0a6h, 0b4h,  0c6h, 0e8h, 0ddh, 74h,  1fh,  4bh,  0bdh, 8bh,  8ah
         db 70h,  3eh,  0b5h, 66h,  48h,  03h,  0f6h, 0eh,  61h,  35h,  57h,  0b9h, 86h,  0c1h, 1dh,  9eh
         db 0e1h, 0f8h, 98h,  11h,  69h,  0d9h, 8eh,  94h,  9bh,  1eh,  87h,  0e9h, 0ceh, 55h,  28h,  0dfh
         db 8ch,  0a1h, 89h,  0dh,  0bfh, 0e6h, 42h,  68h,  41h,  99h,  2dh,  0fh,  0b0h, 54h,  0bbh, 16h
         
         
         
input db 32 dup(?)


    Field  db 02h, 03h, 01h, 01h
           db 01h, 02h, 03h, 01h 
           db 01h, 01h, 02h, 03h
           db 03h, 01h, 01h, 02h 
           
    Output db ?, ?, ?, ?
           db ?, ?, ?, ?
           db ?, ?, ?, ?
           db ?, ?, ?, ?
    
    mainIndex db 0
    
    indexJump dw 4d
    
    indexForOutput dw 0
    TempValueForSI dw 0
    count dw 0
    countForColumn dw 0
    mainloopcounter dw 10
    prompt db "if you want to do AES Encryption to 16 characters(128 bits) press 1 if you want to do it on 32 hexadecimal digits press 2 $"
    promptascii db "enter 16 characrters: $"
    prompthexa db "enter 32 hexadecimal digits: $"
    newline db 0Dh, 0Ah, "$"   ; Newline characters
    msg db "The ciphyered text or hexadecimal is : $"
    howtoprint db 0
   
    
.code

main:

  jmp projectjump
;-----------------------------------------------------------------ascii input

input_characters proc
    mov si,offset input       ; Pointer to input buffer
    
    mov cx, 16           ; Counter for 16 characters
input_loop2:
    ; Input character
    mov ah, 01h
    int 21h
    mov [si], al         ; Store the character in the buffer
    inc si               ; Move to the next position in the buffer
    
    loop input_loop2      ; Repeat for 16 characters
    ret
input_characters endp

print_characters proc
    lea si, input   ; Pointer to input buffer
    mov cx, 16             

print_loop:
    mov dl, [si]          ; Load character to print
    mov ah, 02h           ; Print character
    int 21h
    inc si                
    loop print_loop       ; Repeat for all 16 characters
    ret
print_characters endp





;-----------------------------------------------------------------hexadecimal input

    
input_digits_hex proc
    lea si, input       ; Pointer to digits array
    
    mov cx, 16           ; Counter for 16 bytes (32 hexadecimal digits)
input_loop:
    ; Input first character
    mov ah, 01h
    int 21h
    mov bl, al           ; Copy first character to BL
    
    ; Convert the first character to hexadecimal
    call convert_to_hex
    
    mov bh, al           ; Store the first hexadecimal digit in BH
    
    ; Input second character
    mov ah, 01h
    int 21h
    mov bl, al           ; Copy second character to BL
    
    ; Convert the second character to hexadecimal
    call convert_to_hex
    
    shl bh, 4            ; Shift the first digit to the left
    or  bh, al           ; Combine the two digits
    
    mov [si], bh         ; Store the combined byte in the array
    inc si               ; Move to the next position in the array
    
    loop input_loop      ; Repeat for 16 bytes (32 hexadecimal digits)
    ret
input_digits_hex endp

convert_to_hex proc
    cmp bl, '0'
    jb not_hexadecimal   ; If character is less than '0', it's not a hexadecimal digit
    cmp bl, '9'
    jbe is_digit
    cmp bl, 'A'
    jb not_hexadecimal   ; If character is less than 'A', it's not a hexadecimal digit
    cmp bl, 'F'
    jbe is_upper_hex     ; If character is between 'A' and 'F', it's a valid upper-case hex digit
    cmp bl, 'a'
    jb not_hexadecimal   ; If character is less than 'a', it's not a hexadecimal digit
    cmp bl, 'f'
    ja not_hexadecimal   ; If character is greater than 'f', it's not a hexadecimal digit
    jmp is_lower_hex     ; If character is between 'a' and 'f', it's a valid lower-case hex digit
    
is_digit:
    sub bl, '0'          ; Convert digit character to its corresponding value (0-9)
    jmp store_hex
    
is_upper_hex:
    sub bl, 'A' - 10     ; Convert 'A' to 10, 'B' to 11, ..., 'F' to 15
    jmp store_hex
    
is_lower_hex:
    sub bl, 'a' - 10     ; Convert 'a' to 10, 'b' to 11, ..., 'f' to 15

store_hex:
    mov al, bl           ; Store the hexadecimal digit
    ret

not_hexadecimal:
    jmp input_loop

convert_to_hex endp
print_digits proc
    lea si, input       ; Reset pointer to start of array
    mov cx, 16           ; Counter for 16 bytes

print_loop2:
    ; Print high nibble
    mov al, [si]
    mov ah, al
    shr ah, 4            ; Shift high nibble to lower nibble position
    mov al, ah
    call print_hex_nibble
    
    ; Print low nibble
    mov al, [si]
    and al, 0Fh          ; Mask high nibble
    call print_hex_nibble

    inc si               ; Move to the next byte
    loop print_loop2      ; Repeat for all 16 bytes
    ret
print_digits endp

print_hex_nibble proc
    ; Print a single hexadecimal nibble (0-15)
    cmp al, 9
    jbe is_digit2
    add al, 7            ; Convert 10-15 to 'A'-'F'
is_digit2:
    add al, '0'          ; Convert to ASCII character
    mov dl, al
    mov ah, 02h          ; DOS function: write character to standard output
    int 21h
    ret
print_hex_nibble endp


;---------------------------------------------------------------------------




First_Stage macro input, Round_key
    xor ax, ax ; reset all registers
    xor bx, bx
    xor cx, cx
    xor dx, dx
    xor si, si
    xor di, di
    mov Index, 0
    mov si, Index
    mov cx, 16 ; set the loop count to 16 elements

LOOP13:
    xor al, al
    xor al, Round_key[si]
    xor input[si], al
    inc si
    loop LOOP13 ; decrement CX and loop until CX is zero

    endm
      
            
            
SubBytes macro input, Sbox
    xor ax, ax ; reset all registers
    xor bx, bx
    xor cx, cx
    xor dx, dx
    xor si, si
    xor di, di
    
loop132:
    mov bl, input[si]
    mov di, bx ; move the bx that now contains the index to di
    mov dl, Sbox[di] ; get the value of the subbyte from Sbox using it, using dx since it is empty
    mov input[si], dl ; replacing the value
    inc si ; increment the index of input
    xor di, di  ; resetting di 
    
    xor ax, ax ; reset all registers
    xor bx, bx
    xor cx, cx
    xor dx, dx
    
    cmp si, 10h ; comparing to 16 decimal
    jne loop132
    endm


SHIFT macro input, Row_no, Index, Count3, K
    xor ax, ax ; reset all registers
    xor bx, bx
    xor cx, cx
    xor dx, dx
    xor si, si
    xor di, di
    mov Row_no, 0
    
LOOP2:
    mov al, Row_no
    mov Count3, al
LOOP3:
    cmp Count3, 0
    je endloop     
    mov si, Index
    mov al, input[si] 
                
    mov bx, Index
    mov K, bx
                 
    add K, 3
    mov di, si
    inc di
LOOP4:
    mov cl, input[di]
    mov input[si], cl 
    inc si
    inc di
    cmp si, K
    jb LOOP4
    mov input[si], al
    dec Count3
    cmp Count3, 0
    ja LOOP3
endloop:
    add Index, 4
    inc Row_no
    cmp Row_no, 4
    jb LOOP2
    endm



MixColumns macro input, output, Field
    xor ax,ax ;reset all registers
    xor bx,bx
    xor cx,cx
    xor dx,dx       
    mov si, 0 ;index that will loop over input array
    mov di, 0 ;index that will loop over the field
    mov count, 0 ; counter for how many words have been multiplied will be used in a compare to check if we will store the value in a certain index in the output array
    mov indexForOutput,0 
    mov countForColumn,0  
    
l:
    cmp Field[di],03h ;if the number will stay the same then it should skip the harder multiplication bits
    je mul3
    cmp Field[di],02h
    je mul2
    jne skip
skip: 
    mov cl, input[si] ;moving the value to register cx which will be used to finalize a value before xor'ing with dx 
    jmp accumlate
mul2:
    ;multiply the current value at index si by 02 formula using ax, bx, cx since dx is used as accumlator and cx will have the final value
    mov al, input[si]
    mov bl, input[si]
    and bl, 80h
    shl al, 1
    cmp bl, 80h
    je willxor
    jne xored
willxor:
    xor al, 00011011b
xored: 
    mov cl, al
    jmp accumlate
    
mul3:
    ;multiply the current value at index si by 03 formula using ax, bx, cx since dx is used as accumlator and cx will have the final value
    mov al, input[si]
    mov bl, input[si]
    mov cl, input[si]
    and bl, 80h
    shl al, 1
    cmp bl, 80h
    je willxor2
    jne xored2
willxor2:
    xor al, 00011011b
    
xored2:
    xor cl, al
    jmp accumlate
    
accumlate:
    cmp count, 0
    je initialset
     
    xor dx, cx
    inc count ;one more value accumlated by xor
    inc di ;next index in field
    jmp accumlated
initialset:
    mov dx, cx
    inc count
    inc di
    
accumlated:
    cmp count, 4 ; check if a value is done with accumlation and is ready to be stored in output
    je store
      
stored:
    cmp indexForOutput, 10h
    je endpoint

    cmp si, 16 ;this comparison will check the updated value of si after accumlation 
    je then  ;if the si is 16 this means its done with the row and needs to be reset
    jne else         ;if its 16 --> reset to 0 
then:
    mov si, 0
    jmp done
             ;else if count = 0 (the first element it will not jump index by 4 so it will skip) else it skips 4 index values   
else:
    cmp count, 0
    jne jump
    jmp done
jump:
    add si, indexJump
done:
    xor ax, ax ; reset all registers except for dx since it is used as a accumlator
    xor bx, bx
    xor cx, cx
    jmp l
     
store:
    mov TempValueForSI, si ;storing the value for si currently to put the value of dx in a certain index
    mov si, indexForOutput 
    mov output[si], dl     ;stored in output
    xor dl, dl
    mov si, TempValueForSI ;returning the si value
    inc indexForOutput     ;incrementing so that the next store will be in the correct place
    cmp indexForOutput, 4d
    je increment          
    cmp indexForOutput, 8d
    je increment
    cmp indexForOutput, 12d
    je increment
    jne skipincrement
    
increment:
    inc countForColumn ; this is done so we can get the next column values 0,4,8,12 then 1,5,9,13 and so on
    mov di, 0 ; reset index for field
      
skipincrement:
    mov si, countForColumn
    mov count, 0
    jmp stored  
endpoint:
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx
    mov si, 0 ; time to switch the values in output to input
    mov di, 0
    mov indexForOutput, -1 ; for(int col = 0; col<4;col++)
colLoop:
    inc indexForOutput
    cmp indexForOutput, 0
    jz rowLoop
    
    cmp indexForOutput, 4d
    je finally
    mov count, 0 ; for (int row = 0; row < size; row++) 
rowLoop:
    mov si, indexForOutput
    mov ax, count
    mov cx, 4d
    mul cx
    add si, ax
    mov bl, output[si]
    mov input[di], bl 
    inc di
    inc count
    cmp count, 4d
    jne rowLoop
    je colLoop
    
finally:
    endm

ADD_ROUND_KEYS macro input, Round_key, template, Sbox, Rcon, Round_no
    xor ax, ax ; reset all registers
    xor bx, bx
    xor cx, cx
    xor dx, dx
    xor si, si
    xor di, di 

    ; making key schedule
    ; copying the last column 
    mov si, 0
    mov di, 3
Loop5:
    xor ax, ax
    mov al, Round_key[di]
    mov template[si], al
    inc si
    add di, 4
    cmp si, 4
    jb Loop5

    ; rotate 4th column 
    mov Index, 3
    mov si, Index
    mov al, Round_key[si]
    mov di, si
    add di, 4
LOOP6:
    mov cl, Round_key[di]
    mov Round_key[si], cl 
    add si, 4
    add di, 4 
    cmp si, 15   
    jb LOOP6
    mov Round_key[si], al
       
    ; Subbytes for 4th column   
    mov si, 3
    mov di, 0
LOOP7:
    mov bl, Round_key[si]
    mov di, bx ; move the bx that now contains the index to di
    mov dl, Sbox[di] ; get the value of the subbyte from Sbox using it, using dx since it is empty
    mov Round_key[si], dl ; replacing the value
    add si, 4 ; increment the index of input
    xor di, di ; resetting di 
    xor ax, ax ; reset all registers
    xor bx, bx
    xor cx, cx
    xor dx, dx
    cmp si, 16
    jb LOOP7  
                     
    ; xoring 1st column with round noth column in Rcon and the latest 4th column                 
    mov Index, 0
    mov si, Index 
    mov di, Round_no 
    sub di, 1
LOOP8:
    xor al, al
    xor al, Rcon[di] 
    xor Round_key[si], al 
    push di
    mov di, si
    add di, 3 
    xor bl, bl
    xor bl, Round_key[di]
    xor Round_key[si], bl 
    mov cl, Round_key[si]
    xor cx, cx
    pop di 
    add si, 4
    add di, 10
    cmp si, 12
    jbe LOOP8

    ; xoring the rest columns with the previous column
    mov Index, 1
    mov si, Index 
    mov di, si 
    sub di, 1
LOOP9:
    mov cx, Index 
    mov Count2, cx
    add Count2, 13 
LOOP10:
    xor al, al
    xor al, Round_key[di] 
    xor Round_key[si], al 
    add si, 4
    add di, 4
    cmp si, Count2
    jb LOOP10
    inc Index 
    mov si, Index 
    mov di, si 
    sub di, 1
    cmp si, 3
    jb LOOP9  
               
    ; xoring the 3rd column with the template      
    mov si, 0
    mov di, 2
loop11:
    xor al, al
    xor al, template[si]
    mov bl, Round_key[di]
    xor al, bl   
    inc di
    mov Round_key[di], al 
    dec di
    add di, 4
    inc si
    cmp si, 4
    jb loop11 
                               
    ; finally xoring the input array with the resultant round key               
    mov Index, 0
    mov si, Index 
LOOP12:
    xor al, al
    xor al, Round_key[si]  
    xor input[si], al
    inc si
    cmp si, 16
    jb LOOP12
            
    inc Round_no
    endm
  




;main--------------------------------------------------------------------
projectjump: 
    mov ax, @data
    mov ds, ax 
    
    mov ah, 09h
    lea dx, prompt ; Enter 32 hexadecimal digits:
    int 21h  
    mov dl, 0Dh   ; new line
    mov ah, 02h   
    int 21h       

    mov dl, 0Ah   
    mov ah, 02h  
    int 21h
    
 
    
    ; Read input mode from user
    mov ah, 01h
    int 21h
    sub al, '0'             ; Convert ASCII digit to numeric value
    mov howtoprint,al
    
    mov dl, 0Dh   ; new line
    mov ah, 02h   
    int 21h       

    mov dl, 0Ah   
    mov ah, 02h  
    int 21h 
    
    ; Check input mode
    cmp howtoprint, 2               ; Check if input mode is hexadecimal
    je hexadecimal_input
    cmp howtoprint, 1               ; Check if input mode is ASCII
    je ascii_input   
     
    mov dl, 0Dh   ; new line
    mov ah, 02h   
    int 21h       

    mov dl, 0Ah   
    mov ah, 02h  
    int 21h 
      

    
    
hexadecimal_input:
    mov ah, 09h
    lea dx, prompthexa ; Enter 32 hexadecimal digits:
    int 21h    
    call input_digits_hex
    jmp encryption

ascii_input:
    mov ah, 09h
    lea dx, promptascii ; Enter 32 hexadecimal digits:
    int 21h
    ; Call input procedure
    call input_characters
    
    
    
encryption:
    mov dl, 0Dh   ; new line
    mov ah, 02h   
    int 21h       

    mov dl, 0Ah   
    mov ah, 02h  
    int 21h
    
    First_Stage input, Round_key
    mainLoop: dec mainloopcounter
              SubBytes input, SBox
              SHIFT input, Row_no, Index, Count3, K
              cmp  mainloopcounter,0
              je lastroundskip
              MixColumns input, Output, Field
lastroundskip:
              ADD_ROUND_KEYS input, Round_key, Template, Sbox, Rcon, Round_no
              cmp  mainloopcounter,0
              jne mainLoop
    mov cx,0          

    
    ; Print message
    mov ah, 09h
    lea dx, msg
    int 21h 
    
    cmp howtoprint,1
    jne  hexadecimal_print
    je ascii_print
hexadecimal_print:    
    call print_digits
    jmp encryptioncomplete
    
ascii_print:
    call print_characters

encryptioncomplete:    
    ; End the program
    mov ah, 4Ch         ; AH = 4Ch for "Terminate with return code"
    xor al, al          ; AL = 0 for return code 0
    int 21h             ; Terminate program
 






end main






