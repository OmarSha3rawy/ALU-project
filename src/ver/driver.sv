/* 
// Module: driver.sv 
// Project: simple ALU project
// Description: drive the transaction to the DUT via interface
// Owner : Omar Adel Abbas Sayed
// Version : 1.0 
// Date : 9 February 2020
// History : 
// // --------------------------- 
*/
//`include "transaction.sv"
class driver;
 
  int no_transactions; //used to count the number of transactions
  virtual intf vif; //creating virtual interface handle
  mailbox gen2driv; //creating mailbox handle
   
  //constructor
  function new(virtual intf vif,mailbox gen2driv);
    //getting the interface
    this.vif = vif;
    //getting the mailbox handles from  environment
    this.gen2driv = gen2driv;
  endfunction
   
  //Reset task, Reset the Interface signals to default/initial values
  task reset;
    wait(vif.rst_n);
    $display("[ DRIVER ] ----- Reset Started -----");
    vif.A <= 0;
    vif.B <= 0;
    vif.a_en <= 0;
    vif.b_en <= 0;
    vif.a_op <= 0;
    vif.b_op <= 0;
    vif.ALU_en <= 0;
    wait(!vif.rst_n);
    $display("[ DRIVER ] ----- Reset Ended   -----");
  endtask
   
  //drivers the transaction items to interface signals
  task main;
    forever begin
      transaction trans;
      gen2driv.get(trans);
      @(posedge vif.clk);
      vif.ALU_en <= 1; //to be removed later
      vif.A     <= trans.A;
      vif.B     <= trans.B;
      vif.a_op  <= trans.a_op;
      vif.b_op  <= trans.b_op;
      vif.a_en  <= trans.a_en;
      vif.b_en  <= trans.b_en;
      @(posedge vif.clk);
      //vif.ALU_en <= 0;
      trans.C   = vif.C;
      @(posedge vif.clk);
      trans.display("[ Driver ]");
      no_transactions++;
    end
  endtask
  

           
endclass
