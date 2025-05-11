module variableorder (
  input wire clk,
  input wire reset,
  input wire [7:0] primary_input,  // Primary IO will be ordered differently with hierChild
  output reg [7:0] primary_output
);
  // Clock signals - will be detected as usedClock with width 1 (stratum 1)
  wire used_clock;
  assign used_clock = clk;
  
  // Different width variables to test different strata
  reg single_bit;             // 1-bit (stratum 2)
  reg [15:0] two_bytes;       // 2-byte (stratum 3)
  reg [31:0] four_bytes;      // 4-byte (stratum 5)
  reg [63:0] eight_bytes;     // 8-byte (stratum 6)
  
  // Unpacked arrays (stratum 9)
  reg [7:0] unpacked_array [0:9];
  
  // Static variables
  reg static_var /* verilator public_flat_rw @(posedge clk) */;
  
  // Struct for anonymous-friendly variables
  typedef struct packed {
    logic [7:0] field1;
    logic [7:0] field2;
  } struct_type;
  
  struct_type anon_friendly_struct;
  
  // Additional variable types
  integer int_var;
  time time_var;
  real real_var;
  
  // Add opaque type (stratum 8)
  string str_var;
  
  // Tasks that reference different variables to create MTask affinity patterns
  task automatic task1;
    single_bit = 1'b1;
    two_bytes = 16'hABCD;
  endtask
  
  task automatic task2;
    four_bytes = 32'h12345678;
    eight_bytes = 64'hABCDEF0123456789;
  endtask
  
  task automatic task3;
    // Reference variables from other tasks to create interesting MTask affinities
    two_bytes = two_bytes + 1;
    four_bytes = four_bytes + 1;
    
    // Reference array to get different treatment
    for (int i = 0; i < 10; i++) begin
      unpacked_array[i] = i;
    end
  endtask
  
  // Initial block to exercise the tasks
  initial begin
    task1();
    task2();
    task3();
    
    static_var = 1'b1;
    anon_friendly_struct.field1 = 8'h42;
    anon_friendly_struct.field2 = 8'h69;
    
    primary_output = primary_input + 1;
    
    int_var = 12345;
    time_var = 98765;
    real_var = 3.14159;
    str_var = "opaque type test";
  end
  
  // Always block to create more variable references
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      single_bit <= 0;
      two_bytes <= 0;
      four_bytes <= 0;
    end else begin
      single_bit <= ~single_bit;
      two_bytes <= two_bytes + 1;
      four_bytes <= four_bytes + 1;
    end
  end
  
  // Another always block with different variables to create complex MTask patterns
  always @(posedge used_clock) begin
    eight_bytes <= eight_bytes + 1;
    unpacked_array[0] <= unpacked_array[0] + 1;
  end

endmodule

// Add a second module to test module variable ordering across different modules
module second_module;
  // Mix of different variable types to test sorting
  reg [7:0] var1;
  reg [15:0] var2;
  wire var3;
  reg [31:0] var4;
  reg static_var /* verilator public_flat_rw */;
  time time_var;
  string str_var;
  
  initial begin
    var1 = 8'h42;
    var2 = 16'hABCD;
    var4 = 32'h12345678;
    static_var = 1;
    time_var = 54321;
    str_var = "second module string";
  end
  
  assign var3 = var1[0] ^ var2[0];
endmodule
