module flipflop(clk, reset, d, q );

    input  clk, reset;
    input  [31:0] d;
    output logic [31:0] q;
    
    always@(posedge clk or posedge reset) begin
        if(reset)
            q <= 32'b0;
        else
            q <= d;
    end  
endmodule
