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

module ALU
    #(parameter INPUT_WIDTH = 5, OUTPUT_WIDTH = 6)
    ( 
     	input wire signed [INPUT_WIDTH-1:0] A,// ALU first operand
     	input wire signed [INPUT_WIDTH-1:0] B,// ALU second operand

        input wire a_en, //enable signal for a_op operations
        input wire b_en, //enable signal for b_op operations

        input wire [2:0]  a_op, //defining a set of 8 operations to performed 
        input wire [1:0]  b_op, //defining a set of 4 operations to performed 

        input wire rst_n, //Asynchronous active-low reset signal
        input wire clk, //system input clock signal
        input wire ALU_en, //overall system enable

        output reg signed [OUTPUT_WIDTH-1:0] C// ALU output
    );

    reg signed [OUTPUT_WIDTH-1:0] ALU_Result; // to hold the calculations results
    reg signed [OUTPUT_WIDTH-1:0] temp; // to handle the reset signal effect

    always @(posedge clk, negedge rst_n)
    begin
	if(rst_n == 0)
	begin
	    temp = 'h0;
	end
	else
	begin
	    temp = ALU_Result;
	end
    end

    always @(posedge clk)
    begin
	if(ALU_en == 1)
	begin
	    C = temp;
	end
	else
	begin
	    C = 'h0;
	end
    end

    always @(posedge clk, negedge rst_n)
    begin
	if(a_en == 1 && b_en == 0)
	begin
	    case(a_op)
            3'b000: // Addition
                ALU_Result = A + B ; 
            3'b001: // Subtraction
                ALU_Result = A - B ;
            3'b010: // Logical xor
                ALU_Result = A ^ B;
            3'b011, 3'b100: // Logical and 
                ALU_Result = A & B;
            3'b101: //  Logical or
                ALU_Result = A | B;
            3'b110: // Logical xnor
                ALU_Result = ~(A ^ B);
            default: 
		ALU_Result = A; 
            endcase
	end

	else if (a_en == 0 && b_en == 1)
	begin
	    case(b_op)
            2'b00: // Addition
                ALU_Result = ~(A & B);
            2'b01, 2'b10: // Logical nand 
                ALU_Result = A + B ;
            default: 
		ALU_Result = A; // not permitted
            endcase
	end

	else if (a_en == 1 && b_en == 1)
	begin
	    case(b_op)
            2'b00: // Logical xor
                ALU_Result = A ^ B;
            2'b01:  // Logical xnor
                ALU_Result = ~(A ^ B);
            2'b10:  // Addition
                ALU_Result = A - 1 ; 
            2'b11:  // Subtraction
                ALU_Result = B + 2 ; 
            default: 
		ALU_Result = A; // not permitted
            endcase
	end

	else
	begin
	    ALU_Result = A; 
	end

    end

endmodule