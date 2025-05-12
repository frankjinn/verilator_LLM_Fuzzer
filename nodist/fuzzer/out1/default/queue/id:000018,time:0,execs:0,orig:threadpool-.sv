`timescale 1ns/1ps
module threadpool_test_top;
  localparam int WIDTH = 64;
  localparam int MODULES = 8;
  localparam int ITERATIONS = 100;
  logic clk = 0;
  logic rst_n = 0;
  logic [WIDTH-1:0] data_in[MODULES];
  logic [WIDTH-1:0] results[MODULES];
  
  always clk = ~clk;
  
  genvar i;
  generate
    for (i = 0; i < MODULES; i++) begin : gen_modules
      complex_module #(
        .MODULE_ID(i),
        .WIDTH(WIDTH),
        .ITERATIONS(ITERATIONS)
      ) cm_inst (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in[i]),
        .result(results[i])
      );
    end
  endgenerate

  initial begin
    for (int i = 0; i < MODULES; i++) begin
      data_in[i] = i;
    end
    rst_n = 0;
    rst_n = 1;
    for (int i = 0; i < MODULES; i++) begin
      $display("Module %0d result: %h", i, results[i]);
    end
    $finish;
  end

  initial begin
    fork
      begin
        $display("Thread 1 executing");
      end
      begin
        $display("Thread 2 executing");
      end
      begin
        $display("Thread 3 executing");
      end
    join
  end
endmodule

module complex_module #(
  parameter int MODULE_ID = 0,
  parameter int WIDTH = 64,
  parameter int ITERATIONS = 100
)(
  input  logic clk,
  input  logic rst_n,
  input  logic [WIDTH-1:0] data_in,
  output logic [WIDTH-1:0] result
);
  logic [WIDTH-1:0] temp_data[ITERATIONS];
  logic [WIDTH-1:0] accumulated;
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      accumulated <= '0;
      for (int i = 0; i < ITERATIONS; i++) begin
        temp_data[i] <= '0;
      end
    end else begin
      temp_data[0] <= data_in;
      for (int i = 1; i < ITERATIONS; i++) begin
        temp_data[i] <= complex_function(temp_data[i-1], i);
      end
      accumulated <= temp_data[ITERATIONS-1];
    end
  end
  always_ff @(posedge clk) begin
    if (rst_n) begin
      result <= accumulated ^ {WIDTH{1'b1}};
    end else begin
      result <= '0;
    end
  end
  function automatic logic [WIDTH-1:0] complex_function(logic [WIDTH-1:0] data, int iteration);
    logic [WIDTH-1:0] result;
    result = data;
    result = {result[WIDTH-2:0], result[WIDTH-1]};
    for (int i = 0; i < WIDTH/8; i++) begin
      result = result ^ (result << i) ^ (result >> i);
    end
    result = result + iteration;
    return result;
  endfunction
  logic check_result;
  always @(posedge clk) begin
    if (rst_n) begin
      check_result <= (result != '0);
      if (!check_result) $error("Result should not be zero after reset");
    end
  end
endmodule
