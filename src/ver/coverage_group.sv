/* 
// Module: ALU.v 
// Project: simple ALU project
// Description: Simple behavioural model for Arithmatic logic unit (ALU)
// Owner : Omar Adel Abbas Sayed
// Version : 2.0 
// Date : 1 February 2020
// History : 
// // --------------------------- 
*/

class cov;
    parameter INPUT_WIDTH = 5;
    parameter OUTPUT_WIDTH = 6;

    //logic clk;
	
    logic [INPUT_WIDTH-1:0] A;
    logic [INPUT_WIDTH-1:0] B;
    logic a_en;
    logic b_en;
    logic [2:0]  a_op;
    logic [1:0]  b_op;
    logic ALU_en;
    logic [OUTPUT_WIDTH-1:0] C;
	
	virtual intf vif;
    mailbox mon2cov; //creating mailbox handle
	transaction trans;

  covergroup cg;
    c1: coverpoint A { bins boundary[] = {-15,15};
                        bins pos_partition = {[0:15]};
                        bins neg_partition = {[-15:-1]};
                        bins b7 = default;}
						
    c2: coverpoint B { bins boundary[] = {-15,15};
                        bins pos_partition = {[0:15]};
                        bins neg_partition = {[-15:-1]};
                        bins b7 = default;}

    c3: coverpoint a_op { illegal_bins forbidden = {7}; // to be changed in negative testing
                        bins b2[] = {[0:$]};
                        bins b7 = default;}
						
    c4: coverpoint b_op { illegal_bins forbidden = {3}; // to be changed in SET2 and negative testing
                        bins b2[] = {[0:$]};
                        bins b7 = default;}

    c5: coverpoint a_en { bins rising = (1=>0);   
                        bins falling = (0=>1);
                        bins b7 = default;}		

    c6: coverpoint b_en { bins rising = (1=>0);   
                        bins falling = (0=>1);
                        bins b7 = default;}	
	c7: cross A, B, a_op;
	c8: cross A, B, b_op;
						
  endgroup : cg

  function new (virtual intf vif,mailbox mon2cov);
    cg = new; // Create an instance of the covergroup
	this.vif = vif;
	this.mon2cov = mon2cov;
  endfunction
  
  task main;
    mon2cov.get(trans);
    @(posedge vif.clk);
	  A <= trans.A;
	  B <= trans.A;
      a_op  <= trans.a_op;
      b_op  <= trans.b_op;
      a_en  <= trans.a_en;
      b_en  <= trans.b_en;
	  cg.sample();
  endtask;

endclass