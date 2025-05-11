`timescale 1ns/1ps

// Top module to instantiate all the computation-heavy submodules
module threadpool_test_top;
  // Parameters to control complexity
  localparam int WIDTH = 64;
  localparam int MODULES = 8;
  localparam int ITERATIONS = 100;
  
  // Signals
  logic clk = 0;
  logic rst_n = 0;
  logic [WIDTH-1:0] data_in[MODULES];
  logic [WIDTH-1:0] results[MODULES];
  
  // Clock generation
  always #5 clk = ~clk;
  
  // Generate multiple complex modules that can be processed in parallel
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
  
  // Stimulus
  initial begin
    // Initialize inputs
    for (int i = 0; i < MODULES; i++) begin
      data_in[i] = i;
    end
    
    // Reset sequence
    rst_n = 0;
    #20 rst_n = 1;
    
    // Run simulation
    #1000;
    
    // Display results
    for (int i = 0; i < MODULES; i++) begin
      $display("Module %0d result: %h", i, results[i]);
    end
    
    $finish;
  end
  
  // Fork-join parallelism to create more potential for thread usage
  initial begin
    fork
      // Multiple parallel threads
      begin
        #100;
        $display("Thread 1 executing");
      end
      begin
        #110;
        $display("Thread 2 executing");
      end
      begin
        #120;
        $display("Thread 3 executing");
      end
    join
  end
endmodule

// Complex module with heavy computation to force parallelism
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
  // Local variables
  logic [WIDTH-1:0] temp_data[ITERATIONS];
  logic [WIDTH-1:0] accumulated;
  
  // Complex computations to maximize parallel processing
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      accumulated <= '0;
      for (int i = 0; i < ITERATIONS; i++) begin
        temp_data[i] <= '0;
      end
    end else begin
      // Initialize with data_in
      temp_data[0] <= data_in;
      
      // Perform complex operations
      for (int i = 1; i < ITERATIONS; i++) begin
        // Each iteration depends on the previous one to force sequential
        // processing within a module, but allow parallelism between modules
        temp_data[i] <= complex_function(temp_data[i-1], i);
      end
      
      // Final result
      accumulated <= temp_data[ITERATIONS-1];
    end
  end
  
  // Additional always block to create more potential for parallelism
  always_ff @(posedge clk) begin
    if (rst_n) begin
      result <= accumulated ^ {WIDTH{1'b1}};
    end else begin
      result <= '0;
    end
  end
  
  // Complex function to simulate heavy computation
  function automatic logic [WIDTH-1:0] complex_function(logic [WIDTH-1:0] data, int iteration);
    logic [WIDTH-1:0] result;
    result = data;
    
    // Bit manipulations
    result = {result[WIDTH-2:0], result[WIDTH-1]};  // Rotate left
    
    // XOR operations
    for (int i = 0; i < WIDTH/8; i++) begin
      result = result ^ (result << i) ^ (result >> i);
    end
    
    // Add iteration number
    result = result + iteration;
    
    return result;
  endfunction
  
  // Add assertions to create more parse work
  // synthesis translate_off
  // Replace unsupported SystemVerilog Assertion with a simple check
  logic check_result;
  always @(posedge clk) begin
    if (rst_n) begin
      check_result <= (result != '0);
      if (!check_result) $error("Result should not be zero after reset");
    end
  end
  // synthesis translate_on
endmodule
