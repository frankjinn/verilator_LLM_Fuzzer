module undriven_test;
  wire unused_wire;
  logic unused_logic;
  logic [7:0] unused_vector;
  wire driven_unused;
  logic [3:0] driven_unused_reg;
  assign driven_unused = 1'b1;
  initial driven_unused_reg = 4'hF;
  wire undriven_wire;
  logic [3:0] undriven_reg;
  logic [7:0] some_output = undriven_wire ? undriven_reg : 8'b0;
  logic [7:0] partial_driven;
  logic [7:0] partial_used;
  wire [3:0] partial_bits;
  assign partial_bits[1:0] = 2'b11;
  logic [7:0] comb_order;
  logic tmp;
  always_comb begin
    comb_order = 8'hFF;
    tmp = comb_order[0];
  end
  logic [7:0] multi_driven;
  always_comb begin
    multi_driven = 8'h01;
  end
  always @(posedge clk) begin
    multi_driven <= 8'h02;
  end
  logic proc_var;
  initial begin
    proc_var = 1'b1;
  end
  logic cont_var;
  assign cont_var = 1'b1;
  logic output_var;
  task modify_var(output bit out);
    out = 1'b1;
  endtask
  initial begin
    modify_var(output_var);
  end
  logic [15:0] vector_with_unused_bits;
  initial begin
    vector_with_unused_bits[7:0] = 8'hAA;
  end
  genvar i;
  generate
    for (i = 0; i < 2; i++) begin : gen_block
      logic [7:0] gen_reg;
      always_comb begin
        gen_reg = 8'h00;
      end
    end
  endgenerate
  logic clk = 0;
  always #5 clk = ~clk;
endmodule
