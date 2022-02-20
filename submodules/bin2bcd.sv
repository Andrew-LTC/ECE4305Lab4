`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2022 05:21:00 PM
// Design Name: 
// Module Name: bin2bcd
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


module bin2bcd(
    input logic [7:0] bin,
    output logic [11:0] bcd
    );
    
    //outputs of Add 3 module's
    logic [0:18] z;
    
    add_3 Add0 (
        .A({1'b0,bin[7:5]}),
        .S(z[0:3])
    );
    add_3 Add1 (
        .A({z[1:3],bin[4]}),
        .S(z[4:7])
    );
    add_3 Add2 (
        .A({z[5:7],bin[3]}),
        .S(z[8:11])
    );
    add_3 Add3 (
        .A({z[9:11],bin[2]}),
        .S(z[15:18])
    );
    add_3 Add4 (
        .A({z[16:18],bin[1]}),
        .S(bcd[4:1])
    );
    add_3 Add5 (
        .A({1'b0,z[0],z[4],z[8]}),
        .S({bcd[9],z[12:14]})
    );
    add_3 Add6 (
        .A(z[12:15]),
        .S(bcd[8:5])
    );
    
    //final outputs that dont require add3
    assign bcd[11] = 1'b0;
    assign bcd[10] = 1'b0;
    assign bcd[0] = bin[0];
endmodule
