IDEAL
MODEL small
STACK 100h
DATASEG
card_2_spade db 'THE CARD IS 2 OF SPADE$'
card_3_spade db 'THE CARD IS 3 SPADE $'
card_4_spade db 'THE CARD IS 4 SPADE$'
card_5_spade db 'THE CARD IS 5 SPADE$'
card_6_sapde db 'THE CARD IS 6 SPADE$'
card_7_spade db 'THE CARD IS 7 OF SPADE$'
card_8_spade db 'THE CARD IS 8 OF SPADE $'
card_9_spade db 'THE CARD IS 9 OF SPADE$'
card_10_spade db 'THE CARD IS 10 OF SPADE$'
card_jack_spade db 'THE CARD IS JACK OF SPADE$'
card_queen_spade db 'THE CARD IS QUEEN OF SPADE$'
card_king_spade db 'THE CARD IS KING OF SPADE$'
card_ace_spade db 'THE CARD  IS ACE OF SPADE$'

card_2_heart db 'THE CARD IS 2 OF HEART$'
card_3_heart db 'THE CARD IS 3 OF HEART $'
card_4_heart db 'THE CARD IS 4 OF HEART$'
card_5_heart db 'THE CARD IS 5 OF HEART$'
card_6_heart db 'THE CARD IS 6 OF HEART$'
card_7_heart db 'THE CARD IS 7 OF HEART$'
card_8_heart db 'THE CARD IS 8 OF HEART $'
card_9_heart db 'THE CARD IS 9 OF HEART$'
card_10_heart db 'THE CARD IS 10 OF HEART$'
card_jack_heart db 'THE CARD IS JACK OF HEART$'
card_queen_heart db 'THE CARD IS QUEEN OF HEART$'
card_king_heart db 'THE CARD IS KING OF HEART$'
card_ace_heart db 'THE CARD  IS ACE OF HEART$'

card_2_clubs db 'THE CARD IS 2 OF CLUB$'
card_3_clubs db 'THE CARD IS 3 OF CLUB$'
card_4_clubs db 'THE CARD IS 4 OF CLUB$'
card_5_clubs db 'THE CARD IS 5 OF CLUB$'
card_6_clubs db 'THE CARD IS 6 OF CLUB$'
card_7_clubs db 'THE CARD IS 7 OF CLUB$'
card_8_clubs db 'THE CARD IS 8 OF CLUB$'
card_9_clubs db 'THE CARD IS 9 OF CLUB$'
card_10_clubs db 'THE CARD IS 10 OF CLUB$'
card_jack_clubs db 'THE CARD IS JACK OF CLUB$'
card_queen_clubs db 'THE CARD IS QUEEN OF CLUB$'
card_king_clubs db 'THE CARD IS KING OF CLUB$'
card_ace_clubs db 'THE CARD  IS ACE OF CLUB$'

card_2_diamonds db 'THE CARD IS 2 OF DIAMOND$'
card_3_diamonds db 'THE CARD IS 3 OF DIAMOND$'
card_4_diamonds db 'THE CARD IS 4 OF DIAMOND$'
card_5_diamonds db 'THE CARD IS 5 OF DIAMOND$'
card_6_diamonds db 'THE CARD IS 6 OF DIAMOND$'
card_7_diamonds db 'THE CARD IS 7 OF DIAMOND$'
card_8_diamonds db 'THE CARD IS 8 OF DIAMOND$'
card_9_diamonds db 'THE CARD IS 9 OF DIAMOND$'
card_10_diamonds db 'THE CARD IS 10 OF DIAMOND$'
card_jack_diamonds db 'THE CARD IS JACK OF DIAMOND$'
card_queen_diamonds db 'THE CARD IS QUEEN OF DIAMOND$'
card_king_diamonds db 'THE CARD IS KING OF DIAMOND$'
card_ace_diamonds db 'THE CARD IS ACE OF DIAMOND$'

Hit_Or_Stand_Message db 'hit or stand? $'
Info_Message db 'Press H to draw another card or press S to stand $'
PRESS_ANY_KEY DB 'press any key to continue$'
YOU_WIN_MEG DB 'You win$'
YOU_LOSE_MEG DB 'You lose$'
BUST_MEG DB 'Bust$'
BLACKJACK_MEG DB 'BLACKJACK YOU WIN$' 
TIE_MEG DB 'Its a tie$'
ANOTHER_GAME_MEG DB 'E - EXIT, R - ANOTHER GAME $'
COMPUTER_BUST_MEG DB 'THE DEALER BUSTED YOU WIN$'
YOU_WIN_SUMRIZE_MEG DB 'YOU WON A TOTAL OF,$ '
YOU_LOSE_SUMRIZE_MEG DB 'THE DEALER WON A TOTAL OF,$'
YOUR_TOTAL_POINTS_IS DB 'YOUR TOTAL POINTS IS,$ '
DEALER_TOTAL_POINTS_IS DB 'THE DEALER TOTAL POINTS IS,$ '


CHOICE db 0 
intArray db 51 dup (0)
index dw 0
TIME_AUX DB 0 
NOTE DW 3000H

PLAYER_TOTAL_POINT DB 30H
COMPUTER_TOTAL_POINT DB 30H

RANDOM_VALUE_ANSWER DB 0
 
COMPUTER_WIN_COUNTER DB 30H
PLAYER_WIN_COUNTER DB 30H

DEALER_TURN DB 0

SHOW_NUMBER DB 0

CODESEG


proc RANDOM  
		
RANDSTART:
   MOV AH, 00h  ; interrupts to get system time        
   INT 1AH      ; CX:DX now hold number of clock ticks since midnight      

   mov  ax, dx
   xor  dx, dx
   mov  cx, 51
   div  cx   ; here dx contains the remainder of the division - from 0 to 52
   add  dl, '0' 
  
  xor bx,bx
   check_52_times: ;check if the generated value come again
   
   mov al,[intArray+bx] ;move the array in the bx position to al
   cmp dl,al ; cmp if the generated value is equal to the value in the array
   je RANDSTART ; if yes generate another value
   inc bx ;inc bx
   cmp bx,51 ;cmp bx 51 time to check all the values in the array
   JL check_52_times ;run it 52 times
   
   mov bx,[index];moving the index to bx 
   mov [intArray+bx],dl ;move the new random value to the bx position(the index number)
   inc [index] ;inc the index
   
 
	
	mov[RANDOM_VALUE_ANSWER],dl 
	
	mov dl, 10
    mov ah,2
    int 21h
	  
RET 
endp RANDOM
 
PROC MAIN_GAME  
START_MAIN_GAME:
mov dx, offset Info_Message 
mov ah,9h
int 21h

mov dl, 10 ; MAKING A SPACEBAR PRESS
mov ah,2
int 21h



CHOICE_LABEL:
CALL DRAW_UI
;draw the ui and point
 ; DRAWING THE UI AND POINTS 
 

 CMP [PLAYER_TOTAL_POINT],45H
 JG BUST_TEMP
 JMP BELOW_21_POINTS
 BUST_TEMP:
 JMP BUST_RESULT
 BELOW_21_POINTS: ;IF THE VALUE IS BELOW 21 ANABLE TO KEEP DRAWING CARD
 
 
 
MOV AH,1h ;WAITING FOR KEY PRESS
INT 21H ; WAITING TOO
MOV [CHOICE],AL; moving the value to the CHOICE variable


CMP [CHOICE],'H';check if the player said yes
JE DARW_A_CARD_TEMP ;check if the player said yes
CMP [CHOICE],'h';check if the player said yes
JE DARW_A_CARD_TEMP ;check if the player said yes
CMP [CHOICE],'S' ;check if the player said no
JE COMPUTER_DRAW_A_CARD_TEMP ;check if the player said no
CMP [CHOICE],'s' ;check if the player said no
JE COMPUTER_DRAW_A_CARD_TEMP ;check if the player said no
JMP CHOICE_LABEL ;if none of the right button were pressed repeat

DARW_A_CARD_TEMP:
JMP DRAW_A_CARD

COMPUTER_DRAW_A_CARD_TEMP:
jmp COMPUTER_DRAW_A_CARD_START

DRAW_A_CARD: ; DRAWING A CARD
call RANDOM ; calling a random card

cmp [RANDOM_VALUE_ANSWER],30h
je DARW_CARD_0_TEMP
JMP NEXT_CARD_1
DARW_CARD_0_TEMP:
JMP DARW_CARD_0

NEXT_CARD_1:
cmp [RANDOM_VALUE_ANSWER],31h
je DARW_CARD_1_TEMP
JMP NEXT_CARD_2
DARW_CARD_1_TEMP:
JMP DARW_CARD_1

NEXT_CARD_2:
cmp [RANDOM_VALUE_ANSWER],32h
je DARW_CARD_2_TEMP
JMP NEXT_CARD_3
DARW_CARD_2_TEMP:
JMP DARW_CARD_2

NEXT_CARD_3:
cmp [RANDOM_VALUE_ANSWER],33h
je DARW_CARD_3_TEMP
JMP NEXT_CARD_4
DARW_CARD_3_TEMP:
JMP DARW_CARD_3

NEXT_CARD_4:
cmp [RANDOM_VALUE_ANSWER],34h
je DARW_CARD_4_TEMP
JMP NEXT_CARD_5
DARW_CARD_4_TEMP:
JMP DARW_CARD_4

NEXT_CARD_5:
cmp [RANDOM_VALUE_ANSWER],35h
je DARW_CARD_5_TEMP
JMP NEXT_CARD_6	
DARW_CARD_5_TEMP:
JMP DARW_CARD_5

NEXT_CARD_6:
cmp [RANDOM_VALUE_ANSWER],36h
je DARW_CARD_6_TEMP
JMP NEXT_CARD_7
DARW_CARD_6_TEMP:
JMP DARW_CARD_6

NEXT_CARD_7:
cmp [RANDOM_VALUE_ANSWER],37h
je DARW_CARD_7_TEMP
JMP NEXT_CARD_8
DARW_CARD_7_TEMP:
JMP DARW_CARD_7

NEXT_CARD_8:
cmp [RANDOM_VALUE_ANSWER],38h
je DARW_CARD_8_TEMP
JMP NEXT_CARD_9
DARW_CARD_8_TEMP:
JMP DARW_CARD_8

NEXT_CARD_9:
cmp [RANDOM_VALUE_ANSWER],39h
je DARW_CARD_9_TEMP
JMP NEXT_CARD_10
DARW_CARD_9_TEMP:
JMP DARW_CARD_9

NEXT_CARD_10:
cmp [RANDOM_VALUE_ANSWER],3ah
je DARW_CARD_10_TEMP
JMP NEXT_CARD_11
DARW_CARD_10_TEMP:
JMP DARW_CARD_10

NEXT_CARD_11:
cmp [RANDOM_VALUE_ANSWER],3bh
je DARW_CARD_11_TEMP
JMP NEXT_CARD_12
DARW_CARD_11_TEMP:
JMP DARW_CARD_11

NEXT_CARD_12:
cmp [RANDOM_VALUE_ANSWER],3ch
je DARW_CARD_12_TEMP
JMP NEXT_CARD_13
DARW_CARD_12_TEMP:
JMP DARW_CARD_12

NEXT_CARD_13:
cmp [RANDOM_VALUE_ANSWER],3dh
je DARW_CARD_13_TEMP
JMP NEXT_CARD_14
DARW_CARD_13_TEMP:
JMP DARW_CARD_13

NEXT_CARD_14:
cmp [RANDOM_VALUE_ANSWER],3eh
je DARW_CARD_14_TEMP
JMP NEXT_CARD_15
DARW_CARD_14_TEMP:
JMP DARW_CARD_14

NEXT_CARD_15:
cmp [RANDOM_VALUE_ANSWER],3fh
je DARW_CARD_15_TEMP
JMP NEXT_CARD_16
DARW_CARD_15_TEMP:
JMP DARW_CARD_15

NEXT_CARD_16:
cmp [RANDOM_VALUE_ANSWER],40h
je DARW_CARD_16_TEMP
JMP NEXT_CARD_17
DARW_CARD_16_TEMP:
JMP DARW_CARD_16

NEXT_CARD_17:
cmp [RANDOM_VALUE_ANSWER],41h
je DARW_CARD_17_TEMP
JMP NEXT_CARD_18
DARW_CARD_17_TEMP:
JMP DARW_CARD_17

NEXT_CARD_18:
cmp [RANDOM_VALUE_ANSWER],42h
je DARW_CARD_18_TEMP
jmp NEXT_CARD_19
DARW_CARD_18_TEMP:
JMP DARW_CARD_18

NEXT_CARD_19:
cmp [RANDOM_VALUE_ANSWER],43h
je DARW_CARD_19_TEMP
JMP NEXT_CARD_20
DARW_CARD_19_TEMP:
JMP DARW_CARD_19

NEXT_CARD_20:
cmp [RANDOM_VALUE_ANSWER],44h
je DARW_CARD_20_TEMP
JMP NEXT_CARD_21
DARW_CARD_20_TEMP:
JMP DARW_CARD_20

NEXT_CARD_21:
cmp [RANDOM_VALUE_ANSWER],45h
je DARW_CARD_21_TEMP
JMP NEXT_CARD_22
DARW_CARD_21_TEMP:
JMP DARW_CARD_21

NEXT_CARD_22:
cmp [RANDOM_VALUE_ANSWER],46h
je DARW_CARD_22_TEMP
JMP NEXT_CARD_23
DARW_CARD_22_TEMP:
JMP DARW_CARD_22

NEXT_CARD_23:
cmp [RANDOM_VALUE_ANSWER],47h
je DARW_CARD_23_TEMP
JMP NEXT_CARD_24
DARW_CARD_23_TEMP:
JMP DARW_CARD_23

NEXT_CARD_24:
cmp [RANDOM_VALUE_ANSWER],48h
je DARW_CARD_24_TEMP
JMP NEXT_CARD_25
DARW_CARD_24_TEMP:
JMP DARW_CARD_24

NEXT_CARD_25:
cmp [RANDOM_VALUE_ANSWER],49h
je DARW_CARD_25_TEMP
JMP NEXT_CARD_26
DARW_CARD_25_TEMP:
JMP DARW_CARD_25

NEXT_CARD_26:
cmp [RANDOM_VALUE_ANSWER],4ah
je DARW_CARD_26_TEMP
JMP NEXT_CARD_27
DARW_CARD_26_TEMP:
JMP DARW_CARD_26

NEXT_CARD_27:
cmp [RANDOM_VALUE_ANSWER],4bh
je DARW_CARD_27_TEMP
JMP NEXT_CARD_28
DARW_CARD_27_TEMP:
JMP DARW_CARD_27

NEXT_CARD_28:
cmp [RANDOM_VALUE_ANSWER],4ch
je DARW_CARD_28_TEMP
JMP NEXT_CARD_29
DARW_CARD_28_TEMP:
JMP DARW_CARD_28

NEXT_CARD_29:
cmp [RANDOM_VALUE_ANSWER],4dh
je DARW_CARD_29_TEMP
JMP NEXT_CARD_30
DARW_CARD_29_TEMP:
JMP DARW_CARD_29

NEXT_CARD_30:
cmp [RANDOM_VALUE_ANSWER],4eh
je DARW_CARD_30_TEMP
JMP NEXT_CARD_31
DARW_CARD_30_TEMP:
JMP DARW_CARD_30

NEXT_CARD_31:
cmp [RANDOM_VALUE_ANSWER],4fh
je DARW_CARD_31_TEMP
JMP NEXT_CARD_32
DARW_CARD_31_TEMP:
JMP DARW_CARD_31

NEXT_CARD_32:
cmp [RANDOM_VALUE_ANSWER],50h
je DARW_CARD_32_TEMP
JMP NEXT_CARD_33
DARW_CARD_32_TEMP:
JMP DARW_CARD_32

NEXT_CARD_33:
cmp [RANDOM_VALUE_ANSWER],51h
je DARW_CARD_33_TEMP
JMP NEXT_CARD_34
DARW_CARD_33_TEMP:
JMP DARW_CARD_33

NEXT_CARD_34:
cmp [RANDOM_VALUE_ANSWER],52h
je DARW_CARD_34_TEMP
JMP NEXT_CARD_35
DARW_CARD_34_TEMP:
JMP DARW_CARD_34

NEXT_CARD_35:
cmp [RANDOM_VALUE_ANSWER],53h
je DARW_CARD_35_TEMP
JMP NEXT_CARD_36
DARW_CARD_35_TEMP:
JMP DARW_CARD_35

NEXT_CARD_36:
cmp [RANDOM_VALUE_ANSWER],54h
je DARW_CARD_36_TEMP
JMP NEXT_CARD_37
DARW_CARD_36_TEMP:
JMP DARW_CARD_36
NEXT_CARD_37:

cmp [RANDOM_VALUE_ANSWER],55h
je DARW_CARD_37_TEMP
JMP NEXT_CARD_38
DARW_CARD_37_TEMP:
JMP DARW_CARD_37

NEXT_CARD_38:
cmp [RANDOM_VALUE_ANSWER],56h
je DARW_CARD_38_TEMP
JMP NEXT_CARD_39
DARW_CARD_38_TEMP:
JMP DARW_CARD_38

NEXT_CARD_39:
cmp [RANDOM_VALUE_ANSWER],57h
je DARW_CARD_39_TEMP
JMP NEXT_CARD_40
DARW_CARD_39_TEMP:
JMP DARW_CARD_39

NEXT_CARD_40:
cmp [RANDOM_VALUE_ANSWER],58h
je DARW_CARD_40_TEMP
JMP NEXT_CARD_41
DARW_CARD_40_TEMP:
JMP DARW_CARD_40

NEXT_CARD_41:
cmp [RANDOM_VALUE_ANSWER],59h
je DARW_CARD_41_TEMP
JMP NEXT_CARD_42
DARW_CARD_41_TEMP:
JMP DARW_CARD_41

NEXT_CARD_42:
cmp [RANDOM_VALUE_ANSWER],5ah
je DARW_CARD_42_TEMP
JMP NEXT_CARD_43
DARW_CARD_42_TEMP:
JMP DARW_CARD_42

NEXT_CARD_43:
cmp [RANDOM_VALUE_ANSWER],5bh
je DARW_CARD_43_TEMP
JMP NEXT_CARD_44
DARW_CARD_43_TEMP:
JMP DARW_CARD_43

NEXT_CARD_44:
cmp [RANDOM_VALUE_ANSWER],5ch
je DARW_CARD_44_TEMP
JMP NEXT_CARD_45
DARW_CARD_44_TEMP:
JMP DARW_CARD_44

NEXT_CARD_45:
cmp [RANDOM_VALUE_ANSWER],5dh
je DARW_CARD_45_TEMP
JMP NEXT_CARD_46
DARW_CARD_45_TEMP:
JMP DARW_CARD_45

NEXT_CARD_46:
cmp [RANDOM_VALUE_ANSWER],5eh
je DARW_CARD_46_TEMP
JMP NEXT_CARD_47
DARW_CARD_46_TEMP:
JMP DARW_CARD_46

NEXT_CARD_47:
cmp [RANDOM_VALUE_ANSWER],5fh
je DARW_CARD_47_TEMP
JMP NEXT_CARD_48
DARW_CARD_47_TEMP:
JMP DARW_CARD_47

NEXT_CARD_48:
cmp [RANDOM_VALUE_ANSWER],60h
je DARW_CARD_48_TEMP
JMP NEXT_CARD_49
DARW_CARD_48_TEMP:
JMP DARW_CARD_48

NEXT_CARD_49:
cmp [RANDOM_VALUE_ANSWER],61h
je DARW_CARD_49_TEMP
JMP NEXT_CARD_50
DARW_CARD_49_TEMP:
JMP DARW_CARD_49

NEXT_CARD_50:
cmp [RANDOM_VALUE_ANSWER],62h
je DARW_CARD_50_TEMP
jmp NEXT_CARD_51
DARW_CARD_50_TEMP:
JMP DARW_CARD_50

NEXT_CARD_51:
cmp [RANDOM_VALUE_ANSWER],63h
je DARW_CARD_51_TEMP
DARW_CARD_51_TEMP:
JMP DARW_CARD_51

;HERE IS THE PART WHEN THE CARDS GET THE VALUE 

DARW_CARD_0: ;2 OF SPADE

CMP [DEALER_TURN],1
JE   DEALER_DRAW_CARD_0
ADD [PLAYER_TOTAL_POINT],2H
mov dx, offset card_2_spade
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL

DEALER_DRAW_CARD_0:
ADD [COMPUTER_TOTAL_POINT],2H
mov dx, offset card_2_spade
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_1: ;3 OF SPADE
CMP [DEALER_TURN],1
JE   DEALER_DRAW_CARD_1
ADD [PLAYER_TOTAL_POINT],3H
mov dx, offset card_3_spade
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL

DEALER_DRAW_CARD_1:
ADD [COMPUTER_TOTAL_POINT],3H

mov dx, offset card_3_spade
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_2: ;4 OF SPADE
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_2
ADD [PLAYER_TOTAL_POINT],4H
mov dx, offset card_4_spade
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_2:
ADD [COMPUTER_TOTAL_POINT],4H
mov dx, offset card_4_spade
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_3: ;5 OF SPADE
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_3
ADD [PLAYER_TOTAL_POINT],5H
mov dx, offset card_5_spade
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_3:
ADD [COMPUTER_TOTAL_POINT],5H
mov dx, offset card_5_spade
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_4: ; 6 OF SPADE
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_4
ADD [PLAYER_TOTAL_POINT],6H
mov dx, offset card_6_sapde
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_4:
ADD [COMPUTER_TOTAL_POINT],6H
mov dx, offset card_6_sapde
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_5: ;7 OF SPADE
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_5
ADD [PLAYER_TOTAL_POINT],7H
mov dx, offset card_7_spade
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_5:
ADD [COMPUTER_TOTAL_POINT],7H
mov dx, offset card_7_spade
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_6: ;8 OF SPADE
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_6
ADD [PLAYER_TOTAL_POINT],8H
mov dx, offset card_8_spade
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL

DEALER_DRAW_CARD_6:
ADD [COMPUTER_TOTAL_POINT],8H
mov dx, offset card_8_spade
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_7: ;9 OF SPADE
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_7
ADD [PLAYER_TOTAL_POINT],9H
mov dx, offset card_9_spade
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_7:
ADD [COMPUTER_TOTAL_POINT],9H
mov dx, offset card_9_spade
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_8: ; 10 OF SPADE
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_8
ADD [PLAYER_TOTAL_POINT],0AH
mov dx, offset card_10_spade
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_8:
ADD [COMPUTER_TOTAL_POINT],0AH
mov dx, offset card_10_spade
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_9: ; JACK OF SPADE
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_9
ADD [PLAYER_TOTAL_POINT],0AH
mov dx, offset card_jack_spade
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_9:
ADD [COMPUTER_TOTAL_POINT],0AH
mov dx, offset card_jack_spade
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_10: ;QUEEN OF SPADE
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_10
ADD [PLAYER_TOTAL_POINT],0AH
mov dx, offset card_queen_spade
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_10:
ADD [COMPUTER_TOTAL_POINT],0AH
mov dx, offset card_queen_spade
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_11: ;KING OF SPADE
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_11
ADD [PLAYER_TOTAL_POINT],0AH
mov dx, offset card_king_spade
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL

DEALER_DRAW_CARD_11:
ADD [COMPUTER_TOTAL_POINT],0AH
mov dx, offset card_king_spade
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_12: ;ACE OF SPADE
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_12
ADD [PLAYER_TOTAL_POINT],0AH
mov dx, offset card_ace_spade
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL

DEALER_DRAW_CARD_12:
ADD [COMPUTER_TOTAL_POINT],0AH
mov dx, offset card_ace_spade
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_13: ; 2 OF HEART 
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_13
ADD [PLAYER_TOTAL_POINT],2H
mov dx, offset card_2_heart
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL

DEALER_DRAW_CARD_13:
ADD [COMPUTER_TOTAL_POINT],2H
mov dx, offset card_ace_spade
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_14: ;3 OF HEART
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_14 
ADD [PLAYER_TOTAL_POINT],3H
mov dx, offset card_3_heart
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL

DEALER_DRAW_CARD_14:
ADD [COMPUTER_TOTAL_POINT],3H
mov dx, offset card_3_heart
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_15: ; 4 OF HEART 
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_15
ADD [PLAYER_TOTAL_POINT],4H
mov dx, offset card_4_heart
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_15:
ADD [COMPUTER_TOTAL_POINT],4H
mov dx, offset card_4_heart
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_16: ; 5 OF HEART 
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_16
ADD [PLAYER_TOTAL_POINT],5H
mov dx, offset card_5_diamonds
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL

DEALER_DRAW_CARD_16:
ADD [COMPUTER_TOTAL_POINT],5H
mov dx, offset card_5_diamonds
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_17: ; 6 OF HEART 
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_17
ADD [PLAYER_TOTAL_POINT],6H
mov dx, offset card_6_heart
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_17:
ADD [COMPUTER_TOTAL_POINT],6H
mov dx, offset card_6_heart
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_18: ; 7 OF HEART 
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_18
ADD [PLAYER_TOTAL_POINT],7H
mov dx, offset card_7_heart
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_18:
ADD [COMPUTER_TOTAL_POINT],7H
mov dx, offset card_7_heart
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START


DARW_CARD_19: ; 8 OF HEART 
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_19
ADD [PLAYER_TOTAL_POINT],8H
mov dx, offset card_8_heart
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_19:
ADD [COMPUTER_TOTAL_POINT],8H
mov dx, offset card_8_heart
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_20: ; 9 OF HEART
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_20 
ADD [PLAYER_TOTAL_POINT],9H
mov dx, offset card_9_heart
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_20:
ADD [COMPUTER_TOTAL_POINT],9H
mov dx, offset card_9_heart
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_21: ;10 OF HEART 
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_21
ADD [PLAYER_TOTAL_POINT],0AH
mov dx, offset card_10_heart
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_21:
ADD [COMPUTER_TOTAL_POINT],0AH
mov dx, offset card_10_heart
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START


DARW_CARD_22: ; JACK OF HEART 
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_22
ADD [PLAYER_TOTAL_POINT],0AH
mov dx, offset card_jack_heart
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_22:
ADD [COMPUTER_TOTAL_POINT],0AH
mov dx, offset card_jack_heart
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START


DARW_CARD_23: ; QUEEN OF HEART 
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_23
ADD [PLAYER_TOTAL_POINT],0AH
mov dx, offset card_queen_heart
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_23:
ADD [COMPUTER_TOTAL_POINT],0AH
mov dx, offset card_queen_heart
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_24: ; KING OF HEART 
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_24
ADD [PLAYER_TOTAL_POINT],0AH
mov dx, offset card_king_heart
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_24:
ADD [COMPUTER_TOTAL_POINT],0AH
mov dx, offset card_king_heart
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_25: ; ACE OF HEART 
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_25
ADD [PLAYER_TOTAL_POINT],0AH
mov dx, offset card_ace_diamonds
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_25:
ADD [COMPUTER_TOTAL_POINT],0AH
mov dx, offset card_ace_diamonds
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_26: ;2 OF CLUB 
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_26
ADD [PLAYER_TOTAL_POINT],2H
mov dx, offset card_2_clubs
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_26:
ADD [COMPUTER_TOTAL_POINT],2H
mov dx, offset card_2_clubs
mov ah,9h
int 21h

JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_27: ;3 OF CLUB 
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_27
ADD [PLAYER_TOTAL_POINT],3H
mov dx, offset card_3_clubs
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_27:
ADD [COMPUTER_TOTAL_POINT],3H
mov dx, offset card_3_clubs
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_28: ; 4 OF CLUB 
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_28
ADD [PLAYER_TOTAL_POINT],4H
mov dx, offset card_4_clubs
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_28:
ADD [COMPUTER_TOTAL_POINT],4H
mov dx, offset card_4_clubs
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_29:  ;5 OF CLUB 
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_29
ADD [PLAYER_TOTAL_POINT],5H
mov dx, offset card_5_clubs
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_29:
ADD [COMPUTER_TOTAL_POINT],5H
mov dx, offset card_5_clubs
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_30: ;6 OF CLUB 
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_30
ADD [PLAYER_TOTAL_POINT],6H
mov dx, offset card_6_clubs
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_30:
ADD [COMPUTER_TOTAL_POINT],6H
mov dx, offset card_6_clubs
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_31: ;7 OF CLUB 
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_31
ADD [PLAYER_TOTAL_POINT],7H
mov dx, offset card_7_clubs
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_31:
ADD [COMPUTER_TOTAL_POINT],7H
mov dx, offset card_7_clubs
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_32: ;8 OF CLUB 
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_32
ADD [PLAYER_TOTAL_POINT],8H
mov dx, offset card_8_clubs
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_32:
ADD [COMPUTER_TOTAL_POINT],8H
mov dx, offset card_8_clubs
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_33: ; 9 OF CLUB 
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_33
ADD [PLAYER_TOTAL_POINT],9H
mov dx, offset card_9_clubs
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_33:
ADD [COMPUTER_TOTAL_POINT],9H
mov dx, offset card_9_clubs
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_34: ; 10 OF CLUB 
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_34
ADD [PLAYER_TOTAL_POINT],0AH
mov dx, offset card_10_clubs
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_34:
ADD [COMPUTER_TOTAL_POINT],0AH
mov dx, offset card_10_clubs
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_35: ;JACK OF CLUB 
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_35
ADD [PLAYER_TOTAL_POINT],0AH
mov dx, offset card_jack_clubs
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_35:
ADD [COMPUTER_TOTAL_POINT],0AH
mov dx, offset card_jack_clubs
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_36: ; QUEEN OF CLUB
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_36
ADD [PLAYER_TOTAL_POINT],0AH
mov dx, offset card_queen_clubs
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_36:
ADD [COMPUTER_TOTAL_POINT],0AH
mov dx, offset card_queen_clubs
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_37: ; KING OF CLUB 
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_37
ADD [PLAYER_TOTAL_POINT],0AH
mov dx, offset card_king_clubs
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_37:
ADD [COMPUTER_TOTAL_POINT],0AH
mov dx, offset card_king_clubs
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START


DARW_CARD_38: ; ACE OF CLUB 
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_38
ADD [PLAYER_TOTAL_POINT],0AH 
mov dx, offset card_ace_clubs
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_38:
ADD [COMPUTER_TOTAL_POINT],0AH
mov dx, offset card_ace_clubs
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_39: ; 2 OF DIAMOND
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_39
ADD [PLAYER_TOTAL_POINT],2H
mov dx, offset card_2_diamonds
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_39:
ADD [COMPUTER_TOTAL_POINT],2H
mov dx, offset card_2_diamonds
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_40: ; 3 OF DIAMOND
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_40
ADD [PLAYER_TOTAL_POINT],3H 
mov dx, offset card_3_diamonds
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_40:
ADD [COMPUTER_TOTAL_POINT],3H
mov dx, offset card_3_diamonds
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_41: ; 4 OF DIAMOND
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_41
ADD [PLAYER_TOTAL_POINT],4H
mov dx, offset card_4_diamonds
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_41:
ADD [COMPUTER_TOTAL_POINT],4H
mov dx, offset card_4_diamonds
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_42: ; 5 OF DIAMOND
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_42
ADD [PLAYER_TOTAL_POINT],5H
mov dx, offset card_5_diamonds
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_42:
ADD [COMPUTER_TOTAL_POINT],5H
mov dx, offset card_5_diamonds
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_43: ; 6 OF DIAMOND
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_43
ADD [PLAYER_TOTAL_POINT],6H
mov dx, offset card_6_diamonds
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_43:
ADD [COMPUTER_TOTAL_POINT],6H
mov dx, offset card_6_diamonds
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_44: ; 7 OF DIAMOND
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_44
ADD [PLAYER_TOTAL_POINT],7H
mov dx, offset card_7_diamonds
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_44:
ADD [COMPUTER_TOTAL_POINT],7H
mov dx, offset card_7_diamonds
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_45: ;8 OF DIAMOND
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_45
ADD [PLAYER_TOTAL_POINT],8H
mov dx, offset card_8_diamonds
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_45:
ADD [COMPUTER_TOTAL_POINT],8H
mov dx, offset card_8_diamonds
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_46: ; 9 OF DIAMOND
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_46
ADD [PLAYER_TOTAL_POINT],9H
mov dx, offset card_9_diamonds
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_46:
ADD [COMPUTER_TOTAL_POINT],9H
mov dx, offset card_9_diamonds
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_47: ; 10 OF DIAMOND
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_47
ADD [PLAYER_TOTAL_POINT],0AH
mov dx, offset card_10_diamonds
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_47:
ADD [COMPUTER_TOTAL_POINT],0AH
mov dx, offset card_10_diamonds
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_48: ; JACK OF DIAMOND
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_48
ADD [PLAYER_TOTAL_POINT],0AH
mov dx, offset card_jack_diamonds
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_48:
ADD [COMPUTER_TOTAL_POINT],0AH
mov dx, offset card_jack_diamonds
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_49: ; QUEEN OF DIAMOND
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_49
ADD [PLAYER_TOTAL_POINT],0AH
mov dx, offset card_queen_diamonds
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_49:
ADD [COMPUTER_TOTAL_POINT],0AH
mov dx, offset card_queen_diamonds
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_50: ; KING OF DIAMOND
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_50
ADD [PLAYER_TOTAL_POINT],0AH
mov dx, offset card_king_diamonds
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_50:
ADD [COMPUTER_TOTAL_POINT],0AH
mov dx, offset card_king_diamonds
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START

DARW_CARD_51: ; ACE OF DIAMOND
CMP [DEALER_TURN],1
JE  DEALER_DRAW_CARD_51
ADD [PLAYER_TOTAL_POINT],0AH
mov dx, offset card_ace_diamonds
mov ah,9h
int 21h

mov dl, 10
mov ah,2
int 21h

jmp CHOICE_LABEL
DEALER_DRAW_CARD_51:
ADD [COMPUTER_TOTAL_POINT],0AH
mov dx, offset card_ace_diamonds
mov ah,9h
int 21h
JMP COMPUTER_DRAW_A_CARD_START


;HERE THE COMPUTER DRAW A CARD AND THE RULES OF THE DEALER HAPPEND
COMPUTER_DRAW_A_CARD_START:

mov dl, 10 ; MAKING A SPACEBAR PRESS
mov ah,2
int 21h



CALL DEALER_UI  ;calling the dealer ui
MOV [DEALER_TURN],1 ;MAKEING THE DEALER DRAW THE CARD
CMP [COMPUTER_TOTAL_POINT],45H;CHECKING IF THE DEALER HAS BUST
JG  COMPUTER_BUST_RESULT_TEMP ;CHECKING IF THE DEALER HAS BUST
cmp [COMPUTER_TOTAL_POINT],40H ;IF THE COMPUTER TOTAL POINT IS BELOW  OR EXACTLY 16 WILL DRAW ANOTHER CARD
JL DEALER_DRAW_TEMP ;IF THE COMPUTER TOTAL POINT IS BELOW  OR EXACTLY 16 WILL DRAW ANOTHER CARD
JMP CALCULATING_POINTS ;WILL CHECK THE POINT OF THE DEALER VS THE PLAYER

COMPUTER_BUST_RESULT_TEMP:
JMP COMPUTER_BUST_RESULT

DEALER_DRAW_TEMP:

CALL DELAY

mov dl, 10;MAKEING SPACE IN BETWEEN LINE
mov ah,2
int 21h

JMP DRAW_A_CARD


CALCULATING_POINTS: ; HERE ALL THE MATH IS HAPPENING
MOV AL,[PLAYER_TOTAL_POINT];MAKEING THE AL REGISTER THE PLAYER POINTS TOTAL

CMP AL,[COMPUTER_TOTAL_POINT];CMP THE TWO VALUES
JE TIE_RESULT ;  CHECKING IF THEY ARE EQUAL 
CMP AL,[COMPUTER_TOTAL_POINT];CMP THE TWO VALUES
JB LOSE_RESULT; IF THE PLAYER POINT ARE BELOW THE COMPUTER
CMP AL,[COMPUTER_TOTAL_POINT] ;CHECKING IF YOU WON 
JG WIN_RESULT ; IF YOU WIN WILL SEND YOU TO THE WINING STAGE

TIE_RESULT: ;IF THE RESULT IS A TIE
CALL CLEAR_SCREEN
mov dx, offset TIE_MEG
mov ah,9h
int 21h
MOV [NOTE],5500H
CALL SOUND
JMP ANOTHER_GAME

LOSE_RESULT: ; IF YOU LOST THE GAME BUT DIDN'T BUST 
CALL CLEAR_SCREEN
mov dx, offset YOU_LOSE_MEG
mov ah,9h
int 21h
MOV [NOTE],3000H
CALL SOUND
INC [COMPUTER_WIN_COUNTER] ;INC THE COMPUTER WIN COUNTER
JMP ANOTHER_GAME

BUST_RESULT: ;IF YOU BUSTED
CALL CLEAR_SCREEN
mov dx, offset BUST_MEG
mov ah,9h
int 21h
MOV [NOTE],4000H
CALL SOUND
INC [COMPUTER_WIN_COUNTER] ; INC THE COMPUTER WIN COUNTER 
JMP ANOTHER_GAME

COMPUTER_BUST_RESULT: ; IF THE COMPUTER HAS BUST PRINTING TO THE SCREEN AND INC YOUR WIN COUNTER 
CALL CLEAR_SCREEN
mov dx, offset COMPUTER_BUST_MEG
mov ah,9h
int 21h

mov dl, 10 ; MAKE A SPACE 
mov ah,2
int 21h
MOV [NOTE],1250H
CALL SOUND 

INC [PLAYER_WIN_COUNTER] ; INC THE PLAYER WIN COUNTER
JMP ANOTHER_GAME

WIN_RESULT: ; IF YOU HAVE MORE POINTS THAN THE COMPUTER
CALL CLEAR_SCREEN
cmp [PLAYER_TOTAL_POINT],45H
JE BLACKJACK
mov dx, offset YOU_WIN_MEG
mov ah,9h
int 21h
mov [NOTE],1000h 
Call SOUND ;making a sound
JMP NO_BLACKJACK
BLACKJACK:
mov dx, offset BLACKJACK_MEG
mov ah,9h
int 21h
mov [NOTE], 0950h
Call SOUND ;Makeing a sound
NO_BLACKJACK:
INC [PLAYER_WIN_COUNTER]; INC THE PLAYER WIN COUNTER
JMP ANOTHER_GAME
ANOTHER_GAME:

mov dl, 10 ; MAKE A SPACE IN BETWEEN MEG'S
mov ah,2
int 21h

mov dx, offset ANOTHER_GAME_MEG
mov ah,9h
int 21h
 
WAITING_FOR_KEY_PRESS_ANOTHER_GAME: ; HERE WE ARE CHECKING IF THE PLAYER WANT TO PLAY ANOTHER GAME OR QUIT
MOV AH,1h ;WAITING FOR KEY PRESS
INT 21H ; WAITING TOO
CMP AL,'R'
JE ANOTHER_GAME_STATS_RESET
CMP AL,'r'
JE ANOTHER_GAME_STATS_RESET ; THE GAME WILL BE RESTARTED AND START ANEW
CMP AL, 'E'
JE SHOW_EXIT_SCREEN
CMP AL,'e'
JE SHOW_EXIT_SCREEN ; WILL EXIT THE GAME AND SHOW STATS 
JMP WAITING_FOR_KEY_PRESS_ANOTHER_GAME


ANOTHER_GAME_STATS_RESET: ; THE GAME WILL BE RESTARTED AND START ANEW
MOV [PLAYER_TOTAL_POINT],30H
MOV [COMPUTER_TOTAL_POINT],30H
MOV [INDEX],0
MOV [RANDOM_VALUE_ANSWER],0
MOV [DEALER_TURN],0
XOR BX,BX

;RESETING THE DECK
DO_IT_52_TIME:
mov [intArray+bx],0 ;move 0 TO THE BX PLACEMNT
inc BX
CMP BX,52
JNE DO_IT_52_TIME ; 
CALL CLEAR_SCREEN ; CLEARING THE SCREEN
JMP START_MAIN_GAME

SHOW_EXIT_SCREEN: ; WILL EXIT THE GAME AND SHOW STATS
CALL CLEAR_SCREEN



mov dl,10 ; MAKE A SPACE IN THE LINES
mov ah,2
int 21h

CMP [PLAYER_WIN_COUNTER],3AH
JGE ABOVE_10_WIN_PLAYER
JMP ONLY_ONE_TIME_PLAYER
ABOVE_10_WIN_PLAYER:
SUB [COMPUTER_WIN_COUNTER],0AH

mov dx, offset YOU_WIN_SUMRIZE_MEG
mov ah,9h
int 21h

MOV DL,31H ;ADDING 1 
MOV AH,2H
INT 21H

 
MOV DL,[PLAYER_WIN_COUNTER]  ;SHOWING HOW MANY TIMES THE PLAYER WON
MOV AH,2H
INT 21h

JMP DEALER_TURN_CMP
ONLY_ONE_TIME_PLAYER:
mov dx, offset YOU_WIN_SUMRIZE_MEG
mov ah,9h
int 21h


 
MOV DL,[PLAYER_WIN_COUNTER] ;SHOWING HOW MANY TIMES YOU WON 
MOV AH,2H
INT 21h

mov dl,10 ; MAKE A SPACE IN THE LINES
mov ah,2
int 21h

mov dl,10 ; MAKE A SPACE IN THE LINES
mov ah,2
int 21h

DEALER_TURN_CMP:
CMP [COMPUTER_WIN_COUNTER],3AH
JGE ABOVE_10_WIN
JMP ONLY_ONE_TIME
ABOVE_10_WIN:
SUB [COMPUTER_WIN_COUNTER],0AH
JMP SHOW_POINT_ABOVE_10
ONLY_ONE_TIME:
mov dx, offset YOU_LOSE_SUMRIZE_MEG ;SHOWING HOW MANY TIMES THE DEALER WON
mov ah,9h
int 21h

 
MOV DL,[COMPUTER_WIN_COUNTER]  ;SHOWING HOW MANY TIMES THE DEALER WON
MOV AH,2H
INT 21h

mov dl,10 ; MAKE A SPACE IN THE LINES
mov ah,2
int 21h
JMP PRESS_ANY_KEY_2;WILL SKIP THE PART IF YOU GOT LOSS THAN 10 WINS 
SHOW_POINT_ABOVE_10:
mov dl,10 ; MAKE A SPACE IN THE LINES
mov ah,2
int 21h

mov dx, offset YOU_LOSE_SUMRIZE_MEG ;SHOWING HOW MANY TIMES THE DEALER WON
mov ah,9h
int 21h

MOV DL,31H
MOV AH,2H
INT 21H

 
MOV DL,[COMPUTER_WIN_COUNTER]  ;SHOWING HOW MANY TIMES THE DEALER WON
MOV AH,2H
INT 21h

mov dl,10 ; MAKE A SPACE IN THE LINES
mov ah,2
int 21h

PRESS_ANY_KEY_2:

mov dl,10 ; MAKE A SPACE IN THE LINES
mov ah,2
int 21h

mov dx, offset PRESS_ANY_KEY ;WAITING FOR KEYPRESS
mov ah,9h
int 21h

    
	
MOV AH,1h ;WAITING FOR KEY PRESS
INT 21H ; WAITING TOO

CALL CLEAR_SCREEN

RET
ENDP MAIN_GAME

PROC DRAW_UI

mov dl, 10 ; MAKING A SPACEBAR PRESS
mov ah,2
int 21h
 
mov dx, offset YOUR_TOTAL_POINTS_IS
mov ah,9h
int 21h



MOV AL,[PLAYER_TOTAL_POINT] 
MOV [SHOW_NUMBER],AL ; MAKING THEM SHOW THE NUMBER WITHOUT CHANGE THE PLAYER TOTAL POINTS
CMP [PLAYER_TOTAL_POINT],44H ; IF THE POITNS IS ABOVE 20 OR EQUEL TO  
JGE ABOVE_20_POINTS
JMP BELOW_20_POINTS
ABOVE_20_POINTS: ; IF THE TOTAL POINTS IS ABOVE 20
MOV DL,32H
MOV AH,2H
INT 21h
SUB [SHOW_NUMBER],0AH
SUB [SHOW_NUMBER],0AH
JMP BELOW_10_POINTS

BELOW_20_POINTS: ; IF IT'S BELOW 20
CMP [SHOW_NUMBER],3AH
JGE ABOVE_10_POINTS 
JMP BELOW_10_POINTS 
ABOVE_10_POINTS:
SUB [SHOW_NUMBER],0AH

MOV DL,31H
MOV AH,2H
INT 21h
BELOW_10_POINTS: ; IF IT'S BELOW 10
MOV DL,[SHOW_NUMBER]
MOV AH,2H
INT 21h

mov dl, 10 ; MAKING A SPACEBAR PRESS
mov ah,2
int 21h


mov dl, 10 ; MAKING A SPACEBAR PRESS
mov ah,2
int 21h

END_DRAW_UI:
RET
ENDP DRAW_UI

PROC DEALER_UI
mov dl, 10 ; MAKING A SPACEBAR PRESS
mov ah,2
int 21h

mov dx, offset DEALER_TOTAL_POINTS_IS
mov ah,9h
int 21h

MOV AL,[COMPUTER_TOTAL_POINT] 
MOV [SHOW_NUMBER],AL ; MAKING THEM SHOW THE NUMBER WITHOUT CHANGE THE PLAYER TOTAL POINTS
CMP [COMPUTER_TOTAL_POINT],44H ; IF THE POITNS IS ABOVE 20 OR EQUEL TO  
JGE ABOVE_20_POINTS_DEALER
JMP BELOW_20_POINTS_DEALER
ABOVE_20_POINTS_DEALER: ; IF THE TOTAL POINTS IS ABOVE 20
MOV DL,32H
MOV AH,2H
INT 21h
SUB [SHOW_NUMBER],0AH
SUB [SHOW_NUMBER],0AH
JMP BELOW_10_POINTS_DEALER

BELOW_20_POINTS_DEALER: ; IF IT'S BELOW 20
CMP [SHOW_NUMBER],3AH
JGE ABOVE_10_POINTS_DEALER 
JMP BELOW_10_POINTS_DEALER 
ABOVE_10_POINTS_DEALER:
SUB [SHOW_NUMBER],0AH

MOV DL,31H
MOV AH,2H
INT 21h
BELOW_10_POINTS_DEALER: ; IF IT'S BELOW 10
MOV DL,[SHOW_NUMBER]
MOV AH,2H
INT 21h

mov dl, 10 ; MAKING A SPACEBAR PRESS
mov ah,2
int 21h
 


RET
ENDP DEALER_UI

PROC CLEAR_SCREEN

mov ax,13h
int 10h

RET
ENDP CLEAR_SCREEN  

proc SOUND
; open speaker
in al, 61h
or al, 00000011b
out 61h, al
; send control word to change frequency
mov al, 0B6h
out 43h, al
; play frequency 131H
SOUND_1:
    push    cx  
    mov     cx, 0CFFFH 
delDec2:
    dec     cx 
    jnz     delDec2
    pop     cx
    dec     cx
	mov ax, [NOTE]
 out 42h, al ; Sending lower byte
 mov al, ah
 out 42h, al ; Sending upper byt
 jnz    SOUND_1
; close the speaker
in al, 61h
and al, 11111100b
out 61h, al
ret
endp SOUND

proc DELAY 

delRep:
    push    cx  
    mov     cx, 0FFFFH 
delDec:
    dec     cx 
    jnz     delDec
    pop     cx
    dec     cx
    jnz     delRep
    ret
endp DELAY

start:
	mov ax, @data
	mov ds, ax
	xor bx,bx
	
mov ax,13h ; enter grapich mode 
int 10h
 
  CALL MAIN_GAME
exit:
	mov ax, 4c00h
	int 21h
END start