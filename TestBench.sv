module tb;
logic clk,reset;
logic [31:0] wrt_data;

top dut (.wrt_data(wrt_data), .clk(clk), .reset(reset));

initial begin

clk=1'b0;
reset=1'b1;
#1
reset=1'b0;
end

initial begin
#1
$display ("Start PC: %0d", dut.pc.current_pc);
$display("Register Contents at Time 1ns...");

// $monitor("Write Back Result : %0d",$signed(wrt_data));
for(int i=0; i<32; i++) begin
$display("%h",dut.rg1.reg_mem[i]);
end

#4999 // Simulation time of all intrunctions 

$display("Register Contents After program Execution..");

for(int i=0; i<32; i++) begin
$display("x%0d : %0d",i,$signed(dut.rg1.reg_mem[i]));
end
$display ("End PC: %0d", dut.pc.current_pc);
end
initial 
begin
$readmemh("data.bin",dut.im1.memory);	// data access	
end
always begin

#5 clk=~clk;

end
endmodule
