module ImmGen(inst_code, Imm_out  );


    input [31:0] inst_code;
    output [31:0] Imm_out;

    logic [4:0] srai;
    reg [31:0] Imm_out;
    always@(inst_code) begin

        // Case statement that will generate the immidiate value based on the intruction code
          case(inst_code[6:0])
            // Immidiate 
            7'b0000011 : Imm_out = {{20{inst_code[31]}} , inst_code[31:20]};
            // Immidiate addition
            7'b0010011 : Imm_out = {inst_code[31] ? {20{1'b1}} : 20'b0, inst_code[31:20]};
            // Immidiate 
            7'b0100011 : Imm_out = {inst_code[31] ? {20{1'b1}} : 20'b0, inst_code[31:25], inst_code[11:7]};
            // Immidiate
            7'b0010111 : Imm_out = {inst_code[31:12], 12'b0};            
            7'b0100011 /*S-type*/    : 
            Imm_out = {{20{inst_code[31]}} , inst_code[31:25], inst_code[11:7]};
            7'b1100011 /*B-type*/    : 
            Imm_out = {{20{inst_code[31]}} , inst_code[7], inst_code[30:25],inst_code[11:8],1'b0};
            7'b1100111 /*JALR*/    : 
            Imm_out = {inst_code[31]? 20'b1:20'b0 , inst_code[30:25], inst_code[24:21], inst_code[20]};
            7'b0010111 /*U-type*/    : 
            Imm_out = {inst_code[31]? 1'b1:1'b0 , inst_code[30:20], inst_code[19:12],12'b0};
            7'b0110111 /*LUI-type*/    : 
            Imm_out = {inst_code[31:12], 12'b0};
            7'b0110111 /*AUIPC-type*/    : 
            Imm_out = {inst_code[31:12], 12'b0};
            7'b1101111 /*JAL*/    : 
            Imm_out = {{20{inst_code[31]}} , inst_code[19:12], inst_code[19:12],inst_code[20], inst_code[30:25],inst_code[24:21],1'b0};

            default : Imm_out = 32'b0;
        endcase
    end 
    
endmodule
