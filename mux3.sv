module mux3(input logic [31:0] in1,
            input logic [31:0] in2,
            input logic [31:0] in3,
            input logic [1:0] sel,
            output logic [31:0] y);

assign y = (sel == 2'b00)? in1 : (sel == 2'b01)? in2 : (sel == 2'b10)? in3 : 0;

endmodule
