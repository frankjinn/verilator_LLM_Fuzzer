package pkg_types;
  typedef enum logic [2:0] {
    STATE_IDLE,
    STATE_FETCH,
    STATE_EXECUTE,
    STATE_STORE
  } state_e;
  typedef struct packed {
    logic [7:0] addr;
    logic [31:0] data;
    logic valid;
  } transaction_t;
endpackage
interface complex_if #(parameter WIDTH = 32);
  logic clk;
  logic rst_n;
  logic [WIDTH-1:0] data;
  logic valid;
  logic ready;
  modport master(input clk, rst_n, ready, output data, valid);
  modport slave(input clk, rst_n, data, valid, output ready);
  task automatic wait_cycle();
    @(posedge clk);
  endtask
endinterface
module submodule #(
  parameter int WIDTH = 8,
  parameter bit HAS_PARITY = 1
)(
  input logic clk,
  input logic rst_n,
  input logic [WIDTH-1:0] data_in,
  input logic valid_in,
  output logic [WIDTH-1:0] data_out,
  output logic valid_out,
  output logic parity_out
);
  import pkg_types::*;
  logic [WIDTH-1:0] data_reg;
  logic valid_reg;
  logic parity_bit;
  state_e state;
  function automatic logic calc_parity(logic [WIDTH-1:0] data);
    logic parity = 0;
    for (int i = 0; i < WIDTH; i++) begin
      parity ^= data[i];
    end
    return parity;
  endfunction
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_reg <= '0;
      valid_reg <= 0;
      parity_bit <= 0;
      state <= STATE_IDLE;
    end else begin
      case (state)
        STATE_IDLE: begin
          if (valid_in) begin
            data_reg <= data_in;
            valid_reg <= 1'b1;
            parity_bit <= HAS_PARITY ? calc_parity(data_in) : 1'b0;
            state <= STATE_FETCH;
          end
        end
        STATE_FETCH: begin
          valid_reg <= 1'b0;
          state <= STATE_IDLE;
        end
        default: state <= STATE_IDLE;
      endcase
    end
  end
  generate
    if (HAS_PARITY) begin : gen_parity
      assign parity_out = parity_bit;
    end else begin : no_parity
      assign parity_out = 1'b0;
    end
  endgenerate
  assign data_out = data_reg;
  assign valid_out = valid_reg;
endmodule
module top_module #(
  parameter int DATA_WIDTH = 32,
  parameter int INSTANCES = 4
)(
  input logic clk,
  input logic rst_n,
  complex_if.slave in_if,
  complex_if.master out_if
);
  import pkg_types::*;
  localparam int HALF_WIDTH = DATA_WIDTH / 2;
  typedef struct {
    logic [31:0] counter;
    logic overflow;
  } counter_t;
  logic [DATA_WIDTH-1:0] data_array [INSTANCES];
  logic [INSTANCES-1:0] valid_array;
  logic [INSTANCES-1:0] parity_array;
  counter_t counters [INSTANCES];
  state_e states [INSTANCES];
  transaction_t transactions [10];
  wire [DATA_WIDTH-1:0] complex_expr = (in_if.valid && !in_if.ready) ?
                       (in_if.data + {DATA_WIDTH{1'b1}}) :
                       ((|valid_array) ?
                           (data_array[0] | data_array[1] | data_array[2] | data_array[3]) :
                           {DATA_WIDTH{1'b0}});
  logic [3:0][7:0] matrix;
  int fixed_array[5];
  int queue_array[10];
  int queue_count;
  genvar g;
  generate
    for (g = 0; g < INSTANCES; g++) begin : gen_submodules
      submodule #(
        .WIDTH(g < 2 ? HALF_WIDTH : HALF_WIDTH/2),
        .HAS_PARITY(g % 2 == 0)
      ) submod_inst (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(in_if.data[(g+1)*HALF_WIDTH/2-1:g*HALF_WIDTH/2]),
        .valid_in(in_if.valid),
        .data_out(data_array[g]),
        .valid_out(valid_array[g]),
        .parity_out(parity_array[g])
      );
      initial begin
        counters[g].counter = g;
        counters[g].overflow = 0;
        states[g] = STATE_IDLE;
      end
    end
  endgenerate
  initial begin
    for (int i = 0; i < 10; i++) begin
      transactions[i].addr = i;
      transactions[i].data = i * 100;
      transactions[i].valid = (i % 2 == 0);
    end
    for (int i = 0; i < 5; i++) begin
      fixed_array[i] = i*10;
    end
    queue_count = 0;
    for (int i = 0; i < 8; i++) begin
      queue_array[queue_count] = i;
      queue_count++;
    end
    for (int i = 0; i < queue_count-1; i++) begin
      queue_array[i] = queue_array[i+1];
    end
    queue_count--;
    for (int i = 2; i < queue_count-1; i++) begin
      queue_array[i] = queue_array[i+1];
    end
    queue_count--;
  end
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_if.data <= '0;
      out_if.valid <= 1'b0;
    end else begin
      out_if.valid <= |valid_array;
      if (|valid_array) begin
        casez (valid_array)
          4'b???1: out_if.data <= data_array[0];
          4'b??10: out_if.data <= data_array[1];
          4'b?100: out_if.data <= data_array[2];
          4'b1000: out_if.data <= data_array[3];
          default: out_if.data <= 'x;
        endcase
      end else if (in_if.valid) begin
        out_if.data <= in_if.data;
        out_if.valid <= 1'b1;
      end else begin
        out_if.data <= complex_expr;
        out_if.valid <= 1'b0;
      end
    end
  end
  always_ff @(posedge clk) begin
    if (rst_n) begin
      assert(!(out_if.valid && !in_if.ready))
      else $error("Protocol violation: valid without ready");
      cover(out_if.valid && in_if.ready);
    end
  end
  function automatic [DATA_WIDTH-1:0] process_data(input logic [DATA_WIDTH-1:0] data);
    logic [DATA_WIDTH-1:0] result;
    begin
      result = data;
      for (int i = 0; i < DATA_WIDTH/8; i++) begin
        logic [7:0] byte_val = data[i*8 +: 8];
        if (byte_val == 0) begin
          result[i*8 +: 8] = 8'hFF;
        end else if (byte_val < 128) begin
          result[i*8 +: 8] = byte_val * 2;
        end else begin
          result[i*8 +: 8] = byte_val / 2;
        end
      end
      return result ^ {DATA_WIDTH{1'b1}};
    end
  endfunction
  wire [DATA_WIDTH-1:0] processed_data = process_data(in_if.data);
  localparam UNSIZED_HEX = 'hDEADBEEF;
  localparam [15:0] SIZED_HEX = 16'hABCD;
  localparam BINARY = 8'b1010_1010;
  localparam DECIMAL = 1234;
  localparam REAL_VAL = 3.14159;
  wire [63:0] mixed_math = DATA_WIDTH * HALF_WIDTH + (BINARY << 2) | (SIZED_HEX * 16);
  always_ff @(posedge clk) begin
    for (int i = 0; i < 4; i++) begin
      for (int j = 0; j < 8; j++) begin
        matrix[i][j] <= i ^ j;
      end
    end
  end
endmodule
module testbench;
  import pkg_types::*;
  logic clk = 0;
  logic rst_n = 0;
  always #5 clk = ~clk;
  initial begin
    rst_n = 0;
    #20;
    rst_n = 1;
  end
  complex_if #(.WIDTH(32)) intf_in();
  complex_if #(.WIDTH(32)) intf_out();
  assign intf_in.clk = clk;
  assign intf_in.rst_n = rst_n;
  assign intf_out.clk = clk;
  assign intf_out.rst_n = rst_n;
  top_module #(
    .DATA_WIDTH(32),
    .INSTANCES(4)
  ) dut (
    .clk(clk),
    .rst_n(rst_n),
    .in_if(intf_in),
    .out_if(intf_out)
  );
  initial begin
    intf_in.data = 0;
    intf_in.valid = 0;
    intf_out.ready = 1;
    wait(rst_n);
    @(posedge clk);
    for (int i = 0; i < 20; i++) begin
      intf_in.data = $random;
      intf_in.valid = 1;
      @(posedge clk);
      if (i % 3 == 0) begin
        intf_in.valid = 0;
        @(posedge clk);
      end
      if (i % 5 == 0) begin
        intf_out.ready = 0;
        @(posedge clk);
        intf_out.ready = 1;
      end
    end
    intf_in.valid = 0;
    repeat(5) @(posedge clk);
    $finish;
  end
  always @(posedge clk) begin
    if (intf_out.valid && intf_out.ready) begin
      $display("Output: %h", intf_out.data);
    end
  end
endmodule
