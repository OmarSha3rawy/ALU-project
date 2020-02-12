/* 
// Module: monitor.sv 
// Project: simple ALU project
// Description: Send the sampled transaction to Scoreboard via Mailbox.
// Owner : Omar Adel Abbas Sayed
// Version : 2.0 
// Date : 9 February 2020
// History : 
// // --------------------------- 
*/
//`include "transaction.sv"

class monitor;

  virtual intf vif; //creating virtual interface handle
  mailbox mon2scb; //creating mailbox handle
  mailbox mon2cov;
  //constructor
  function new(virtual intf vif,mailbox mon2scb, mailbox mon2cov);
    this.vif = vif; //getting the interface
    this.mon2scb = mon2scb; //getting the mailbox handles from environment
	this.mon2cov = mon2cov; 
  endfunction


task main; //Samples the interface signal and send the sample packet to scoreboard
  forever begin
    transaction trans;
    trans = new();
    @(posedge vif.clk);
    wait(vif.ALU_en);
    trans.A = vif.A;
    trans.B = vif.B;
	trans.a_op  = vif.a_op;
    trans.b_op  = vif.b_op;
    trans.a_en = vif.a_en;
    trans.b_en = vif.b_en;
    @(posedge vif.clk);
    trans.C = vif.C;
    @(posedge vif.clk);
    mon2scb.put(trans);
	mon2cov.put(trans);
    trans.display("[ Monitor ]");
  end
endtask

endclass