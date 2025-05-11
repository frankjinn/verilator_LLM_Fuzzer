module const_test;
  
  // For parameter optimization
  parameter WIDTH = 8;
  parameter CONST1 = 8'hFF;
  parameter CONST2 = 8'h0F;
  parameter ZERO = 8'h00;
  parameter ONE = 8'h01;
  
  // Wires for testing
  logic [WIDTH-1:0] a, b, c, d, result;
  logic [WIDTH-1:0] temp1, temp2;
  logic condition, condition2, condition3;
  // Array definition moved here from initial block
  logic [7:0] mem[0:3];

  // Test assignments
  initial begin
    // Basic constant operations
    a = CONST1;
    b = CONST2;
    c = 8'h33;
    d = 8'h77;
    
    // Constant folding
    result = CONST1 + CONST2;      // Should fold to 0xFF + 0x0F = 0x10E (truncated to 0x0E)
    result = CONST1 - CONST2;      // Should fold to 0xFF - 0x0F = 0xF0
    result = CONST1 * CONST2;      // Should fold to 0xFF * 0x0F = 0xEF1
    result = CONST1 / CONST2;      // Should fold to 0xFF / 0x0F = 0x11
    result = CONST1 % CONST2;      // Should fold to 0xFF % 0x0F = 0x00
    
    // Logical operations with constants
    result = a & ZERO;             // Should optimize to 0
    result = a | ZERO;             // Should optimize to a
    result = a ^ ZERO;             // Should optimize to a
    result = a & CONST1;           // Should optimize to a
    result = a | CONST1;           // Should optimize to all ones
    result = a & a;                // Should optimize to a
    result = a | a;                // Should optimize to a
    result = a ^ a;                // Should optimize to 0
    
    // Additional logical optimizations
    result = (a & b) | (a & c);    // Should optimize to a & (b | c)
    result = (a | b) & (a | c);    // Should optimize to a | (b & c)
    result = (a & b) | (a & ~b);   // Should optimize to a
    result = a & (b | ~b);         // Should optimize to a
    result = a | (b & ~b);         // Should optimize to a
    
    // Reduction operators
    condition = &a;                // Reduction AND
    condition = |a;                // Reduction OR
    condition = ^a;                // Reduction XOR
    condition = ~^a;               // Reduction XNOR
    condition = &(a & b);          // Combinations
    condition = |(a | b);
    condition = ^(a ^ b);
    
    // Complex reduction with concatenation
    condition = &{a, b};           // Should optimize to &a && &b
    condition = |{a, b};           // Should optimize to |a || |b
    condition = ^{a, b};           // Should optimize to ^a ^ ^b
    
    // Test bit reductions with constants
    condition = |8'h00;            // Should fold to 0
    condition = &8'hFF;            // Should fold to 1
    condition = ^8'h55;            // Should fold to 0
    
    // Additional constant patterns
    result = a / 2;                // Should optimize to a >> 1
    result = a * 16;               // Should optimize to a << 4
    result = a % 4;                // Should optimize to a & 3
    
    // Power operations
    result = 2 ** 3;               // Should fold to 8
    result = 2 ** b[2:0];          // Should optimize to 1 << b
    
    // Additional comparison operations
    condition = 1 < a;             // Various comparisons
    condition = a > 1;
    condition = a <= CONST1;
    condition = a >= 0;
    
    // Boolean logic optimizations
    condition = 1'b1 ? condition : condition2;  // Should optimize to condition
    condition = condition ? 1'b1 : 1'b0;        // Should optimize to condition
    condition = !condition ? 1'b0 : 1'b1;       // Should optimize to condition
    
    // Short-circuit logic patterns
    condition = 1'b0 && a[0];      // Should optimize to 0
    condition = 1'b1 || a[0];      // Should optimize to 1
    condition = a[0] && a[0];      // Should optimize to a[0]
    condition = a[0] || a[0];      // Should optimize to a[0]
    
    // Logical If/Else patterns
    condition = (a[0]) ? 1'b1 : 1'b0;  // Should optimize to a[0]
    
    // Advanced conditional expressions
    result = condition ? (condition2 ? a : b) : b;  // Should optimize
    result = condition ? a : (condition2 ? a : b);  // Should optimize
    
    // Testing LogEq/LogIf optimization
    condition = (a[0] === b[0]);   // Logical equality
    condition = a[0] -> b[0];      // Logical implication
    
    // Complex width handling
    result = {{2{a[7]}}, a[7:2]};  // Sign extension with replication
    
    // Double negation elimination
    result = ~(~a);                // Should optimize to a
    condition = !(!(a[0]));        // Should optimize to a[0]
    
    // NOT of comparison operations
    condition = !(a == b);         // Should optimize to a != b
    condition = !(a < b);          // Should optimize to a >= b
    condition = !(a <= b);         // Should optimize to a > b
    
    // Bit selection operations
    result = a[7:0];               // Should optimize away - full select
    
    // Masked operations 
    result = a & 8'h0F;            // Keep low nibble
    result = (a << 4) & 8'hF0;     // Keep high nibble after shift
    
    // Additional bit manipulation
    result = (a & 8'h0F) | (b & 8'hF0);  // Combine lower bits of a with upper bits of b
    
    // Multi-level operations that can be simplified
    result = (a & b) & c;          // Should simplify to a & b & c
    result = (a | b) | c;          // Should simplify to a | b | c
    
    // Operations with identity constants
    result = a * 1;                // Should optimize to a
    result = a / 1;                // Should optimize to a
    
    // Shift optimizations
    result = (a << 2) >> 2;        // Should optimize (possibly with masking)
  end
  
  // Operations inside always block
  always @(*) begin
    if (a == 0)
      result = b;
    else if (a == CONST1)
      result = c;
    else
      result = d;
      
    // More comparisons and optimizations
    case (a)
      ZERO: result = b;
      ONE: result = c;
      default: result = d;
    endcase
    
    // Nested logic for complex optimizations
    if ((a & CONST2) != 0) begin
      if ((b | CONST2) == CONST2)
        result = c;
      else
        result = d;
    end
    
    // Bit manipulation
    result[0] = 1'b0;              // Clear bit
    result[7] = 1'b1;              // Set bit
    result[6:4] = a[2:0];          // Bit movement
  end
  
  // Function for constant folding
  function [WIDTH-1:0] fold_test(input [WIDTH-1:0] x, y);
    return (x + y) * (x - y);      // Should fold with constant inputs
  endfunction
  
  initial begin
    // Test function with constants
    result = fold_test(CONST1, CONST2);
    
    // Test bit operations with function result
    result = fold_test(8'h55, 8'hAA) & CONST1;
    
    // Test more optimization patterns
    result = (a & b) & c;        // Should optimize to a & (b & c)
    result = (a | b) | c;        // Should optimize to a | (b | c)
    
    // Display constants after folding
    $display("Folded: %h", CONST1 | CONST2);
    $display("Concat: %h", {CONST1[3:0], CONST2[3:0]});
  end
  
  // Test complex constant calculations
  initial begin
    // Bitwise operations with constants
    result = 8'hAA & 8'h55;        // Should fold to 0
    result = 8'hCC | 8'h33;        // Should fold to 0xFF
    result = 8'hF0 ^ 8'h0F;        // Should fold to 0xFF
    
    // Complex constant expressions
    result = (CONST1 & CONST2) | ((~CONST1) & CONST2);  // Should fold
    
    // Test constant arrays and selects
    mem[0] = 8'h11;
    mem[1] = 8'h22;
    mem[2] = 8'h33;
    mem[3] = 8'h44;
    result = mem[2];  // Should optimize 
    
    // Test for various edge cases
    result = a >> 8;               // Shift beyond width
    result = 8'h12 >>> 2;          // Arithmetic right shift
    
    // Test with parameter expressions
    result = a << (WIDTH-4);       // Parameterized shift amount
    
    // Display for validation 
    $display("Start of test");
    $display("Folded: 0x%h", CONST1 | CONST2);
    $display("End of test");
  end
endmodule
