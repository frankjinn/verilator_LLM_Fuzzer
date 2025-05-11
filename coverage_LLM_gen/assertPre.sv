module test_assertions;
  // Basic signals
  logic clk;
  logic rst;
  logic a, b, c;
  logic out1, out2;
  
  // For simulating temporal functions
  reg a_prev, b_prev, c_prev;
  
  // Register previous values (mimicking $past, rose, fell, stable)
  always @(posedge clk) begin
    a_prev <= a;
    b_prev <= b;
    c_prev <= c;
  end
  
  // Default clocking block without skew values
  default clocking cb @(posedge clk);
    input a, b;         // Removed skew value
    inout out1;         // Removed skew value
    output out2;        // Removed skew value
  endclocking
  
  // Default disable for assertions
  default disable iff (rst);
  
  // Property definition to test property substitution
  property p1;
    a |-> b;
  endproperty
  
  // Property with arguments to test argument substitution
  property p2(x, y);
    x |-> y;
  endproperty
  
  // Basic assertions to exercise different code paths
  assert property (p1);                         // Basic property reference
  assert property (p2(a, b));                   // Property with arguments
  assert property (disable iff(c) a |-> b);     // Explicit disable
  
  // Manually implement temporal operators
  // Replace rose(a) with (a && !a_prev)
  assert property (@(posedge clk) (a && !a_prev));
  
  // Replace fell(b) with (!b && b_prev)
  assert property (@(posedge clk) (!b && b_prev));
  
  // Replace stable(c) with (c == c_prev)
  assert property (@(posedge clk) (c == c_prev));
  
  // Replace past(a) with a_prev
  assert property (@(posedge clk) a_prev);
  
  // Cover statement to test different assertion type
  cover property (@(posedge clk) a |-> b);
  
  // Test synchronous drive with clockvar (creates AstAssignDly)
  always @(posedge clk) begin
    cb.out1 <= a & b;
    cb.out2 <= a | b;
  end
  
  // Now legal since out1 is an inout
  always @(posedge clk) begin
    if (cb.out1) a <= 1'b0;
  end
  
  // Replace cycle delay in assignment with sequential logic
  reg delay_reg;
  always @(posedge clk) begin
    delay_reg <= b;
    a <= delay_reg;  // Effectively a 2-cycle delay
  end
endmodule