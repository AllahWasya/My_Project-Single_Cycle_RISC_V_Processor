module DataMem(clk, MemRead, MemWrite, addr, write_data, read_data, st_byte, load_byte, st_hw, ld_hw,unsign);

 
    input  clk, MemRead, MemWrite,unsign;
    input  [31:0] addr;
    input  [31:0] write_data;
    output [31:0] read_data;

    input  st_byte,load_byte,st_hw,ld_hw;
    
    logic  [31:0] memory [0:127];
    logic [31:0] read_data;
    logic [31:0] addr1;

  


assign addr1 = addr>>2;

always@(posedge clk) begin 
   
        if(MemWrite) begin

           if (st_byte) begin
               if (addr[1:0] == 2'b00)
               memory[addr1][7:0] <= write_data;
               else if (addr[1:0] == 2'b01) 
               memory[addr1][15:8] <= write_data;
               else if (addr[1:0] == 2'b10) 
               memory[addr1][23:16] <= write_data;
               else 
               memory[addr1][31:24] <= write_data;
           end

           else if (st_hw) begin
               if (addr[1] == 1'b0)
               memory[addr1][15:0] <= write_data;
               else
               memory[addr1][31:16] <= write_data;
           end

        else begin

             memory[addr1] <= write_data;  // sw
        end
        end

end

always @ (*) begin

if (MemRead) begin
	if (unsign == 0) begin

     if (load_byte) begin  
     
     
               if (addr[1:0] == 2'b00)
               read_data = {{24{memory[addr1][7]}},memory[addr1][7:0]};
               else if (addr[1:0] == 2'b01) 
                read_data = {{24{memory[addr1][15]}},memory[addr1][15:8]};
               else if (addr[1:0] == 2'b10) begin

               read_data = {{24{memory[addr1][23]}},memory[addr1][23:16]};
               end
               else begin
               read_data = {{24{memory[addr1][31]}},memory[addr1][31:24]};
               end
               end
     else if (ld_hw) begin
               if (addr[1] == 1'b0) 
               read_data = {{16{memory[addr1][15]}},memory[addr1][15:0]};
               else 
               read_data = {{16{memory[addr1][31]}},memory[addr1][31:16]};
              end
     else 
 
              read_data = memory[addr1];
	end
	else begin
	if (load_byte) begin  
     
     
               if (addr[1:0] == 2'b00)
               read_data ={ {24{1'b0}},memory[addr1][7:0]};
               else if (addr[1:0] == 2'b01) 
                read_data ={ {24{1'b0}},memory[addr1][15:8]};
               else if (addr[1:0] == 2'b10)
               read_data = { {24{1'b0}},memory[addr1][23:16]};
               else 
               read_data ={ {24{1'b0}}, memory[addr1][31:24]};
               end
     else if (ld_hw) begin
               if (addr[1] == 1'b0) 
               read_data = {{16{1'b0}},memory[addr1][15:0]};
               else 
               read_data = {{16{1'b0}},memory[addr1][31:16]};
              end
     else 
 
              read_data = memory[addr1];
	end
	

end
end         
endmodule
