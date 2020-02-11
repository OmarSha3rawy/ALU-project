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

`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"

class environment;
   
  //generator and driver instance
  generator gen;
  driver    driv;
   
  //mailbox handle's
  mailbox gen2driv;
   
  //virtual interface
  virtual intf vif;
   
  //constructor
  function new(virtual intf vif);
    //get the interface from test
    this.vif = vif;
     
    //creating the mailbox (Same handle will be shared across generator and driver)
    gen2driv = new();
     
    //creating generator and driver
    gen  = new(gen2driv);
    driv = new(vif,gen2driv);
  endfunction
   
  //
  task pre_test();
    driv.reset();
  endtask
   
  task test();
    fork
    gen.main();
    driv.main();
    join_any
  endtask
   
  task post_test();
    wait(gen.ended.triggered);
    wait(gen.repeat_count == driv.no_transactions);
  endtask 
   
  //run task
  task run;
    pre_test();
    test();
    post_test();
    $finish;
  endtask
   
endclass