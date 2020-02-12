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
   
  //declaring transaction class
  rand transaction trans;
   
  //declaring mailbox
  mailbox gen2driv;
   
  //repeat count, to specify number of items to generate
  int  repeat_count; 
 
  //event, to indicate the end of transaction generation
  event ended;
 
  //constructor
  function new(mailbox gen2driv);
    //getting the mailbox handle from env
    this.gen2driv = gen2driv;
  endfunction
   
  //main task, generates(create and randomizes) the repeat_count number of transaction packets and puts into mailbox
  task main();
 
    repeat(repeat_count) begin
      trans = new();
      if( !trans.randomize() ) $fatal("Gen:: trans randomization failed");   
      gen2driv.put(trans);
    end
    -> ended; //triggering indicates the end of generation
  endtask 
endclass
