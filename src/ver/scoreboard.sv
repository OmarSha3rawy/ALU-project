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
class scoreboard;
    
  //creating mailbox handle
  mailbox mon2scb;
   
  //used to count the number of transactions
  int no_transactions;
   
  //constructor
  function new(mailbox mon2scb);
    //getting the mailbox handles from  environment
    this.mon2scb = mon2scb;
  endfunction
   
  //Compares the Actual result with the expected result
  task main;
    transaction trans;
	forever begin
      mon2scb.get(trans);
	if(trans.a_en == 1 && trans.b_en == 0)
	begin
	    case(trans.a_op)
            3'b000: // Addition
	    begin
              if((trans.A + trans.B) == trans.C)
                $display("Result is as Expected");
              else
                $error("Wrong Result.\n\tExpeced: %0d Actual: %0d",(trans.A+trans.B),trans.C);
            end
            3'b001: // Subtraction
	    begin
              if((trans.A - trans.B) == trans.C)
                $display("Result is as Expected");
              else
                $error("Wrong Result.\n\tExpeced: %0d Actual: %0d",(trans.A - trans.B),trans.C);
            end
            3'b010: // Logical xor
	    begin
              if((trans.A ^ trans.B) == trans.C)
                $display("Result is as Expected");
              else
                $error("Wrong Result.\n\tExpeced: %0d Actual: %0d",(trans.A ^ trans.B),trans.C);
            end
            3'b011, 3'b100: // Logical and 
	    begin
              if((trans.A & trans.B) == trans.C)
                $display("Result is as Expected");
              else
                $error("Wrong Result.\n\tExpeced: %0d Actual: %0d",(trans.A & trans.B),trans.C);
            end
            3'b101: //  Logical or
	    begin
              if((trans.A | trans.B) == trans.C)
                $display("Result is as Expected");
              else
                $error("Wrong Result.\n\tExpeced: %0d Actual: %0d",(trans.A | trans.B),trans.C);
            end
            3'b110: // Logical xnor
	    begin
              if(~(trans.A ^ trans.B) == trans.C)
                $display("Result is as Expected");
              else
                $error("Wrong Result.\n\tExpeced: %0d Actual: %0d",~(trans.A ^ trans.B),trans.C);
            end
            default: 
	    begin
              if(trans.A == trans.C)
                $display("Result is as Expected");
              else
                $error("Wrong Result.\n\tExpeced: %0d Actual: %0d", trans.A,trans.C);
            end
            endcase
	end

	else if (trans.a_en == 0 && trans.b_en == 1)
	begin
	    case(trans.b_op)
            2'b00: // Logical nand 
	    begin
              if(~(trans.A & trans.B) == trans.C)
                $display("Result is as Expected");
              else
                $error("Wrong Result.\n\tExpeced: %0d Actual: %0d",~(trans.A & trans.B),trans.C);
            end
            2'b01, 2'b10: // Addition 
	    begin
              if((trans.A + trans.B) == trans.C)
                $display("Result is as Expected");
              else
                $error("Wrong Result.\n\tExpeced: %0d Actual: %0d",(trans.A + trans.B),trans.C);
            end
            default: 
	    begin
              if(trans.A == trans.C)
                $display("Result is as Expected");
              else
                $error("Wrong Result.\n\tExpeced: %0d Actual: %0d", trans.A, trans.C);
            end
            endcase
	end

	else if (trans.a_en == 1 && trans.b_en == 1)
	begin
	    case(trans.b_op)
            2'b00: // Logical xor
	    begin
              if(~(trans.A ^ trans.B) == trans.C)
                $display("Result is as Expected");
              else
                $error("Wrong Result.\n\tExpeced: %0d Actual: %0d",~(trans.A ^ trans.B),trans.C);
            end
            2'b01:  // Logical xnor
	    begin
              if(~(trans.A ^ trans.B) == trans.C)
                $display("Result is as Expected");
              else
                $error("Wrong Result.\n\tExpeced: %0d Actual: %0d",~(trans.A ^ trans.B),trans.C);
            end
            2'b10:  
	    begin
              if((trans.A - 1) == trans.C)
                $display("Result is as Expected");
              else
                $error("Wrong Result.\n\tExpeced: %0d Actual: %0d",(trans.A - 1),trans.C);
            end
            2'b11:  
	    begin
              if((trans.B + 2) == trans.C)
                $display("Result is as Expected");
              else
                $error("Wrong Result.\n\tExpeced: %0d Actual: %0d",(trans.B + 2),trans.C);
            end
            default:
	    begin
              if(trans.A == trans.C)
                $display("Result is as Expected");
              else
                $error("Wrong Result.\n\tExpeced: %0d Actual: %0d", trans.A, trans.C);
            end
            endcase
	end

	else
	begin
          if(trans.A == trans.C)
            $display("Result is as Expected");
          else
            $error("Wrong Result.\n\tExpeced: %0d Actual: %0d", trans.A, trans.C); 
	end
        no_transactions++;
      trans.display("[ Scoreboard ]");
    end
  endtask
   
endclass
