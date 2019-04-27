; Created: 23.12.2018 22:44:05
; Author : pc
;


; Replace with your application code
;-------------------------------------------------START AND GENERAL SETTINGS-----------------------------------------
.org 0
	ldi r27,0XFF
	ldi r23,0XF1
	ldi r20,0X10
	ldi r19,0X01
	ldi r18,0X10
	cbi DDRD,0
	sbi PORTD,0      
	cbi DDRD,1       
	sbi PORTD,1
	ldi r17,0X10         
	ldi r16,0XFF	
	out DDRC,r16     
	ldi r16,0X11
;-------------------------------------------------------MAIN METHOD----------------------------------------------------	
l1:
	sbis PIND,0      
	call buttonS	 
	sbis PIND,1      
	call buttonP	 
	out PORTC,r16	 
	call delay		 
	out PORTC,r17    
	call delay1 	 
	rjmp l1			 
;--------------------------------------------------------BUTTONS-----------------------------------------------------
buttonS:
	lsl r18		     
	brcs d1
d2:
	or r16,r18
	or r17,r18
	out PORTC,r16	
	call delay		
	out PORTC,r17   
	call delay1
	call wait        
lS:
	out PORTC,r16	
	call delay		
	out PORTC,r17   
	call delay1
	sbis PIND,0
	rjmp lS
	call wait
	ret    
d1:
	ldi r22,0XE0
	sub r16,r22
	ldi r17,0X10
	ldi r18,0X10
	call wait
	rjmp lS
;--------------------------------------------------------BUTTONP-----------------------------------------------------
buttonP:
	call wait
	lsl r19   
	cp r20,r19
	brne loop
	and r16,r23
	ldi r19,0X01
	rjmp LP
loop:
	or r16,r19
	call wait
LP:
	out PORTC,r16	
	call delay		
	out PORTC,r17   
	call delay1
	sbis PIND,1
	rjmp LP
	out PORTC,r16	
	call delay		
	out PORTC,r17   
	call delay1
	call wait
	ret    
;------------------------------------------------------delay methods--------------------------------------------	
delay:
    lds r28,0X5F    
    push r28        
	mov r21,r16		
w1:
	
	dec r21		    
	brne w1         
	pop r28         
	sts 0X5F,r28    
	ret				

delay1:
    lds r28,0X5F	
    push r28        
	mov r21,r16		
	sub r27,r21     
w2:
	dec r27         
	brne w2         
	pop r28         
	sts 0X5F,r28    
	ret				
;-------------------------------------------------WAIT METHOD---------------------------------------------------------
wait:
   mov r24,r16
   mov r25,r17          
   mov r26,r18
   ldi r24,0x02 	
   ldi r25,0x00 	    
   ldi r26,0x00 	     
   
_w0:
   dec r26
   brne _w0 			
   dec r25
   out portc,r16
   call delay
   out portc,r17        
   brne _w0             
   dec r24
   out portc,r16
   call delay  
   out portc,r17
   brne _w0		
   ret