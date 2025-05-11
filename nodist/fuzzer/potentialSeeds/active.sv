module active (
    input wire clk,
    input wire rst_n,
    input wire [7:0] data_in,
    input wire enable,
    input wire select,
    output reg [7:0] data_out,
    output reg [7:0] latch_out,
    output reg [7:0] comb_out,
    output reg valid
);

    // Wire assignment - will be moved to SACTIVE(combo)
    wire [7:0] intermediate = data_in & {8{enable}};
    
    // Initial block - will be moved to IACTIVE
    initial begin
        data_out = 8'h00;
        valid = 1'b0;
        latch_out = 8'h00;
    end
    
    // Final block
    final begin
        $display("Simulation finished with data_out = %h", data_out);
    end
    
    // Sequential always block - will be processed as clocked
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_out <= 8'h00;
            valid <= 1'b0;
        end else if (enable) begin
            data_out <= data_in;
            valid <= 1'b1;
            // This will trigger BLKSEQ warning
            comb_out = data_in + 8'h01;
        end else begin
            valid <= 1'b0;
        end
    end
    
    // Combinational always block - will be recognized as combo
    always @* begin
        comb_out = data_in + 8'h01;
    end
    
    // Latch behavior - will trigger latch detection
    always @(enable or data_in) begin
        if (enable) begin
            latch_out = data_in;
        end else begin
        // Add explicit else path to avoid latch
        latch_out = latch_out; // Or specify a default value like 8'h00
        end
        // No else path creates a latch
    end
    
    // Always latch - expected latch behavior
    always_latch begin
        if (select) begin
            latch_out = data_in ^ 8'hFF;
        end
    end

endmodule