// Test module to maximize V3Subst.cpp code coverage
module subst_test;
  // Wide variables for word selection operations
  logic [127:0] wide_var;
  logic [127:0] wide_temp;
  logic [127:0] wide_result;
  
  // Regular variables for whole-variable substitution
  logic [31:0] simple_var;
  logic [31:0] simple_temp;
  logic [31:0] simple_result;
  
  // Variables for complex expressions
  logic [31:0] complex_expr;
  
  // Test pure functionality for SubstUseVisitor
  function automatic logic [31:0] pure_function(logic [31:0] a);
    return a + 32'h1234;
  endfunction
  
  // Test function to exercise CFunc visitor functionality
  function void test_function();
    logic [127:0] func_wide;
    logic [31:0] func_temp;
    logic [31:0] index;
    
    // Variable index word selection (non-constant) - should not be substituted
    index = 0;
    func_wide[31:0] = 32'hABCDEF01;
    func_wide[63:32] = 32'h23456789;
    func_temp = func_wide[index+:32]; // Variable index - won't be substituted
    
    // Test conditional assignment path
    if (func_temp == 32'hABCDEF01) begin
      func_wide[95:64] = 32'h12345678;
    end else begin
      func_wide[95:64] = 32'h87654321;
    end
    
    // Test pure function substitution
    func_temp = pure_function(32'h5555);
    func_wide[127:96] = func_temp;
  endfunction
  
  initial begin
    // Simple assignments that should be substituted
    simple_temp = 32'hDEADBEEF;
    simple_var = simple_temp;  // Should be substituted
    
    // Word selections with constant indices
    wide_temp[31:0] = 32'h12345678;
    wide_temp[63:32] = 32'h9ABCDEF0;
    wide_temp[95:64] = 32'h13579BDF;
    wide_temp[127:96] = 32'h2468ACE0;
    
    // Using word selections - should be substituted
    wide_var[31:0] = wide_temp[31:0];
    wide_var[63:32] = wide_temp[63:32];
    
    // Complex expression - exceeds operation limit, shouldn't be substituted
    complex_expr = 32'h1 + 32'h2 + 32'h3 + 32'h4 + 32'h5 + 32'h6 + 32'h7 + 32'h8 +
                  32'h9 + 32'hA + 32'hB + 32'hC + 32'hD + 32'hE + 32'hF + 32'h10 +
                  32'h11 + 32'h12 + 32'h13 + 32'h14 + 32'h15 + 32'h16 + 32'h17 + 32'h18 +
                  32'h19 + 32'h1A + 32'h1B + 32'h1C + 32'h1D + 32'h1E + 32'h1F + 32'h20;
    
    wide_var[95:64] = complex_expr;
    
    // Variable changes after assignment - shouldn't be substituted
    wide_temp[127:96] = 32'hAAAAAAAA;
    wide_var[127:96] = wide_temp[127:96];
    wide_temp[127:96] = 32'hBBBBBBBB;  // Changes value after use
    
    // Multiple assignments to same variable
    wide_temp[31:0] = 32'h44444444;   // Reassign - should mark as complex
    wide_var[31:0] = wide_temp[31:0];  // This shouldn't be substituted
    
    // Test cast handling with quad to non-quad
    simple_temp = 32'hCAFEBABE;
    simple_var = simple_temp[31:0];
    
    // Test array-style access with WordSel
    for (int i = 0; i < 4; i++) begin
      wide_temp[i*32+:32] = i * 32'h01010101;
      wide_result[i*32+:32] = wide_temp[i*32+:32]; // Variable index - won't substitute
    end
    
    // Read-Write-Read pattern to exercise consumeWord/consumeWhole
    wide_temp[31:0] = 32'hAAAA5555;
    wide_var = wide_temp;
    wide_temp[31:0] = 32'h12345678;
    simple_result = wide_var[31:0];
    
    // Call function to test function-local substitutions
    test_function();
    
    // Display results to prevent optimization
    $display("wide_var = 0x%032x", wide_var);
    $display("wide_result = 0x%032x", wide_result);
    $display("simple_var = 0x%08x", simple_var);
    $display("simple_result = 0x%08x", simple_result);
  end
endmodule
