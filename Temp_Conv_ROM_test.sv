`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2022 06:29:06 PM
// Design Name: 
// Module Name: Temp_Conv_ROM_test
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


module Temp_Conv_ROM_test(
    input logic clk, button,
    input logic [7:0] SW,
    output logic [6:0] SEG,
    output logic [7:0] AN
    );
    
    //button toggle
    logic formTog;
    t_ff TFF (
        .t(button),
        .clk(clk),
        .reset(1'b0),
        .q(formTog)
    );
    
    //Temp Conversion
    logic [7:0] Temp;
    Temp_Conv_ROM TempConverter (
        .clk(clk),
        .format(formTog),
        .X(SW),
        .Temp(Temp)
    );
    
    //ROM binary output to BCD 
    logic [11:0] OutTemp;
    bin2bcd BCD0 (
        .bin(Temp),
        .bcd(OutTemp)
    );
    
    //SW binary input to BCD
    logic [11:0] InTemp;
    bin2bcd BCD1 (
        .bin(SW),
        .bcd(InTemp)
    );
    
    
    //Display
    time_mux_disp Display (
        .in0({1'b1,InTemp[3:0],1'b1}),
        .in1({1'b1,InTemp[7:4],1'b1}),
        .in2({1'b1,InTemp[11:8],1'b1}),
        .in3(),
        .in4({1'b1,OutTemp[3:0] ,1'b1}),
        .in5({1'b1,OutTemp[7:4],1'b1}),
        .in6({1'b1,OutTemp[11:8],1'b1}),
        .in7(),
        .clk(clk),
        .dp(),
        .sseg(SEG),
        .an(AN)
    ); 
endmodule
