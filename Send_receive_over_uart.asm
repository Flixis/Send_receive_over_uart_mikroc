
_PrintHandler:

;Send_receive_over_uart.c,14 :: 		void PrintHandler(char c) {
;Send_receive_over_uart.c,16 :: 		UART1_Write(c);
	ZE	W10, W10
	CALL	_UART1_Write
;Send_receive_over_uart.c,18 :: 		}
L_end_PrintHandler:
	RETURN
; end of _PrintHandler

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 50
	MOV	#4, W0
	IOR	68

;Send_receive_over_uart.c,20 :: 		void main() {
;Send_receive_over_uart.c,23 :: 		Unlock_IOLOCK();
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CALL	_Unlock_IOLOCK
;Send_receive_over_uart.c,24 :: 		PPS_Mapping_NoLock(10, _INPUT, _U1RX); // Sets pin 25 to be Input, and maps RXUART to it
	MOV.B	#28, W12
	MOV.B	#1, W11
	MOV.B	#10, W10
	CALL	_PPS_Mapping_NoLock
;Send_receive_over_uart.c,25 :: 		PPS_Mapping_NoLock(17, _OUTPUT, _U1TX); // Sets pin 24 to be output, and maps TXUART to it.
	MOV.B	#3, W12
	CLR	W11
	MOV.B	#17, W10
	CALL	_PPS_Mapping_NoLock
;Send_receive_over_uart.c,26 :: 		Lock_IOLOCK();
	CALL	_Lock_IOLOCK
;Send_receive_over_uart.c,29 :: 		UART1_Init(9600); // Initialize UART module at 9600 bps
	MOV	#9600, W10
	MOV	#0, W11
	CALL	_UART1_Init
;Send_receive_over_uart.c,30 :: 		Delay_ms(100); // Wait for UART module to stabilize
	MOV	#9, W8
	MOV	#9047, W7
L_main0:
	DEC	W7
	BRA NZ	L_main0
	DEC	W8
	BRA NZ	L_main0
;Send_receive_over_uart.c,33 :: 		UART1_Write_Text("String Receive/Send V1.1");
	MOV	#lo_addr(?lstr1_Send_receive_over_uart), W10
	CALL	_UART1_Write_Text
;Send_receive_over_uart.c,35 :: 		while (1) {
L_main2:
;Send_receive_over_uart.c,37 :: 		if (UART1_Data_Ready() > 0) {
	CALL	_UART1_Data_Ready
	CP	W0, #0
	BRA GTU	L__main17
	GOTO	L_main4
L__main17:
;Send_receive_over_uart.c,38 :: 		uart1_read_text(input, "\r\n", 16); // Read String data up to 10th charachter if \r if found stop looking and put data in input.
	MOV.B	#16, W12
	MOV	#lo_addr(?lstr2_Send_receive_over_uart), W11
	MOV	#lo_addr(_input), W10
	CALL	_UART1_Read_Text
;Send_receive_over_uart.c,41 :: 		if (strcmp(input, command1) == 0) {
	MOV	#lo_addr(_command1), W11
	MOV	#lo_addr(_input), W10
	CALL	_strcmp
	CP	W0, #0
	BRA Z	L__main18
	GOTO	L_main5
L__main18:
;Send_receive_over_uart.c,42 :: 		uart1_write_text("Done 1"); //Command 1
	MOV	#lo_addr(?lstr3_Send_receive_over_uart), W10
	CALL	_UART1_Write_Text
;Send_receive_over_uart.c,43 :: 		} else if (strcmp(input, command2) == 0) {
	GOTO	L_main6
L_main5:
	MOV	#lo_addr(_command2), W11
	MOV	#lo_addr(_input), W10
	CALL	_strcmp
	CP	W0, #0
	BRA Z	L__main19
	GOTO	L_main7
L__main19:
;Send_receive_over_uart.c,44 :: 		uart1_write_text("Done 2"); //Command 2
	MOV	#lo_addr(?lstr4_Send_receive_over_uart), W10
	CALL	_UART1_Write_Text
;Send_receive_over_uart.c,45 :: 		} else if (strcmp(input, command3) == 0) {
	GOTO	L_main8
L_main7:
	MOV	#lo_addr(_command3), W11
	MOV	#lo_addr(_input), W10
	CALL	_strcmp
	CP	W0, #0
	BRA Z	L__main20
	GOTO	L_main9
L__main20:
;Send_receive_over_uart.c,46 :: 		uart1_write_text("Done 3"); //Command 3
	MOV	#lo_addr(?lstr5_Send_receive_over_uart), W10
	CALL	_UART1_Write_Text
;Send_receive_over_uart.c,47 :: 		} else if (strcmp(input, command4) == 0) {
	GOTO	L_main10
L_main9:
	MOV	#lo_addr(_command4), W11
	MOV	#lo_addr(_input), W10
	CALL	_strcmp
	CP	W0, #0
	BRA Z	L__main21
	GOTO	L_main11
L__main21:
;Send_receive_over_uart.c,48 :: 		uart1_write_text("Done 4"); //Command 4
	MOV	#lo_addr(?lstr6_Send_receive_over_uart), W10
	CALL	_UART1_Write_Text
;Send_receive_over_uart.c,49 :: 		} else if (strcmp(input, commandhelp) == 0) {
	GOTO	L_main12
L_main11:
	MOV	#lo_addr(_commandhelp), W11
	MOV	#lo_addr(_input), W10
	CALL	_strcmp
	CP	W0, #0
	BRA Z	L__main22
	GOTO	L_main13
L__main22:
;Send_receive_over_uart.c,71 :: 		" **********************************************************/\r\n", Get_Fosc_kHz() / 1000.);
	CALL	_Get_Fosc_kHz
	CALL	__Long2Float
	MOV	#0, W2
	MOV	#17530, W3
	CALL	__Div_FP
	PUSH.D	W0
	MOV	#lo_addr(?lstr_7_Send_receive_over_uart), W0
	PUSH	W0
;Send_receive_over_uart.c,50 :: 		PrintOut(PrintHandler, "/**********************************************************\r\n"
	MOV	#lo_addr(_PrintHandler), W0
	PUSH	W0
;Send_receive_over_uart.c,71 :: 		" **********************************************************/\r\n", Get_Fosc_kHz() / 1000.);
	CALL	_PrintOut
	SUB	#8, W15
;Send_receive_over_uart.c,72 :: 		} else {
	GOTO	L_main14
L_main13:
;Send_receive_over_uart.c,73 :: 		uart1_write_text("Unrecognized command: "); //Failed to recognize.
	MOV	#lo_addr(?lstr8_Send_receive_over_uart), W10
	CALL	_UART1_Write_Text
;Send_receive_over_uart.c,74 :: 		uart_write_text(input); //output failed command.
	MOV	#lo_addr(_input), W10
	CALL	_UART_Write_Text
;Send_receive_over_uart.c,75 :: 		}
L_main14:
L_main12:
L_main10:
L_main8:
L_main6:
;Send_receive_over_uart.c,76 :: 		}
L_main4:
;Send_receive_over_uart.c,77 :: 		}
	GOTO	L_main2
;Send_receive_over_uart.c,78 :: 		}
L_end_main:
	POP	W12
	POP	W11
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
