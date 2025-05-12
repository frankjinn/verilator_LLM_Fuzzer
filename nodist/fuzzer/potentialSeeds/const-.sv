module const_test;
  parameter WIDTH = 8;
  parameter CONST1 = 8'hFF;
  parameter CONST2 = 8'h0F;
  parameter ZERO = 8'h00;
  parameter ONE = 8'h01;
  logic [WIDTH-1:0] a, b, c, d, result;
  logic [WIDTH-1:0] temp1, temp2;
  logic condition, condition2, condition3;
  logic [7:0] mem[0:3];
  initial begin
    a = CONST1;
    b = CONST2;
    c = 8'h33;
    d = 8'h77;
    result = CONST1 + CONST2;
    result = CONST1 - CONST2;
    result = CONST1 * CONST2;
    result = CONST1 / CONST2;
    result = CONST1 % CONST2;
    result = a & ZERO;
    result = a | ZERO;
    result = a ^ ZERO;
    result = a & CONST1;
    result = a | CONST1;
    result = a & a;
    result = a | a;
    result = a ^ a;
    result = (a & b) | (a & c);
    result = (a | b) & (a | c);
    result = (a & b) | (a & ~b);
    result = a & (b | ~b);
    result = a | (b & ~b);
    condition = &a;
    condition = |a;
    condition = ^a;
    condition = ~^a;
    condition = &(a & b);
    condition = |(a | b);
    condition = ^(a ^ b);
    condition = &{a, b};
    condition = |{a, b};
    condition = ^{a, b};
    condition = |8'h00;
    condition = &8'hFF;
    condition = ^8'h55;
    result = a / 2;
    result = a * 16;
    result = a % 4;
    result = 2 ** 3;
    result = 2 ** b[2:0];
    condition = 1 < a;
    condition = a > 1;
    condition = a <= CONST1;
    condition = a >= 0;
    condition = 1'b1 ? condition : condition2;
    condition = condition ? 1'b1 : 1'b0;
    condition = !condition ? 1'b0 : 1'b1;
    condition = 1'b0 && a[0];
    condition = 1'b1 || a[0];
    condition = a[0] && a[0];
    condition = a[0] || a[0];
    condition = (a[0]) ? 1'b1 : 1'b0;
    result = condition ? (condition2 ? a : b) : b;
    result = condition ? a : (condition2 ? a : b);
    condition = (a[0] === b[0]);
    condition = a[0] -> b[0];
    result = {{2{a[7]}}, a[7:2]};
    result = ~(~a);
    condition = !(!(a[0]));
    condition = !(a == b);
    condition = !(a < b);
    condition = !(a <= b);
    result = a[7:0];
    result = a & 8'h0F;
    result = (a << 4) & 8'hF0;
    result = (a & 8'h0F) | (b & 8'hF0);
    result = (a & b) & c;
    result = (a | b) | c;
    result = a * 1;
    result = a / 1;
    result = (a << 2) >> 2;
  end
  always @(*) begin
    if (a == 0)
      result = b;
    else if (a == CONST1)
      result = c;
    else
      result = d;
    case (a)
      ZERO: result = b;
      ONE: result = c;
      default: result = d;
    endcase
    if ((a & CONST2) != 0) begin
      if ((b | CONST2) == CONST2)
        result = c;
      else
        result = d;
    end
    result[0] = 1'b0;
    result[7] = 1'b1;
    result[6:4] = a[2:0];
  end
  function [WIDTH-1:0] fold_test(input [WIDTH-1:0] x, y);
    return (x + y) * (x - y);
  endfunction
  initial begin
    result = fold_test(CONST1, CONST2);
    result = fold_test(8'h55, 8'hAA) & CONST1;
    result = (a & b) & c;
    result = (a | b) | c;
    $display("Folded: %h", CONST1 | CONST2);
    $display("Concat: %h", {CONST1[3:0], CONST2[3:0]});
  end
  initial begin
    result = 8'hAA & 8'h55;
    result = 8'hCC | 8'h33;
    result = 8'hF0 ^ 8'h0F;
    result = (CONST1 & CONST2) | ((~CONST1) & CONST2);
    mem[0] = 8'h11;
    mem[1] = 8'h22;
    mem[2] = 8'h33;
    mem[3] = 8'h44;
    result = mem[2];
    result = a >> 8;
    result = 8'h12 >>> 2;
    result = a << (WIDTH-4);
    $display("Start of test");
    $display("Folded: 0x%h", CONST1 | CONST2);
    $display("End of test");
  end
endmodule
