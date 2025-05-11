

module top (
  input clk,
  input rst_n,
  input [7:0] data_in,
  output reg [7:0] data_out
);
  reg [31:0] counter;
  
  reg [7:0] isolated_var;
  
  reg [15:0] public_var;
  
  reg [3:0] force_var;
  
  integer i;
  
  initial begin: named_block_for_coverage
    for (i = 0; i < 10; i++) begin
      // Some code that might be excluded from coverage
    end
  end
  
  always @(posedge clk) begin
    case (data_in[1:0])
      2'b00: data_out <= 8'h00;
      2'b01: data_out <= 8'h11;
      2'b10: data_out <= 8'h22;
      2'b11: data_out <= 8'h33;
    endcase
  end
  
  task my_task(input [7:0] in_val);
    data_out <= in_val;
  endtask
  
  function [7:0] my_function(input [7:0] in_val);
    return in_val + 1;
  endfunction
  
  sub_module sub (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data_in),
    .data_out(isolated_var)
  );
  
  always @(posedge clk) begin
    if (rst_n) begin
      counter <= counter + 1;
      if (counter[3:0] == 4'b1111) begin
        $display("Counter at %d", counter);
      end
    end else begin
      counter <= 0;
    end
  end
  
  wire unused_wire;
  reg undriven_reg;
  
  initial begin
    $display("Value: %d", undriven_reg);
  end
endmodule

module sub_module #(
  parameter WIDTH = 8
) (
  input clk,
  input rst_n,
  input [7:0] data_in,
  output reg [7:0] data_out
);
  always @(posedge clk) begin
    case (data_in[3:2])
      2'b00: data_out <= data_in;
      2'b01: data_out <= ~data_in;
      2'b10: data_out <= data_in << 1;
      2'b11: data_out <= data_in >> 1;
    endcase
  end
endmodule
