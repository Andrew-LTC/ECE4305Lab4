`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2022 08:48:34 AM
// Design Name: 
// Module Name: Temp_Conv_ROM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Temp_Conv_ROM(
    input logic clk, format,
    input logic [7:0] X,
    output logic [7:0] Temp
    );
    
    //8 bit data size with 9 bit address size to store around 280 address spaces
    logic [8:0] ADDR;     
    synch_ROM_param #(.DATA(8),.ADDR(9),.bMemFile("ConvTable.mem")) ROM (
        .clk(clk),
        .addr(ADDR),
        .data(Temp)
    );
    
    //format = 1: F -> C
    //format = 0: C -> F
    //if format is 1 check if wihtin F range then assign to X and concatenate a 0 in front to meet bit requirement 
    //then add 68 to skip C to F values since min F value will be 32 and we need to go past 100, 100 - 32 = 68
    //if format is 0 check if within C range and assing address X value with 0 concatenated infront to meet bit requirement
    // 282 is the address containing 0
    assign ADDR = format ? ((X >= 32 && X <= 212) ? ({1'b0,X} + 68) : (282)) : ((X <= 100) ? ({1'b0,X}) : (282));
endmodule
