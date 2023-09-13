`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"

`timescale 1 ns/1 ns

module control_unit_tb;

    parameter PERIOD = 10;
    logic CLK = 0;
    logic nRST = 0;
    // clock
    always #(PERIOD/2) CLK++;

    //interface
    control_unit_if cuif();
    // test program
    test #(.PERIOD (PERIOD)) PROG (
        .clk(CLK),
        .nRST(nRST),
        .cuif(cuif)
    );
    //DUT
    `ifndef MAPPED
        control_unit CU(CLK, nRST, cuif);
    `else
        control_unti CU(
            .\cuif.Equal (cuif.Equal),
            .\cuif.opcode (cuif.opcode),
            .\cuif.funct (cuif.funct),
            .\cuif.shamt (cuif.shamt),
            .\cuif.flushed (cuif.flushed),
            .\cuif.zero (cuif.zero),
            .\cuif.negative (cuif.negative),
            .\cuif.overflow (cuif.overflow),
            .\cuif.ExtOp (cuif.ExtOp),
            .\cuif.ALUSrc (cuif.ALUSrc),
            .\cuif.MemtoReg (cuif.MemtoReg),
            .\cuif.Branch (cuif.Branch),
            .\cuif.Jump (cuif.Jump),
            .\cuif.JR (cuif.JR),
            .\cuif.RegDst (cuif.RegDst),
            .\cuif.RegWr (cuif.RegWr),
            .\cuif.ALUCtr (cuif.ALUCtr),
            .\cuif.JumpReg (cuif.JumpReg),
            .\cuif.LUI (cuif.LUI),
            .\cuif.LDsel (cuif.LDsel),
            .\cuif.SVsel (cuif.SVsel),
            .\cuif.iread (cuif.iread),
            .\cuif.dread (cuif.dread),
            .\cuif.dwrite (cuif.dwrite),
            .\cuif.halt (cuif.halt),
            .\nRST(nRST),
            .\CLK (CLK)
        );
    `endif

endmodule

program test(
  input logic clk,
  output logic nRST, 
  control_unit_if cuif
);
    import cpu_types_pkg::*;
    parameter PERIOD = 10;
    int tb_test_num;
    string tb_test_case;

    task reset();
    begin
        tb_test_case = "RESET";
        tb_test_num++;
        nRST = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(negedge clk);
        nRST = 1;
    end
    endtask

    task r_type;
    input string rcase;
    input funct_t rfunct;
    begin
        tb_test_num++;
        tb_test_case = rcase;
        cuif.opcode = RTYPE;
        cuif.funct = rfunct;
        #PERIOD;
    end
    endtask

    task j_i_type;
    input string jicase;
    input opcode_t jicode;
    begin
        tb_test_num++;
        tb_test_case = jicase;
        cuif.opcode = jicode;
        #PERIOD;
    end
    endtask

    task branch;
    input string bcase;
    input word_t eq;
    input opcode_t bcode;
    begin
        tb_test_num++;
        tb_test_case = bcase;
        cuif.opcode = bcode;
        cuif.Equal = eq;
        #PERIOD;
    end
    endtask

    initial begin
        tb_test_num = 0;
        tb_test_case = "Start testing";
        #PERIOD;
        reset();
        //R Type
        // SLLV
        r_type("R_Type: SLLV", SLLV);
        // SRLV
        r_type("R_Type: SRLV", SRLV);
        // JR
        r_type("R_Type: JR", JR);
        // ADD
        r_type("R_Type: ADD", ADD);
        // ADDU
        r_type("R_Type: SLLV", ADDU);
        // SUB
        r_type("R_Type: SUB", SUB);
        // SUBU
        r_type("R_Type: SUBU", SUBU);
        // AND
        r_type("R_Type: AND", AND);
        // OR
        r_type("R_Type: OR", OR);
        // XOR
        r_type("R_Type: XOR", XOR);
        // NOR
        r_type("R_Type: NOR", NOR);
        // SLT
        r_type("R_Type: SLT", SLT);
        // SLTU
        r_type("R_Type: SLTU", SLTU);
        
        //J Type
        // Jump
        j_i_type("J_Type: Jump", J);
        // JAL
        j_i_type("J_Type: JAL", JAL);

        //Branch
        //BEQ taken
        branch("Branch: BEQ taken", 0, BEQ);
        //BEQ not taken
        branch("Branch: BEQ not taken", 32'd87, BEQ);
        //BNE taken
        branch("Branch: BNE taken", 32'd87, BNE);
        //BEQ not taken
        branch("Branch: BNE not taken", 0, BNE);

        //I Type
        // ADDI
        j_i_type("I_Type: ADDI", ADDI);
        // ADDIU
        j_i_type("I_Type: ADDIU", ADDIU);
        // SLTI
        j_i_type("I_Type: SLTI", SLTI);
        // SLTIU
        j_i_type("I_Type: SLTIU", SLTIU);
        // ANDI
        j_i_type("I_Type: ANDI", ANDI);
        // ORI
        j_i_type("I_Type: ORI", ORI);
        // XORI
        j_i_type("I_Type: XORI", XORI);
        // LUI
        j_i_type("I_Type: LUI", LUI);
        // LW
        j_i_type("I_Type: LW", LW);
        // LBU
        j_i_type("I_Type: LBU", LBU);
        // LHU
        j_i_type("I_Type: LHU", LHU);
        // SB
        j_i_type("I_Type: SB", SB);
        // SH
        j_i_type("I_Type: SH", SH);
        // SW
        j_i_type("I_Type: SW", SW);
        // HALT
        j_i_type("I_Type: HALT", HALT);
        
        $stop();
    end

endprogram