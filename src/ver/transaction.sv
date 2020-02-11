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

class transaction;
  parameter INPUT_WIDTH = 5;
  parameter OUTPUT_WIDTH = 6;
  //declaring the transaction items
  rand bit [INPUT_WIDTH-1:0] A;
  rand bit [INPUT_WIDTH-1:0] B;
  bit [OUTPUT_WIDTH-1:0] C;
  randc bit [2:0]  a_op; 
  randc bit [1:0]  b_op;
  randc bit ALU_en;
  randc bit a_en;
  randc bit b_en;

  //constaints to apply speicidic scenarios
  constraint operations_c { a_en != b_en; };
  constraint enable_c { ALU_en == 1; };

  function void display(string name);
    $display("-------------------------");
    $display("- %s ",name);
    $display("-------------------------");
    $display("- a = %0d, b = %0d",A,B);
    $display("- c = %0d",C);
    $display("-------------------------");
  endfunction
endclass