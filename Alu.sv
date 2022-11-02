module alu( input  [31:0] A, 
	    input  [31:0] B, 
	    input  [3:0] alu_sel, 
            output [31:0] ALU_Out, 
            output reg Carry_Out, 
            output Zero, 
	    output reg Overflow = 1'b0);
			   
	reg   [31:0] ALU_Result; 
	reg   [32:0] temp; 
	reg   [32:0] twos_com;
	logic [6:0] temp1;
 
	assign ALU_Out = ALU_Result;
	assign Zero    = ( ALU_Result == 0 );
	

always @(*) begin 
		Overflow  = 1'b0;
		Carry_Out = 1'b0;
		
		case(alu_sel)

			4'b0000: begin  //add
				ALU_Result = A + B;
			end 
			
			4'b0001: begin // subtract


				ALU_Result = A - B;
			end
                     
			4'b0010: begin //or 
				ALU_Result = A | B;
			end

	                4'b0011: begin //and
				ALU_Result = A & B;
                        end

		        4'b0100: begin //xor
				ALU_Result = A ^ B;
                        end

		        4'b0101: begin //sll
				ALU_Result = A << B;
	                end

		        4'b0110: begin //srl
				ALU_Result = A >> B;
	                end

		        4'b0111: begin //sra
				 ALU_Result = $signed(A) >>> $signed(B[4:0]);
                                // ALU_Result = {{25{0}}, temp1};

	                end

		        4'b1000: begin //slt
				ALU_Result = (A<B)? 1: 0;
	                end

                        4'b1001: begin //slt
				ALU_Result = (A<B)? 1: 0;
	                end
                        
                        4'b1010: begin // lui
                                ALU_Result = B; 
                        end

                       default: 
                                
                                ALU_Result = 32'b0;
		endcase
	end
endmodule	
