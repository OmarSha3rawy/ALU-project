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

interface intf(input logic clk, rst_n);
    parameter INPUT_WIDTH = 5;
    parameter OUTPUT_WIDTH = 6;

    logic [INPUT_WIDTH-1:0] A;
    logic [INPUT_WIDTH-1:0] B;
    logic a_en;
    logic b_en;
    logic [2:0]  a_op;
    logic [1:0]  b_op;
    logic ALU_en;
    logic [OUTPUT_WIDTH-1:0] C;
endinterface


