/* 
// Module: generator.sv 
// Project: simple ALU project
// Description: generate random transactions
// Owner : Omar Adel Abbas Sayed
// Version : 1.0 
// Date : 9 February 2020
// History : 
// // --------------------------- 
*/
//`include "transaction.sv"

class generator;
   
  rand transaction trans; //declaring transaction class
  mailbox gen2driv; //declaring mailbox
  int  repeat_count; //repeat count, to specify number of items to generate
  event ended; //event, to indicate the end of transaction generation
 
  //constructor
  function new(mailbox gen2driv);
    this.gen2driv = gen2driv; //getting the mailbox handle from env
  endfunction
   
  task main();
    repeat(repeat_count) begin
      trans = new();
      if( !trans.randomize() ) $fatal("Gen:: trans randomization failed");   
      gen2driv.put(trans);
    end
    -> ended; //triggering indicates the end of generation
  endtask 
endclass
