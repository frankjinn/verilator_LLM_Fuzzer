module subst_test;
  logic [127:0] wide_var;
  logic [127:0] wide_temp;
  logic [127:0] wide_result;
  logic [31:0] simple_var;
  logic [31:0] simple_temp;
  logic [31:0] simple_result;
  logic [31:0] complex_expr;
  function automatic logic [31:0] pure_function(logic [31:0] a);
    return a + 32'h1234;
  endfunction
  function void test_function();
    logic [127:0] func_wide;
    logic [31:0] func_temp;
    logic [31:0] index;
    index = 0;
    func_wide[31:0] = 32'hABCDEF01;
    func_wide[63:32] = 32'h23456789;
    func_temp = func_wide[index+:32];
    if (func_temp == 32'hABCDEF01) begin
      func_wide[95:64] = 32'h12345678;
    end else begin
      func_wide[95:64] = 32'h87654321;
    end
    func_temp = pure_function(32'h5555);
    func_wide[127:96] = func_temp;
  endfunction
  initial begin
    simple_temp = 32'hDEADBEEF;
    simple_var = simple_temp;
    wide_temp[31:0] = 32'h12345678;
    wide_temp[63:32] = 32'h9ABCDEF0;
    wide_temp[95:64] = 32'h13579BDF;
    wide_temp[127:96] = 32'h2468ACE0;
    wide_var[31:0] = wide_temp[31:0];
    wide_var[63:32] = wide_temp[63:32];
    complex_expr = 32'h1 + 32'h2 + 32'h3 + 32'h4 + 32'h5 + 32'h6 + 32'h7 + 32'h8 +
                  32'h9 + 32'hA + 32'hB + 32'hC + 32'hD + 32'hE + 32'hF + 32'h10 +
                  32'h11 + 32'h12 + 32'h13 + 32'h14 + 32'h15 + 32'h16 + 32'h17 + 32'h18 +
                  32'h19 + 32'h1A + 32'h1B + 32'h1C + 32'h1D + 32'h1E + 32'h1F + 32'h20;
    wide_var[95:64] = complex_expr;
    wide_temp[127:96] = 32'hAAAAAAAA;
    wide_var[127:96] = wide_temp[127:96];
    wide_temp[127:96] = 32'hBBBBBBBB;
    wide_temp[31:0] = 32'h44444444;
    wide_var[31:0] = wide_temp[31:0];
    simple_temp = 32'hCAFEBABE;
    simple_var = simple_temp[31:0];
    for (int i = 0; i < 4; i++) begin
      wide_temp[i*32+:32] = i * 32'h01010101;
      wide_result[i*32+:32] = wide_temp[i*32+:32];
    end
    wide_temp[31:0] = 32'hAAAA5555;
    wide_var = wide_temp;
    wide_temp[31:0] = 32'h12345678;
    simple_result = wide_var[31:0];
    test_function();
    $display("wide_var = 0x%032x", wide_var);
    $display("wide_result = 0x%032x", wide_result);
    $display("simple_var = 0x%08x", simple_var);
    $display("simple_result = 0x%08x", simple_result);
  end
endmodule
