`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2022 11:00:47 AM
// Design Name: 
// Module Name: synch_ROM_param
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


module synch_ROM_param
    #(parameter DATA = 2, ADDR = 2, bMemFile = " ")(
    input logic clk,
    input logic [ADDR - 1: 0] addr,
    output logic [DATA - 1: 0] data
    );
    
    //signal declaration
    (*rom_style = "block" *)logic [DATA - 1 : 0] rom [0:2 ** ADDR - 1];
    
    initial
        $readmemb(bMemFile ,rom);
        
    always_ff @(posedge clk)
        data <= rom[addr];    
endmodule
