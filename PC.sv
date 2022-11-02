module pcPlus4(input logic [31:0] current_pc,
               input logic which_pc,
               output logic [31:0] next_pc);

always @(*) begin
if (which_pc == 0) begin
next_pc = current_pc + 32'h4;
end
else if (which_pc == 1) begin
next_pc = current_pc + 32'h2;
end
else
next_pc =0;
end
endmodule


