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

class monitor;

  //creating virtual interface handle
  virtual intf vif;

  //creating mailbox handle
  mailbox mon2scb;

  //constructor
  function new(virtual intf vif,mailbox mon2scb);
    //getting the interface
    this.vif = vif;
    //getting the mailbox handles from? environment
    this.mon2scb = mon2scb;
  endfunction

//Samples the interface signal and send the sample packet to scoreboard
task main;
  forever begin
    transaction trans;
    trans = new();
    @(posedge vif.clk);
    wait(vif.ALU_en);
    trans.A = vif.A;
    trans.B = vif.B;
    @(posedge vif.clk);
    trans.C = vif.C;
    @(posedge vif.clk);
    mon2scb.put(trans);
    trans.display("[ Monitor ]");
  end
endtask

endclass