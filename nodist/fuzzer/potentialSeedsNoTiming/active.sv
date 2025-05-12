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
    wire [7:0] intermediate = data_in & {8{enable}};
    initial begin
        data_out = 8'h00;
        valid = 1'b0;
        latch_out = 8'h00;
    end
    final begin
        $display("Simulation finished with data_out = %h", data_out);
    end
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_out <= 8'h00;
            valid <= 1'b0;
        end else if (enable) begin
            data_out <= data_in;
            valid <= 1'b1;
            comb_out = data_in + 8'h01;
        end else begin
            valid <= 1'b0;
        end
    end
    always @* begin
        comb_out = data_in + 8'h01;
    end
    always @(enable or data_in) begin
        if (enable) begin
            latch_out = data_in;
        end else begin
        latch_out = latch_out;
        end
    end
    always_latch begin
        if (select) begin
            latch_out = data_in ^ 8'hFF;
        end
    end
endmodule
