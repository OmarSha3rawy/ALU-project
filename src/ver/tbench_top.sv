/* 
// Module: ALU.v 
// Project: simple ALU project
// Description: Simple behavioural model for Arithmatic logic unit (ALU)
// Owner : Omar Adel Abbas Sayed
// Version : 1.0 
// Date : 1 February 2020
// History : 
// // --------------------------- 
*/

`include "interface.sv"
`include "random_test.sv"
 
module tbench_top;
  parameter CLK_HALF_PERIOD = 5;
   
  //clock and reset signal declaration
  bit clk;
  bit rst_n;
   
  //clock generation
  always #CLK_HALF_PERIOD clk = ~clk;
   
  //reset Generation
  initial begin
    rst_n = 0;
    #CLK_HALF_PERIOD rst_n = 1;
  end
   
   
  //creatinng instance of interface, inorder to connect DUT and testcase
  intf i_intf(clk,rst_n);
   
  //Testcase instance, interface handle is passed to test as an argument
  test t1(i_intf);
  
  //DUT instance, interface signals are connected to the DUT ports
  ALU DUT (
    .clk(i_intf.clk),
    .rst_n(i_intf.rst_n),
    .A(i_intf.A),
    .B(i_intf.B),
    .a_en(i_intf.a_en),
    .b_en(i_intf.b_en),
    .a_op(i_intf.a_op),
    .b_op(i_intf.b_op),
    .ALU_en(i_intf.ALU_en),
    .C(i_intf.c)
   );
   
  //enabling the wave dump
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
  end
endmodule

