module branch_comp(input logic unsigned  [31:0] A,
                   input logic	unsigned [31:0] B,
                   input logic branch_unsign,
                   output logic BrEq, BrLt);

always @ (*) begin
	case(branch_unsign)
	1'b0: begin
		BrEq = (A==B)?1'b1:1'b0;
		BrLt = ($signed(A)<$signed(B))?1'b1:1'b0;
	end
	1'b1: begin
		BrEq = (A==B)?1'b1:1'b0;
		BrLt = ((A)<(B))?1'b1:1'b0;
	end
	default: begin
		BrEq = 0;
		BrLt = 0;
	end
	endcase
end
endmodule
