module assertion_test (
    input wire clk,
    input wire rst_n,
    input wire [3:0] data_in,
    output reg [3:0] data_out
);

    // Register for sequential logic
    reg [3:0] counter;
    reg [3:0] prev_data;
    
    // Basic sequential logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 4'b0000;
            prev_data <= 4'b0000;
            data_out <= 4'b0000;
        end else begin
            counter <= counter + 1'b1;
            prev_data <= data_in;
            data_out <= data_in;
        end
    end

    // Immediate assertions
    always @(posedge clk) begin
        // Immediate assertion
        assert (data_in < 4'b1111) else $display("Data input should be less than 15");
        
        // Immediate assertion with custom message
        assert (counter < 4'b1111) 
            else $error("Counter overflow detected: %d", counter);
    end

    // Concurrent assertions - modified to work with Verilator
    // Replace sequence operator with a simpler property
    assert property (@(posedge clk) !rst_n |-> counter == 4'b0000);
    
    // Cover properties to track interesting conditions
    cover property (@(posedge clk) data_in == 4'b1010);
    cover property (@(posedge clk) counter == 4'b1000);
    
    // Using $past for temporal properties - simplified for Verilator
    reg [3:0] data_in_prev;
    always @(posedge clk) begin
        data_in_prev <= data_in;
        assert (data_in_prev == prev_data) 
            else $display("Data tracking mismatch");
    end
    
    // Test case statements with pragmas
    always @(*) begin
        // unique case ensures exactly one case item matches
        unique case (data_in[1:0])
            2'b00: $display("Case 00");
            2'b01: $display("Case 01");
            2'b10: $display("Case 10");
            2'b11: $display("Case 11");
        endcase
        
        // unique0 case allows no matches
        unique0 case (data_in)
            4'b0000: $display("Data is 0");
            4'b0001: $display("Data is 1");
            4'b0010: $display("Data is 2");
            4'b0100: $display("Data is 4");
            4'b1000: $display("Data is 8");
            default: $display("Other data value");
        endcase
        
        // priority case ensures higher items have priority
        priority case (1'b1)
            data_in[3]: $display("Bit 3 is set");
            data_in[2]: $display("Bit 2 is set");
            data_in[1]: $display("Bit 1 is set"); 
            data_in[0]: $display("Bit 0 is set");
            default: $display("No bits are set");
        endcase
        
        // full case ensures all possible inputs are covered
        case (data_in)
            // synthesis full_case
            4'b0000: $display("Zero");
            4'b0001: $display("One");
            4'b0010: $display("Two");
            4'b0011: $display("Three");
            default: $display("Other value");
        endcase
        
        // parallel case ensures non-overlapping case items
        casez (data_in)
            // synthesis parallel_case
            4'b1???: $display("First bit set");
            4'b01??: $display("Second bit set");
            4'b001?: $display("Third bit set");
            4'b0001: $display("Fourth bit set");
            default: $display("No bits set");
        endcase
    end
    
    // Using different display types
    initial begin
        $display("Normal display message");
        $info("Info message");
        $warning("Warning message");
        $error("Error message (just for testing)");
        // Not using $fatal to avoid terminating simulation
    end
    
    // Using $monitor and $strobe
    initial begin
        $monitor("Monitoring: data_in=%h, counter=%h", data_in, counter);
        $strobe("Strobed values: data_in=%h, counter=%h", data_in, counter);
        #10 $monitoroff;
        #20 $monitoron;
    end
    
    // Using sampled expressions - modified for Verilator compatibility
    reg [3:0] data_in_sampled;
    always @(posedge clk) begin
        data_in_sampled <= data_in;
        if (data_in_sampled != data_in) begin
            $display("Data changed during this cycle");
        end
    end
    
    // Using assertcontrol - simplified for Verilator
    initial begin
        // Alternative to $assertcontrol which may not be fully supported
        $display("Assertions would be controlled here");
        #10;
        $display("Assertions would be enabled here");
    end
    
    // Assume (used in formal verification) - modified for Verilator
    always @(posedge clk) begin
        assert (data_in <= 4'b1110);  // Use assert as assume might not be supported
    end
    
    // Restrict (used in formal verification)
    restrict property (@(posedge clk) counter <= 4'b1110);

endmodule