//Empty char array for receiving data.
char input[16] = "";

/*Define commands here.
Note: Watch for capitalization!
*/
char command1[14] = "command1"; //without spaces of capitalization.
char command2[14] = "Command2"; //with capitalization.
char command3[14] = "command 3"; //with spaces.
char command4[14] = "Command 4"; //with capitalization & spaces.
char commandhelp[5] = "help"; //Help command.

//Used for printout lib
void PrintHandler(char c) {

  UART1_Write(c);

}

void main() {

  //Remappablepins settings
  Unlock_IOLOCK();
  PPS_Mapping_NoLock(10, _INPUT, _U1RX); // Sets pin 25 to be Input, and maps RXUART to it
  PPS_Mapping_NoLock(17, _OUTPUT, _U1TX); // Sets pin 24 to be output, and maps TXUART to it.
  Lock_IOLOCK();

  //Load uart1
  UART1_Init(9600); // Initialize UART module at 9600 bps
  Delay_ms(100); // Wait for UART module to stabilize

  //Display message on start device.
  UART1_Write_Text("String Receive/Send V1.1");
  //always run, otherwise we will only execute once.
  while (1) {
    //if there is data do something.
    if (UART1_Data_Ready() > 0) {
      uart1_read_text(input, "\r\n", 16); // Read String data up to 10th charachter if \r if found stop looking and put data in input.

      //compare what we got in input to whatever we define as a commmand up at the variables.
      if (strcmp(input, command1) == 0) {
        uart1_write_text("Done 1"); //Command 1
      } else if (strcmp(input, command2) == 0) {
        uart1_write_text("Done 2"); //Command 2
      } else if (strcmp(input, command3) == 0) {
        uart1_write_text("Done 3"); //Command 3
      } else if (strcmp(input, command4) == 0) {
        uart1_write_text("Done 4"); //Command 4
      } else if (strcmp(input, commandhelp) == 0) {
        PrintOut(PrintHandler, "/**********************************************************\r\n"
          " * Project name:\r\n"
          "     String Receive/Send \r\n"
          " * Created by:\r\n"
          "     Tariq Dinmohamed.\r\n"
          " * Revision History:\r\n"
          "     20200531-16:00:\r\n"
          "       - Initial release\r\n"
          "     20200531-16:52:\r\n"
          "       - Removed // from help menu.\r\n"
          " * Description:\r\n"
          "     Simple demonstration on receiving strings an using them as commands\r\n"
          " * Test configuration:\r\n"
          "     MCU:             P24FJ128GA306\r\n"
          "     Oscillator:      HS, 32MHz\r\n"
          " * Commands:\r\n"
          "     command1 - without spaces of capitalization.\r\n"
          "     Command2 - with capitalization.\r\n"
          "     command 3 - with spaces.\r\n"
          "     Command 4 - with capitalization & spaces. \r\n"
          "     Help - What you're seeing\r\n"
          " **********************************************************/\r\n", Get_Fosc_kHz() / 1000.);
      } else {
        uart1_write_text("Unrecognized command: "); //Failed to recognize.
        uart_write_text(input); //output failed command.
      }
    }
  }
}