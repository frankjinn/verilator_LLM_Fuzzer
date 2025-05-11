/* verilator lint_off SELRANGE */
/* verilator lint_off CASEWITHX */
/* verilator lint_off CASEX */
/* verilator lint_off LATCH */

module unknown_test;
    // Variables to test constants with X values
    reg [4:0] x_const;
    reg [7:0] x_const2;
    
    // For testing array bounds checking
    reg [7:0] my_array [0:9];
    reg [3:0] my_array2d [0:3][0:3];
    reg [3:0] index;
    reg [3:0] index2;
    
    // For string bounds checking
    string str;
    
    // Variables for testing X-related operators
    reg [3:0] a, b;
    reg result;
    
    initial begin
        // Constants with X assignments - tests UnknownVisitor AstConst handling
        x_const = 5'b1xxxx;
        x_const2 = 8'bxxxx_xxxx;
        
        // Test array selection with bounds checking - tests AstArraySel
        index = 15; // Out of bounds
        my_array[index] = 8'h42;  // Tests lvalue bounds checking
        my_array[3] = my_array[index];  // Tests rvalue bounds checking
        
        // Test multi-dimensional arrays
        index = 2;
        index2 = 5; // Out of bounds for second dimension
        my_array2d[index][index2] = 4'hA;
        
        // Test bit selection bounds - tests AstSel
        a = 4'b1010;
        a[5] = 1'b1; // Out of bounds bit select
        a[index] = 1'b0; // Variable bit select potentially out of bounds
        
        // Test X-equality operations - tests visitEqNeqCase and visitEqNeqWild
        a = 4'b10x0;
        b = 4'b10x0;
        result = (a == b);      // Regular equality with X
        result = (a === b);     // Case equality
        result = (a ==? 4'b10x0); // Wildcard equality
        result = (a !=? 4'b1xx0); // Wildcard inequality
        
        // Test case statements with X values
        case (a)
            4'b10x0: $display("Case equality match");
            default: $display("No match");
        endcase
        
        casez (a)  // Changed from casex to casez as recommended
            4'b10?0: $display("Casez match");
            default: $display("No casez match");
        endcase
        
        // Test isunknown - tests visit(AstIsUnknown)
        if ($isunknown(a)) $display("A is unknown");
        
        // Test $countbits with different X combinations - tests visit(AstCountBits)
        $display("Count of 1s: %d", $countbits(a, 1'b1, 1'b0, 1'bx));
        $display("Count of Xs: %d", $countbits(a, 1'bx, 1'bx, 1'bx));
        $display("Count of mix: %d", $countbits(a, 1'b1, 1'bx, 1'b0));
        
        // String handling with bounds checking
        str = "test";
        if (index > 3) str = str[15]; // Out of bounds
    end
    
    // Continuous assignments with X constants
    wire [4:0] w_xconst = 5'bx_1_x;
    wire [7:0] w_array_value = my_array[index]; // Potentially out of bounds
    
    // Delayed assignments with bounds checking
    always @(posedge result) begin
        #5 a[index] <= 1'b1; // Tests replaceBoundLvalue with delayed assignment
        #10 my_array[index] <= 8'hFF; // More bounds checking
    end
    
    // Multiple sequential out-of-bounds on same base - tests the LogAnd optimization
    always_comb begin  // Changed from always @* to always_comb
        if (index > 0) begin
            my_array[20] = 8'hFF;  // First out of bounds check
            my_array[21] = 8'hEE;  // Second out of bounds check, should be optimized
        end else begin
            // Add else clause to avoid latch warning
            my_array[0] = 8'h00;
        end
    end
    
    // ModDiv operations - tests early return optimization in visit(AstArraySel)
    reg [7:0] mod_idx;
    always_comb begin  // Changed from always @* to always_comb
        mod_idx = index % 8; // Should hit the ModDiv constant optimize case
        my_array[mod_idx] = 8'h42;
        my_array[index % 15] = 8'h24; // May not hit the optimize case
    end
    
    // Test parameters with X values
    parameter P_WITH_X = 8'b1010_1x1x;
    localparam LP_WITH_X = 4'bx1x0;
    
endmodule

// Add a class to test handling of X values in classes (affects m_allowXUnique)
class XTest;
    bit [3:0] x_val = 4'bx1x0;
endclass
