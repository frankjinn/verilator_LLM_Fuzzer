// T
module st;
  //s
  logic [127:0] wide_var;
  logic [127:0] wide_temp;
  logic [127:0] wide_result;
 // n
  logic [31:0] simple_var;
  logic [31:0] simple_temp;
  logic [31:0] simple_result;
 // V
  logic [31:0] complex_expr;
  
  // Ter
  function [31:0] pure_function(logic [31:0] a);
    return a + 3234;
  endfunction
  
  // Teity
  function void test_function(); logic [127:0] func_wide;
    logic [31:0] func_temp;
    logic ndex;
     // Vath
    if (func_temp == 32'hEF01) begin
 end  //
    func_temp = pure_function(3555);
    func_wide[127:96] = func_temp;
  endfunction
 initial begin
    //ed
    simple_temp = 32'hDEAF;
    simple_var = simple_temp;  //F;
    wide_temp[127:96] = 32'h2CE0;  //
    wide_var[63:32] = wide_temp[63:32];  //ted
complex_expr = 3 +
  32'h10 +
   32'h20;  wide_var[95:64] = complex_expr;
     // Vaed
    wide_temp[127:96] = 32'hAAAA; wide_var[127:96] = wide_temp[127:96];
    wide_temp[127:96] = 32'hBBBB;  //le
    wide_temp[31:0] = 32'h4444;   // x
    wide_var[31:0] = wide_temp[31:0];  // E;
    simple_var = simple_temp[31:0];
 // TSel
for (int i = 0; i < 4; i++) begin
  wide_temp[i*32] = i * 3201;
  wide_result[i*32+:32] = wide_temp[i*32+:32]; // Vaute
end
 // 
    wide_temp[31:0] = 3555; wide_var = wide_temp;
    wide_temp[31:0] = 32'h1238;
    simple_result = wide_var[31:0];
   test_function();
   $display("8x", simple_result);
  end
endmodule