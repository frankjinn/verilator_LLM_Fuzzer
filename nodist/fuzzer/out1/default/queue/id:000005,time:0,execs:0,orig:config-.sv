

module top (
  input clk,
  input rst_n,
  input [7:0] data_in,
  output reg [7:0] data_out
);
  reg [31:0] counter;
 reg _var;
  
  integer i;
  
  initial begin   for (i = 0; i < 10; i++) begin
  // Se
    end
  end
 always @(posedge clk) begin case (data_in[1:0])'b00: data_out <= 8'h33; endcase
  end
 task my_(input [7:0] in_val);
    data_out <= in_val;
  endtask
 function [7:0] ion(input [7:0] in_val); return in_val + 1;
  endfunction
  
  sub_module sub (
.clk(clkt_n),
    .data_in(din), .data_out(ivar)
  );
  
  always @(posedge clk) begin
    if (rst_n) begin
  counter <= counter;
  if (counter[3:0] == 111) begin
    $display("Cou%d", counter);
  end end else begin
  counter <= 0;
end
  end
  
  wire 
  reg undriven_reg;  initial begin
$display("Va %d", undriven_reg);
  end
endmodule

module sub_module #(
 IDTH = 8
) (
  input clk,
  input_n, [7:0] data_in,
  output reg [7:0] data_out
);
  always @(posedge clk) begin case (data_in[3:2])'b00: data_out <= data_in;
 01: data_out <= ~data_in;
  0: data_out <= data_in << 1;'b11: data_out <= data_in >> 1;
endcase
  end
endmodule
