module top#( 
    parameter pc_width = 32,           
    parameter Inst_mem_size = 32,      
    parameter reg_file_adr_size = 5,  
    parameter output_data_width = 32,      
    parameter dm_address = 9,   
    parameter alu_ctrl_w = 4      
  )(// Initialize input, output signals
    input   clk, reset,     
    input   reg_write, // RegWrite 
    input   [1:0] mem2reg,   // MemtoReg 
    input   alu_src,   // ALUSrc 
    input   mem_write, // MemWrite
    input   mem_read,  // MemRead
    input   [alu_ctrl_w-1:0] alu_cc,    // ALU control signal    
    output  logic [output_data_width-1:0] alu_result, // ALU_Result 
    output  logic [31:0] wrt_data
    );

logic carry_out, zero, overflow, which_pc, st_byte1,ld_byte,st_hw1,ld_hw1,unsign, pc_sel;

logic [pc_width-1:0] next_pc, current_pc, pc_in;

logic [Inst_mem_size-1:0] reg_out1, reg_out2, instruction_fetch, instruction_fetch1, alu_in1, alu_in2, immediate_value, mem_data;
 
logic br_sign, br_lt,br_eq, a_sel;   

flipflop ff1(.clk(clk), 
             .reset(reset), 
             .d(pc_in), 
             .q(current_pc));
             
//assign next_pc = current_pc + 32'h4;


pcPlus4  pc(.current_pc(current_pc),
            .which_pc(which_pc),
            .next_pc(next_pc)); 
    
InstMemory im1(.address(current_pc),
               .instruction(instruction_fetch1));

decompressor dc(.inst_in(instruction_fetch1),
                .instruction_out(instruction_fetch),
                .pc_plus(which_pc));

regfile rg1(.clk(clk),
            .reset(reset),
            .en(reg_write),
            .rd_addr1(instruction_fetch[19:19-reg_file_adr_size+1]),
            .rd_addr2(instruction_fetch[24:24-reg_file_adr_size+1]),
            .wrt_addr(instruction_fetch[11:11-reg_file_adr_size+1]),
            .data(wrt_data),
            .read1(reg_out1),          // first input of alu
            .read2(reg_out2)); 
    
branch_comp br_cmp(.A(reg_out1),
                   .B(reg_out2),
                   .branch_unsign(br_sign),
                   .BrEq(br_eq),
                   .BrLt(br_lt)); 

mux m1(.in1(reg_out2),
       .in2(immediate_value),
       .sel(alu_src),
       .y(alu_in2));            //  1st input to alu
   
ImmGen ig1(.inst_code(instruction_fetch),
           .Imm_out(immediate_value));

Controller contr(.ALUOp(alu_cc),
                 .br_eq(br_eq),
                 .br_lt(br_lt),
                 .ALUSrc(alu_src), 
                 .MemtoReg(mem2reg),
                 .RegWrite(reg_write),
                 .MemRead(mem_read),
                 .MemWrite(mem_write),
                 .st_byte(st_byte1),
                 .st_hw(st_hw1),
                 .ld_byte(ld_byte),
                 .ld_hw(ld_hw1),
                 .a_sel(a_sel),
                 .pc_sel(pc_sel),
                 .branch_unsign(br_sign),
                 .controller_received_instr(instruction_fetch),
		.unsign(unsign));

mux     m2(.in1(reg_out1),
           .in2(current_pc),
           .sel(a_sel),
           .y(alu_in1));         //  2nd input to alu
                       
alu a1(.A(alu_in1),
       .B(alu_in2),
       .alu_sel(alu_cc),
       .ALU_Out(alu_result),
       .Carry_Out(carry_out),
       .Zero(zero),
       .Overflow(overflow) );

       
DataMem dm1( .clk(clk),
             .MemWrite(mem_write),
             .MemRead(mem_read),
             .addr(alu_result),
             .write_data(reg_out2),
             .read_data(mem_data),
             .st_byte(st_byte1),
             .load_byte(ld_byte),
             .st_hw(st_hw1),
             .ld_hw(ld_hw1),
	     .unsign(unsign));
              
mux3 m3(.in1(alu_result),
        .in2(mem_data),
        .in3(next_pc),
        .sel(mem2reg),
        .y(wrt_data));  

mux m4(.in1(next_pc),
       .in2(alu_result),
       .sel(pc_sel),
       .y(pc_in));  

    // Assigning the outputs of the Datapath to part of the instruction code 

endmodule