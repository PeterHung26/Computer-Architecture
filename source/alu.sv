`include "alu_if.vh"
`include "cpu_types_pkg.vh"
module alu
(
  alu_if.alu aluif
);
    import cpu_types_pkg::*;

    // word_t b_s;
    // assign b_s = ~aluif.b + 1;

//ffffffff
//ffffffff

always_comb begin
    aluif.out = '0;
    aluif.overflow = '0;
    case(aluif.ops)  //casez?
        ALU_SLL:    aluif.out = aluif.b << aluif.a[4:0];  // aluif.b?
        ALU_SRL:    aluif.out = aluif.b >> aluif.a[4:0]; // aluif.b?
        ALU_ADD:    begin 
                        aluif.out = aluif.a + aluif.b;
                        aluif.overflow = ( aluif.a[31] == aluif.b[31] && aluif.out[31] != aluif.a[31] );
                    end

        ALU_SUB:    begin 
                        aluif.out = aluif.a - aluif.b;
                        aluif.overflow = ( aluif.a[31] != aluif.b[31] && aluif.out[31] != aluif.a[31] );
                    end
        ALU_AND:    aluif.out = aluif.a & aluif.b;
        ALU_OR:     aluif.out = aluif.a | aluif.b;
        ALU_XOR:    aluif.out = aluif.a ^ aluif.b;
        ALU_NOR:    aluif.out = ~(aluif.a | aluif.b);
        ALU_SLT:    aluif.out = (  $signed(aluif.a) < $signed(aluif.b)  ) ? 32'd1 : 32'd0;
        ALU_SLTU:   aluif.out = (  aluif.a < aluif.b) ? 32'd1 : 32'd0;
    endcase
end

    assign aluif.zero = (aluif.out == 0);
    assign aluif.negative = (aluif.out[31] == 1);

endmodule
