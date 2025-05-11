module tns;
  //ls
  logic clk;
  logic rst;
  logic a, b, c;
  logic out1, out2;
  
  // Foons
  reg a_prev, b_prev, c_prev;
  
  // Re
  always @(posedge clk) begin
    a_prev <=b_prev < c_prev ;
  end
 // es
  default clocking cb @(posedge clk); input a, b; // ue
    inout out1;     // Re
    output out2;    // ue
  endclocking  //on
  property p1;
  b;
  endproperty  //y)
  always @(posedge clk) begin cb.out1 <= b;
    cb.out2 <= a | b;
  end
 // Nout
  always @(posedge clk) begin
    if (cb.out1) a <= 1'b0;
  end
 // gic
  reg delay_reg;
  always @(clk) begin
    delay_reg <=    a <= delay_reg;  // Eay
  end
endmodule