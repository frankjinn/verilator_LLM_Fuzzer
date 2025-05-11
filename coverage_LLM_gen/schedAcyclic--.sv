/* verilator lint_off ALWCOMBORDER */
module schedAcyclic;
    // Single-bit signals that will form simple loops
    logic a, b, c, d, e, f;
    
    // Multi-bit signals - candidates for splitting
    logic [31:0] wide_bus;
    logic [15:0] medium_bus;
    logic [7:0] narrow_bus;
    
    // Simple 2-signal combinational loop
    always_comb begin
        a = b;
        b = a;
    end
    
    // Three-signal combinational loop
    always_comb begin
        c = d;
        d = e;
        e = c;
    end
    
    // Loop involving multi-bit signals
    always_comb begin
        wide_bus = {medium_bus, medium_bus};
        medium_bus = narrow_bus * 2;
        narrow_bus = wide_bus[7:0];
    end
    
    // Complex loop with high fanout variable (f)
    always_comb begin
        f = a ^ b ^ c;
    end
    
    // Additional blocks reading from f to create high fanout
    always_comb begin
        wide_bus[8] = f;
    end
    
    always_comb begin
        wide_bus[9] = f;
    end
    
    always_comb begin
        wide_bus[10] = f;
    end
    
    // Nested loop structure with 4-bit signals
    logic [3:0] nested1, nested2, nested3, nested4;
    
    always_comb begin
        nested1 = nested2 + 1;
        nested2 = nested3 - 1;
        nested3 = nested4 + 2;
        nested4 = nested1 - 2;
    end
    
    // Loop with conditional logic
    logic cond_a, cond_b, cond_c;
    
    always_comb begin
        cond_a = cond_b & cond_c;
        cond_b = cond_c ? cond_a : 0;
        cond_c = cond_a | cond_b;
    end

    // Add some initial values to prevent X-propagation
    initial begin
        a = 0; b = 1;
        c = 0; d = 1; e = 0;
        wide_bus = 0; medium_bus = 1; narrow_bus = 2;
        nested1 = 0; nested2 = 1; nested3 = 2; nested4 = 3;
        cond_a = 0; cond_b = 1; cond_c = 0;
    end
endmodule
/* verilator lint_on ALWCOMBORDER */
