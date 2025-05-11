module undriven_test;
  // 1. Completely unused variable (will trigger UNUSEDSIGNAL)
  wire unused_wire;
  logic unused_logic;
  logic [7:0] unused_vector;

  // 2. Driven but not used variables (will trigger UNUSEDSIGNAL)
  wire driven_unused;
  logic [3:0] driven_unused_reg;
  assign driven_unused = 1'b1;
  initial driven_unused_reg = 4'hF;
  
  // 3. Used but not driven variables (will trigger UNDRIVEN)
  wire undriven_wire;
  logic [3:0] undriven_reg;
  logic [7:0] some_output = undriven_wire ? undriven_reg : 8'b0;
  
  // 4. Partially driven/used variables (will trigger bit-specific warnings)
  logic [7:0] partial_driven;
  logic [7:0] partial_used;
  wire [3:0] partial_bits;
  
  assign partial_bits[1:0] = 2'b11; // Only driving bits 1:0
  
  // 5. Always_comb variable ordering (fixed to avoid warning)
  logic [7:0] comb_order;
  logic tmp; // Declare outside the always_comb block
  always_comb begin
    comb_order = 8'hFF;    // Drive first
    tmp = comb_order[0];   // Then use predeclared variable 
  end
  
  // 6. Multi-driven variables (will trigger MULTIDRIVEN)
  logic [7:0] multi_driven;
  always_comb begin
    multi_driven = 8'h01;
  end
  
  always @(posedge clk) begin
    multi_driven <= 8'h02; // Driven in two different processes
  end
  
  // 7. Avoid procedural assignment to wire by using var
  logic proc_var;
  initial begin
    proc_var = 1'b1; // Now valid
  end
  
  // 8. Continuous assignment to var (valid in SystemVerilog)
  logic cont_var;
  assign cont_var = 1'b1;
  
  // 9. Fixed task call with proper variable
  logic output_var;
  
  task modify_var(output bit out);
    out = 1'b1;
  endtask
  
  initial begin
    modify_var(output_var); // Fixed - using var not wire
  end
  
  // 10. Using only some bits of vector (will trigger bit-specific warnings)
  logic [15:0] vector_with_unused_bits;
  initial begin
    vector_with_unused_bits[7:0] = 8'hAA; // Only lower 8 bits used
  end
  
  // 11. Generate block for under-generate test
  genvar i;
  generate
    for (i = 0; i < 2; i++) begin : gen_block
      logic [7:0] gen_reg;
      always_comb begin
        gen_reg = 8'h00;
      end
    end
  endgenerate
  
  // Add a clock for sequential processes
  logic clk = 0;
  always #5 clk = ~clk;
  
endmodule
