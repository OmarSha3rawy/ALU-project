/* 
// Module: transaction.sv 
// Project: simple ALU project
// Description: class represent sample of inputs
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
  constraint operations_c { a_en != b_en; }; // to be removed to test case of a_en = b_en = 1
  constraint enable_c { ALU_en == 1; }; // to be removed in the negative testing
  
  covergroup cg;
    c1: coverpoint A { bins boundary[] = {-15,15};
                        bins pos_partition = {[0:15]};
                        bins neg_partition = {[-15:-1]};}
						
    c2: coverpoint B { bins boundary[] = {-15,15};
                        bins pos_partition = {[0:15]};
                        bins neg_partition = {[-15:-1]};}

    c3: coverpoint a_op { illegal_bins forbidden = {7}; // to be changed in negative testing
                        bins b2[] = {[0:$]};}
						
    c4: coverpoint b_op { illegal_bins forbidden = {3}; // to be changed in SET2 and negative testing
                        bins b2[] = {[0:$]};}

    c5: coverpoint a_en { bins rising = (1=>0);   
                        bins falling = (0=>1);}		

    c6: coverpoint b_en { bins rising = (1=>0);   
                        bins falling = (0=>1);}	
	c7: cross A, B, a_op;
	c8: cross A, B, b_op;
						
  endgroup : cg

  function new ();
    cg = new;           // Create an instance of the covergroup
  endfunction
  
  function void display(string name);
    $display("-------------------------");
    $display("- %s ",name);
    $display("-------------------------");
    $display("- a = %0d, b = %0d",A,B);
    $display("- c = %0d",C);
    $display("-------------------------");
  endfunction
endclass

