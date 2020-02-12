/* 
// Module: environment.sv 
// Project: simple ALU project
// Description: class that contains a generator and driver
// Owner : Omar Adel Abbas Sayed
// Version : 2.0 
// Date : 9 February 2020
// History : 
// // --------------------------- 
*/

`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "coverage_group.sv"

class environment;
   
  //create instances
  generator gen;
  driver driv;
  monitor mon;
  scoreboard scb;
  cov cgp;
  
  //mailbox handle's
  mailbox gen2driv;
  mailbox mon2scb;  
  mailbox mon2cov; 
  
  event ended;
  
  //virtual interface
  virtual intf vif;
   
  //constructor
  function new(virtual intf vif);
    //get the interface from test
    this.vif = vif;
     
    //creating the mailboxes
    gen2driv = new();
    mon2scb = new();
	
    //creating generator and driver
    gen  = new(gen2driv, ended);
    driv = new(vif,gen2driv, ended);
    mon  = new(vif,mon2scb, mon2cov);
    scb  = new(mon2scb);
    cgp  = new(vif, mon2cov);	
  endfunction
   
  //
  task pre_test();
    driv.reset();
  endtask
   
  task test();
    fork
    gen.main();
    driv.main();
	mon.main();
    scb.main();
	//cov.main
    join_any
  endtask
   
  task post_test();
    wait(gen.ended.triggered);
    wait(gen.repeat_count == driv.no_transactions);
    wait(gen.repeat_count == scb.no_transactions);
  endtask 
   
  //run task
  task run;
    pre_test();
    test();
    post_test();
    $finish;
  endtask
   
endclass