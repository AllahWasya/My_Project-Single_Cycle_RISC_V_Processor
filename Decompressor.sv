module decompressor(input  logic [31:0] inst_in,
                    output logic [31:0] instruction_out,
                    output logic pc_plus);
logic [1:0] opcode;
logic [2:0] func3;

assign opcode = inst_in [1:0];
assign func3  = inst_in [15:13];

always @ (*) begin

if (inst_in [1:0] == 2'b11) begin

instruction_out = inst_in;

pc_plus =1'b0;

end

else begin

pc_plus =1'b1;

if ((opcode == 2'b01) && (func3 == 3'b000)) begin   //addi

//instruction_out = {{6{0}},inst_in[6:2],inst_in[12],inst_in[11:7],inst_in[15:13],inst_in[11:7],7'b0010011};
instruction_out = {{6 {1'b0}}, inst_in[12], inst_in[6:2], inst_in[11:7], 3'b0, inst_in[11:7], 7'b0010011};

end

else if ((opcode == 2'b10) && (func3 == 3'b100) && inst_in[12]==1'b1) begin   // add
instruction_out = {7'b0,inst_in[6:2],inst_in[11:7],3'b000,inst_in[11:7],7'b0110011};
end

else if ((opcode == 2'b01) && (func3 == 3'b100) && (inst_in[11:10]==2'b10)) begin   // andi 
instruction_out = {{6 {inst_in[12]}}, inst_in[12], inst_in[6:2], 2'b01, inst_in[9:7], 3'b111, 2'b01, inst_in[9:7],7'b0010011};
//$display("Reached %h",inst_in);
end

else if (inst_in[1:0]==2'b01&&inst_in[6:5]==2'b11&&inst_in[15:10]==6'b100011) begin   // and
instruction_out = {7'b0,2'b01,inst_in[4:2],2'b01,inst_in[9:7],3'b111,2'b01,inst_in[9:7],7'b0110011};
end


else if (inst_in[1:0]==2'b10 && inst_in[15:12]==4'b1000 && inst_in[12]==1'b0) begin   // mv
instruction_out = {7'd0,inst_in[6:2],5'b00000,3'b000,inst_in[11:7],7'b0110011};

end

else if (inst_in[1:0]==2'b01&&inst_in[6:5]==2'b00&&inst_in[15:10]==6'b100011) begin   // sub
instruction_out = {7'b0100000,2'b01,inst_in[4:2],2'b01,inst_in[9:7],3'b000,2'b01,inst_in[9:7],7'b0110011};

end

else if ((opcode == 2'b01) && (func3 == 3'b100)&&inst_in[11:10]==2'b00) begin   // srli 
instruction_out = {7'b0, inst_in[6:2], 2'b01, inst_in[9:7], 3'b101, 2'b01, inst_in[9:7],7'b0010011};

end

else if ((opcode == 2'b01) && (func3 == 3'b010)) begin    // li

instruction_out = {{6{inst_in[12]}}, inst_in[12], inst_in[6:2], 5'b0, 3'b0, inst_in[11:7],7'b0010011};

end

else if ((opcode == 2'b00) && (func3 == 3'b110)) begin    // sw

instruction_out = {5'b0, inst_in[5], inst_in[12], 2'b01, inst_in[4:2], 2'b01, inst_in[9:7], 3'b010, inst_in[11:10], inst_in[6], 2'b00, 7'b0100011};

end

else if ((opcode == 2'b00) && (func3 == 3'b010)) begin    // lw

instruction_out = {5'b0, inst_in[5], inst_in[12:10], inst_in[6], 2'b00, 2'b01, inst_in[9:7], 3'b010, 2'b01, inst_in[4:2], 7'b0000011};


end

else 
instruction_out = 32'b0;
end
end
endmodule
