module test_assertions;
  logic clk;
  logic rst;
  logic a, b, c;
  logic out1, out2;
  reg a_prev, b_prev, c_prev;
  always @(posedge clk) begin
    a_prev <= a;
    b_prev <= b;
    c_prev <= c;
  end
  default clocking cb @(posedge clk);
    input a, b;
    inout out1;
    output out2;
  endclocking
  default disable iff (rst);
  property p1;
    a |-> b;
  endproperty
  property p2(x, y);
    x |-> y;
  endproperty
  assert property (p1);
  assert property (p2(a, b));
  assert property (disable iff(c) a |-> b);
  assert property (@(posedge clk) (a && !a_prev));
  assert property (@(posedge clk) (!b && b_prev));
  assert property (@(posedge clk) (c == c_prev));
  assert property (@(posedge clk) a_prev);
  cover property (@(posedge clk) a |-> b);
  always @(posedge clk) begin
    cb.out1 <= a & b;
    cb.out2 <= a | b;
  end
  always @(posedge clk) begin
    if (cb.out1) a <= 1'b0;
  end
  reg delay_reg;
  always @(posedge clk) begin
    delay_reg <= b;
    a <= delay_reg;
  end
endmodule
