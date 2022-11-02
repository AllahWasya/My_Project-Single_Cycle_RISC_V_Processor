module InstMemory(address, instruction);

    input  [31:0] address;
    output logic [31:0] instruction;
    
    logic [31:0] memory [63:0];
    logic [31:0]addr;

assign addr = address>>2;
always @(*)
begin
if (address[1])
	instruction =  {memory[addr+1][15:0],memory[addr][31:16]};
else 
	instruction = memory[addr];
end
endmodule
