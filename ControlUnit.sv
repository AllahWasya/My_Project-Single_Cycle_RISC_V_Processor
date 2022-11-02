module Controller(br_eq, br_lt, pc_sel, branch_unsign, a_sel,RegWrite, MemRead, MemWrite, ALUOp, controller_received_instr, ALUSrc, MemtoReg,
                  st_byte,ld_byte,st_hw,ld_hw,unsign);

    input  [31:0] controller_received_instr;
    input  br_eq, br_lt;
    output logic  branch_unsign;
    output logic  st_byte,ld_byte,st_hw,ld_hw;
 
    output logic pc_sel,RegWrite, MemRead, MemWrite, a_sel,unsign;
    output logic ALUSrc;
    output logic [1:0] MemtoReg;
    output [3:0] ALUOp;
    

    logic [3:0] ALUOp;
    logic [6:0] funct7;    //  Funct7 
    logic [2:0] funct3;    //  Funct3 
    logic [6:0] opcode; 

assign opcode = controller_received_instr[6:0];
assign funct7 = controller_received_instr[31:25];
assign funct3 = controller_received_instr[14:12];


always@(*) begin

       if (opcode == 7'b0110011 && funct3 == 3'b000 && funct7 == 7'b000000) begin
             MemtoReg = 2'b00;
             MemWrite = 1'b0;
             MemRead = 1'b0;
             ALUSrc = 1'b0;
             RegWrite = 1'b1;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0; 
             ALUOp = 4'b0000; //1-add
        end

       else if (opcode == 7'b0010011 && funct3 == 3'b000) begin

             MemtoReg = 2'b00;
             MemWrite = 1'b0;
             MemRead = 1'b0;
             ALUSrc = 1'b1;
             RegWrite = 1'b1;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0; 
             ALUOp = 4'b0000;  // 2-addi

        end  

       else if (opcode == 7'b0110011 && funct3 == 3'b000 && funct7 == 7'b0100000) begin

             MemtoReg = 2'b00;
             MemWrite = 1'b0;
             MemRead = 1'b0;
             ALUSrc = 1'b0;
             RegWrite = 1'b1;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0; 
             ALUOp = 4'b0001;  // 3-sub     
        end  

      else if (opcode == 7'b0110011 && funct3 == 3'b100) begin
             MemtoReg = 2'b00;
             MemWrite = 1'b0;
             MemRead = 1'b0;
             ALUSrc = 1'b0;
             RegWrite = 1'b1;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0; 
             ALUOp = 4'b0100;   // 4-xor
        end  

      else if (opcode == 7'b011_0011 && funct3 == 3'b111) begin
             MemtoReg = 2'b00;
             MemWrite = 1'b0;
             MemRead = 1'b0;
             ALUSrc = 1'b0;
             RegWrite = 1'b1;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0; 
             ALUOp = 4'b0011;   // 5-and 
      end 

      else if (opcode == 7'b011_0011 && funct3 == 3'b110) begin

             MemtoReg = 2'b00;
             MemWrite = 1'b0;
             MemRead = 1'b0;
             ALUSrc = 1'b0;
             RegWrite = 1'b1;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0; 
             ALUOp = 4'b0010;   // 6-or 
      end 

      else if (opcode == 7'b011_0011 && funct3 == 3'b001) begin

             MemtoReg = 2'b00;
             MemWrite = 1'b0;
             MemRead = 1'b0;
             ALUSrc = 1'b0;
             RegWrite = 1'b1;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0; 
             ALUOp = 4'b0101;   // 6-sll 
      end 

      else if (opcode == 7'b011_0011 && funct3 == 3'b101 && funct7 == 7'b0000000) begin
             MemtoReg = 2'b00;
             MemWrite = 1'b0;
             MemRead = 1'b0;
             ALUSrc = 1'b0;
             RegWrite = 1'b1;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0; 
             ALUOp = 4'b0110;   // 6-srl 
      end 

      else if (opcode == 7'b011_0011 && funct3 == 3'b101 && funct7 == 7'b0100000) begin
             MemtoReg = 2'b00;
             MemWrite = 1'b0;
             MemRead = 1'b0;
             ALUSrc = 1'b0;
             RegWrite = 1'b1;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0; 
             ALUOp = 4'b0111;   // 7-sra 
      end

     else if (opcode == 7'b011_0011 && funct3 == 3'b010) begin
             MemtoReg = 2'b00;
             MemWrite = 1'b0;
             MemRead = 1'b0;
             ALUSrc = 1'b0;
             RegWrite = 1'b1;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0; 
             ALUOp = 4'b1000;   // 7-slt
      end

     else if (opcode == 7'b011_0011 && funct3 == 3'b011) begin
             MemtoReg = 2'b00;
             MemWrite = 1'b0;
             MemRead = 1'b0;
             ALUSrc = 1'b0;
             RegWrite = 1'b1;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0; 
             ALUOp = 4'b1001;   // 7-sltu
      end

      else if (opcode == 7'b0010011 && funct3 == 3'b100) begin
             MemtoReg = 2'b00;
             MemWrite = 1'b0;
             MemRead = 1'b0;
             ALUSrc = 1'b1;
             RegWrite = 1'b1;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0; 
             ALUOp = 4'b0100;   // 8-xori
        end  

      else if (opcode == 7'b001_0011 && funct3 == 3'b110) begin
             MemtoReg = 2'b00;
             MemWrite = 1'b0;
             MemRead = 1'b0;
             ALUSrc = 1'b1;
             RegWrite = 1'b1;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0; 
             ALUOp = 4'b0010;   // 9-ori 
      end 

      else if (opcode == 7'b001_0011 && funct3 == 3'b111) begin
             MemtoReg = 2'b00;
             MemWrite = 1'b0;
             MemRead = 1'b0;
             ALUSrc = 1'b1;
             RegWrite = 1'b1;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0; 
             ALUOp = 4'b0011;   // 10-andi 
      end 

      else if (opcode == 7'b001_0011 && funct3 == 3'b001) begin
             MemtoReg = 2'b00;
             MemWrite = 1'b0;
             MemRead = 1'b0;
             ALUSrc = 1'b1;
             RegWrite = 1'b1;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0; 
             ALUOp = 4'b0101;   // 11-slli 
      end 

    else if (opcode == 7'b001_0011 && funct3 == 3'b101 && funct7 == 7'b0000000) begin
             MemtoReg = 2'b00;
             MemWrite = 1'b0;
             MemRead = 1'b0;
             ALUSrc = 1'b1;
             RegWrite = 1'b1;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0; 
             ALUOp = 4'b0110;   // 12-srli 
      end 

      else if (opcode == 7'b0010011 && funct3 == 3'b101 && funct7 == 7'b0100000) begin
             MemtoReg = 2'b00;
             MemWrite = 1'b0;
             MemRead = 1'b0;
             ALUSrc = 1'b1;
             RegWrite = 1'b1;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0; 
             ALUOp = 4'b0111;   // 13-srai 
      end

  else if (opcode == 7'b001_0011 && funct3 == 3'b010) begin
             MemtoReg = 2'b00;
             MemWrite = 1'b0;
             MemRead = 1'b0;
             ALUSrc = 1'b1;
             RegWrite = 1'b1;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0; 
             ALUOp = 4'b1000;   // 14-slti
      end

   else if (opcode == 7'b0010011 && funct3 == 3'b011) begin
             MemtoReg = 2'b00;
             MemWrite = 1'b0;
             MemRead = 1'b0;
             ALUSrc = 1'b1;
             RegWrite = 1'b1;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0; 
             ALUOp = 4'b1001;   // 15-sltu
      end

  else if (opcode == 7'b0100011 && funct3 == 3'b000) begin
             st_hw  = 1'b0;
             st_byte  = 1'b1;
             ld_byte  = 1'b0;
             ld_hw    = 1'b0;
             MemtoReg = 2'b01;
             MemWrite = 1'b1;
             MemRead = 1'b0;
             ALUSrc = 1'b1;
             RegWrite = 1'b0;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0; 
             ALUOp = 4'b0000;   // 16-sb
      end

  else if (opcode == 7'b0000011 && funct3 == 3'b000) begin
             st_hw  = 1'b0;
             st_byte  = 1'b0;
             ld_byte  = 1'b1;
             ld_hw    = 1'b0;
             MemtoReg = 2'b01;
             MemWrite = 1'b0;
             MemRead = 1'b1;
             ALUSrc = 1'b1;
             RegWrite = 1'b1;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
		unsign = 1'b0;
             pc_sel = 1'b0; 
             ALUOp = 4'b0000;   // 17-lb
      end
 else if (opcode == 7'b0000011 && funct3 == 3'b100) begin
             st_hw  = 1'b0;
             st_byte  = 1'b0;
             ld_byte  = 1'b1;
             ld_hw    = 1'b0;
             MemtoReg = 2'b01;
             MemWrite = 1'b0;
             MemRead = 1'b1;
             ALUSrc = 1'b1;
             RegWrite = 1'b1;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
		unsign = 1'b1;
             pc_sel = 1'b0; 
             ALUOp = 4'b0000;   // 17-ulb
      end


  else if (opcode == 7'b0100011 && funct3 == 3'b001) begin
             st_hw  = 1'b1;
             st_byte  = 1'b0;
             ld_byte  = 1'b0;
             ld_hw    = 1'b0;
             MemtoReg = 2'b01;
             MemWrite = 1'b1;
             MemRead = 1'b0;
             ALUSrc = 1'b1;
             RegWrite = 1'b0;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0; 
             ALUOp = 4'b0000;   // 16-shw
      end

  else if (opcode == 7'b0000011 && funct3 == 3'b001) begin
             st_hw  = 1'b0;
             st_byte  = 1'b0;
             ld_byte  = 1'b0;
             ld_hw    = 1'b1;
             ld_byte =1'b0;
             MemtoReg = 2'b01;
             MemWrite = 1'b0;
             MemRead = 1'b1;
             ALUSrc = 1'b1;
             RegWrite = 1'b1;
		unsign = 1'b0;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0;
             ALUOp = 4'b0000;   // 17-lhw
      end
else if (opcode == 7'b0000011 && funct3 == 3'b101) begin
             st_hw  = 1'b0;
             st_byte  = 1'b0;
             ld_byte  = 1'b0;
             ld_hw    = 1'b1;
             ld_byte =1'b0;
             MemtoReg = 2'b01;
             MemWrite = 1'b0;
             MemRead = 1'b1;
             ALUSrc = 1'b1;
             RegWrite = 1'b1;
		unsign = 1'b1;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0;
             ALUOp = 4'b0000;   // 17-ulhw
      end

  else if (opcode == 7'b0100011 && funct3 == 3'b010) begin           
             st_hw  = 1'b0;
             st_byte  = 1'b0;
             ld_byte  = 1'b0;
             ld_hw    = 1'b0;
             MemtoReg = 2'b01;
             MemWrite = 1'b1;
             MemRead = 1'b0;
             ALUSrc = 1'b1;
             RegWrite = 1'b0;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0;
             ALUOp = 4'b0000;   // 16-sw
      end

  else if (opcode == 7'b0000011 && funct3 == 3'b010) begin

             st_hw  = 1'b0;
             st_byte  = 1'b0;
             ld_byte  = 1'b0;
             ld_hw    = 1'b0;
             MemtoReg = 2'b01;
             MemWrite = 1'b0;
             MemRead = 1'b1;
             ALUSrc = 1'b1;
             RegWrite = 1'b1;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
		unsign = 1'b0;
             pc_sel = 1'b0; 
             ALUOp = 4'b0000;   // 17-lw
      end

  else if (opcode == 7'b1100011 && funct3 == 3'b000) begin
             branch_unsign = 1'b0; 
	     MemtoReg = 1'b1;
             MemWrite = 1'b0;
             MemRead = 1'b0;
	    RegWrite = 1'b0;

         if (br_eq == 1) begin
             ALUSrc = 1'b1;
             a_sel = 1'b1;
             pc_sel = 1'b1; 
             ALUOp = 4'b0000;   // 18-beq
         end 
         else begin
             ALUSrc = 1'b1;
             a_sel = 1'b1;
             pc_sel = 1'b0; 
             ALUOp = 4'b0000;
         end
   end

  else if (opcode == 7'b1100011 && funct3 == 3'b001) begin
	branch_unsign = 1'b0;
	MemtoReg = 1'b1;
             MemWrite = 1'b0;
             MemRead = 1'b0;
	 RegWrite = 1'b0;
	if (br_eq==0) begin
             
             ALUSrc = 1'b1;
             a_sel = 1'b1;
             pc_sel = 1'b1; 
             ALUOp = 4'b0000;   // 19-bne
         end

        else begin
             ALUSrc = 1'b1;
             a_sel = 1'b1;
             pc_sel = 1'b0; 
             ALUOp = 4'b0000;
        end

      end

 else if (opcode == 7'b1100011 && funct3 == 3'b100) begin
	branch_unsign = 1'b0;
	MemtoReg = 1'b1;
             MemWrite = 1'b0;
             MemRead = 1'b0;
	     RegWrite = 1'b0;
	if (br_lt==1) begin
             ALUSrc = 1'b1;
             a_sel = 1'b1;
             pc_sel = 1'b1; 
             ALUOp = 4'b0000;   // 20-blt
         end

        else begin
             ALUSrc = 1'b1;
             a_sel = 1'b1;
             pc_sel = 1'b0; 
             ALUOp = 4'b0000;
             pc_sel = 1'b0;
         end
      end

 else if (opcode == 7'b1100011 && funct3 == 3'b101) begin
	branch_unsign = 1'b0;
	MemtoReg = 1'b1;
        MemWrite = 1'b0;
        MemRead = 1'b0;
	RegWrite = 1'b0;
	if (br_lt==0) begin          
             ALUSrc = 1'b1;
             a_sel = 1'b1;
             pc_sel = 1'b1; 
             ALUOp = 4'b0000;   // 21-bge
         end

        else begin          
             ALUSrc = 1'b1;
             a_sel = 1'b1;
             pc_sel = 1'b0; 
             ALUOp = 4'b0000;   // 21-bge
         end       
      end

 
 else if (opcode == 7'b1100011 && funct3 == 3'b110) begin
	branch_unsign = 1'b1;
	MemtoReg = 1'b1;
        MemWrite = 1'b0;
        MemRead = 1'b0;
	RegWrite = 1'b0;
	if (br_lt==1) begin     
             ALUSrc = 1'b1;
             a_sel = 1'b1;
             pc_sel = 1'b1; 
             ALUOp = 4'b0000;   // 22-bltu
         end
        else begin     
             ALUSrc = 1'b1;
             a_sel = 1'b1;
             pc_sel = 1'b0; 
             ALUOp = 4'b0000;   // 22-bltu
         end           
      end


  else if (opcode == 7'b1100011 && funct3 == 3'b111) begin
	branch_unsign = 1'b1;
	MemtoReg = 1'b1;
        MemWrite = 1'b0;
        MemRead = 1'b0;
	RegWrite = 1'b0;
        ALUSrc = 1'b1;
        ALUOp = 4'b0000; 
	if (br_lt==1'b0) begin
             a_sel = 1'b1;
             pc_sel = 1'b1;   // 23-bgeu
         end
        else begin
             a_sel = 1'b1;
             pc_sel = 1'b0;
         end
      end


  else if (opcode == 7'b1101111) begin

             MemtoReg = 2'b10;
             MemWrite = 1'b0;
             MemRead = 1'b0;
             ALUSrc = 1'b1;
             RegWrite = 1'b1;
             a_sel = 1'b1;
             branch_unsign = 1'b0;
             pc_sel = 1'b1; 
             ALUOp = 4'b0000;   // 25-jal
      end

 else if (opcode == 7'b1100111 && funct3 == 3'b000) begin
             MemtoReg = 2'b10;
             MemWrite = 1'b0;
             MemRead = 1'b0;
             ALUSrc = 1'b1;
             RegWrite = 1'b1;
             a_sel = 1'b0;
             branch_unsign = 1'b1;
             pc_sel = 1'b1; 
             ALUOp = 4'b0000;   // 26-jalr
      end

 else if (opcode == 7'b0110111) begin
             MemtoReg = 2'b00;
             MemWrite = 1'b0;
             MemRead = 1'b0;
             ALUSrc = 1'b1;
             RegWrite = 1'b1;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0; 
             ALUOp = 4'b1010;   // lui
      end


    else begin                   // Set all signals to 0      
             MemtoReg = 2'b00;
             MemWrite = 1'b0;
             MemRead = 1'b0;
             ALUSrc = 1'b0;
             RegWrite = 1'b0;
             a_sel = 1'b0;
             branch_unsign = 1'b0;
             pc_sel = 1'b0; 
             ALUOp = 4'b0000;   
     end
end  
endmodule
