interface simple_if;
  logic clk;
  modport mp(input clk);
endinterface
package pkg;
  typedef enum {RED, GREEN, BLUE} color_t;
endpackage
class BaseClass;
  int x;
  function new(int val=0); x=val; endfunction
  virtual function void display(); $display("Base x=%0d", x); endfunction
endclass
class DerivedClass extends BaseClass;
  int y;
  function new(int val_x=0, int val_y=0);
    super.new(val_x);
    y = val_y;
  endfunction
endclass
typedef struct packed {
  logic [7:0] r, g, b;
} rgb_t;
module top(input clk, input [7:0] in, output reg [7:0] out);
  import pkg::*;
  parameter WIDTH = 8;
  localparam DEPTH = 4;
  simple_if intf();
  logic [WIDTH-1:0] logic_var;
  wire wire_var;
  rgb_t struct_var;
  logic [7:0] packed_arr [0:3];
  logic unpacked_arr [0:3];
  int dyn_arr [];
  int assoc_arr [string];
  BaseClass bc;
  int queue_var [$:10];
  int j;
  assign wire_var = in[0];
  task automatic process_data;
    input [7:0] in_data;
    output [7:0] out_data;
    begin
      out_data = in_data ^ 8'hFF;
    end
  endtask
  function [7:0] invert;
    input [7:0] data;
    return ~data;
  endfunction
  initial begin
    dyn_arr = new[4];
    bc = new(5);
    assoc_arr["test"] = 42;
    queue_var.push_back(123);
    struct_var = '{r:8'hFF, g:8'h00, b:8'h00};
    fork
      logic_var = 8'h55;
    join_none
  end
  always @(posedge clk) begin
    case (in[1:0])
      2'b00: out <= 8'h01;
      2'b01: out <= 8'h02;
      2'b10: out <= 8'h03;
      default: out <= 8'h00;
    endcase
    if (in > 128) begin
      out <= invert(in);
    end else begin
      logic [7:0] temp;
      process_data(in, temp);
      out <= temp;
    end
    for (int i=0; i<4; i++)
      packed_arr[i] <= i;
    j = 0;
    while (j < 4) begin
      unpacked_arr[j] <= j[0];
      j++;
    end
    unique if (in == 0) out <= 0;
    else if (in == 1) out <= 1;
    else out <= 2;
  end
  property p_check;
    @(posedge clk) in |-> out != 0;
  endproperty
  assert property (p_check);
  cover property (p_check);
  generate
    genvar gi;
    for (gi=0; gi<2; gi++) begin: gen_loop
      wire gen_wire = in[gi];
    end
  endgenerate
  sub_module #(.W(WIDTH)) sub_inst(.clk(clk), .in(in), .out(logic_var));
endmodule
module sub_module #(parameter W=8) (
  input clk,
  input [W-1:0] in,
  output logic [W-1:0] out
);
  always_comb out = ~in;
endmodule
