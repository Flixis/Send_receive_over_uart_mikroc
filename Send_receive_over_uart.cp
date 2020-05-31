#line 1 "F:/Programming/MikroC Projects/Send_receive_over_uart/Send_receive_over_uart.c"

char input[16] = "";
#line 7 "F:/Programming/MikroC Projects/Send_receive_over_uart/Send_receive_over_uart.c"
char command1[14] = "command1";
char command2[14] = "Command2";
char command3[14] = "command 3";
char command4[14] = "Command 4";
char commandhelp[5] = "help";


void PrintHandler(char c){

 UART1_Write(c);

}


void main() {


 Unlock_IOLOCK();
 PPS_Mapping_NoLock(10, _INPUT, _U1RX);
 PPS_Mapping_NoLock(17, _OUTPUT, _U1TX);
 Lock_IOLOCK();


 UART1_Init(9600);
 Delay_ms(100);




 UART1_Write_Text("String Receive/Send V1.0");

 while(1){

 if(UART1_Data_Ready() > 0){
 uart1_read_text(input,"\r\n",16);


 if(strcmp(input,command1) == 0){
 uart1_write_text("Done 1");
 }else if(strcmp(input,command2) == 0){
 uart1_write_text("Done 2");
 }else if(strcmp(input,command3) == 0){
 uart1_write_text("Done 3");
 }else if(strcmp(input,command4) == 0){
 uart1_write_text("Done 4");
 }else if(strcmp(input,commandhelp) == 0){
 PrintOut(PrintHandler, "/**********************************************************\r\n"
 " * Project name:\r\n"
 "     String Receive/Send \r\n"
 " * Created by:\r\n"
 "     Tariq Dinmohamed.\r\n"
 " * Revision History:\r\n"
 "     20200531:\r\n"
 "       - Initial release\r\n"
 " * Description:\r\n"
 "     Simple demonstration on receiving strings an using them as commands\r\n"
 " * Test configuration:\r\n"
 "     MCU:             P24FJ128GA306\r\n"
 "     Oscillator:      HS, 32MHz\r\n"
 " * Commands:\r\n"
 "     command1 - //without spaces of capitalization.\r\n"
 "     Command2 - //with capitalization.\r\n"
 "     command 3 - with spaces.\r\n"
 "     Command 4 - with capitalization & spaces. \r\n"
 "     Help - What you're seeing\r\n"
 " **********************************************************/\r\n", Get_Fosc_kHz()/1000.);
 }else{
 uart1_write_text("Unrecognized command: ");
 uart_write_text(input);
 }
 }
 }
}
