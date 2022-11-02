module mux(in1, in2, sel, y );

    input         sel;
    input  [31:0] in1, in2;
    output [31:0] y;

    assign y = sel ? in2:in1;
    
endmodule
