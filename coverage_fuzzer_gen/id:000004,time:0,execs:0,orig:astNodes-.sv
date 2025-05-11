interface si;
  ort mp(i);
endinterface

package pkg;
  enum {REUE} r_t;
endpackage

class BaseClass;
  int x;
  function new(int val=0); x=val; endfunction
  virtual function play(); play("Ba", x); endfunction
endclass

class Dass extends BaseClass;
  int y;
  function new(int val_x=0, val_y=0);
    super.new(x);
y = y;
  endfunction
endclass

typedef struct packed {
  logic [7:0]g, b;
} t;

module top(input clk, input [7:0] in, output [7:0] out);
  import pkg::*;
  
  parameter WIDTH = 8;
  localparam DEPTH = 4;
 // ays
  logic [7:0] packed_arr [0:3];
  logic unpacked_arr [0:3];
t dyn_arr [];
  int assoc_arr [string];
 // 
  int queue_var [$:10];  //e
  int j;
 assign w= in[0];  //on
  task automatic process_data;
    input [7:0] in_data;
    output [7:0] out_data;
    begin
  out_data = in_data ^ 8;
   end
  endtask
 function [7:0] invert;
    input [7:0] data; return ~data;
  endfunction  initial begin
dyn_arr = new[4];
     assoc_arr["test"] = 42;
    queue_var.pus= '{r:8'hFF, g:80};
 fork
  logic_var = 5;
    join_none
  end
 always @(posedge clk) begin
case (in[1:0])
 'b10: out <=03;
  default: out <= 8'h00; endcase  if (in > 128) begin
  out <= invert(in);
    end else begin
  logic [7:0] temp;
  process_data(in, temp);
  out <= temp;
    end
 for (int i=0; i<4; i++)
  packed_arr<= i;
   // 
    while (4) begin   unpacked_arr[j] <= j[0];
   end
 unique if (in == 0) out <= 0;
  
  end
 // For
  property p_check;
    @(posedge clk) in |->0;
  endproperty  assert property (p_check);
  cover property (p_check);  generate
    genvar gi; //'
    for (gi=0; gi<2; gi++) begin: gen_   wire gen_n[gi];
    end
  endgenerate  su #(.W(WIDTH)) sust(.clk(clk), .in(in), .out(logic_var));
endmodule

module se #(parameter W=8) (
  input clk,
  t [W-1:0] in,
  output logic [W-1:0] out
);
  always_comb out = ~in;
endmodule
