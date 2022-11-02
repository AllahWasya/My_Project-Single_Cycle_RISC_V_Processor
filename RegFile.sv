module regfile(clk, reset, en, rd_addr1, rd_addr2, 
                wrt_addr, data, read1, read2);
                

    input         clk, reset, en;
    input  [ 4:0] rd_addr1, rd_addr2, wrt_addr;
    input  [31:0] data;
    output [31:0] read1, read2;
    
reg [31:0] reg_mem [0:31];
    
integer i;

initial begin  
reg_mem[i] = 0;
end 

 always@(posedge clk, posedge reset) begin
        if(reset) begin
            for(i=0; i<32; i++) 
                reg_mem[i] = 32'b0;
        end
        else
            if(en)
	    begin
		if(wrt_addr == 5'd0)
		begin
			reg_mem[wrt_addr] <= 32'd0;
		end
		else
		begin
               		reg_mem[wrt_addr] <= data;
		end
	   end
	   else
		reg_mem[wrt_addr]<=reg_mem[wrt_addr];
    end

    assign read1 = reg_mem[rd_addr1];
    assign read2 = reg_mem[rd_addr2];
    
endmodule
