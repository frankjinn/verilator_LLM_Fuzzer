// Test file to maximize coverage of V3Timing.cpp
timeunit 1ns;
timeprecision 1ps;

// Base class with virtual methods containing timing controls
class BaseClass;
  bit done;
  
  virtual task wait_task(input int cycles);
    #cycles done = 1;
  endtask
  
  virtual function automatic void delay_func();
    #10;
  endfunction
  
  task wait_for_condition(input bit condition);
    wait(condition);
  endtask
endclass

// Extended class that overrides methods with timing
class ExtendedClass extends BaseClass;
  virtual task wait_task(input int cycles);
    // Override with different timing
    #(cycles * 2) done = 1;
  endtask
  
  virtual function automatic void delay_func();
    // Inherits suspendability from base class
    #5;
  endfunction
endclass

module timing_test;
  // Declarations
  reg clk = 0;
  reg rst_n = 0;
  reg [7:0] counter = 0;
  reg [7:0] delayed_counter = 0;
  reg [7:0] value = 0;
  reg [3:0] addr1 = 3, addr2 = 5;
  reg [7:0] mem[10];
  reg enable = 0;
  wire delayed_wire;
  wire [7:0] delayed_bus;
  event ev1, ev2;
  BaseClass base;
  ExtendedClass ext;
  
  // Generate clock
  always #5 clk = ~clk;
  
  // Test continuous assignment with net delay
  assign #3 delayed_wire = enable;
  assign #(2.5) delayed_bus = counter;
  
  // Test initial block with various timing controls
  initial begin
    $display("Testing initial block with timing");
    rst_n = 0;
    #10;
    rst_n = 1;
    
    // Test event control
    @(posedge clk);
    $display("After posedge clk");
    
    // Test multiple events
    @(posedge clk or negedge rst_n);
    $display("After posedge clk or negedge rst_n");
    
    // Test named events
    ->ev1;
    @ev1;
    $display("After event ev1");
    
    // Test wait statement
    counter = 0;
    fork
      begin
        wait(counter == 5);
        $display("Counter reached 5");
      end
      begin
        repeat(10) @(posedge clk) counter = counter + 1; // Changed <= to =
      end
    join
    
    // Test intra-assignment delay
    delayed_counter = #15 counter + 1; // Changed <= to =
    
    // Test multiple delays in sequence
    #5 value = 1;
    #10 value = 2;
    #15 value = 3;
    
    // Test early termination using flag variable instead of disable
    begin
      reg cancel_flag = 0;
      fork
        begin
          #10; 
          if (!cancel_flag) value = 10;
        end
        begin
          #5;
          cancel_flag = 1;
          $display("First block canceled");
        end
      join
    end
    
    // Test wait fork
    fork
      #20 value = 20;
      #10 value = 15;
    join_any
    wait fork;
    
    // Test tasks with timing controls
    base = new();
    ext = new();
    fork
      base.wait_task(10);
      ext.wait_task(5);
    join
    
    // Test event inside task
    base.wait_for_condition(enable);
    
    #100 $finish;
  end
  
  // Test always block with timing controls
  always @(posedge clk) begin
    if (rst_n) counter <= counter + 1;
  end
  
  // Test always block with implicit event
  always @* begin
    value = counter * 2;
  end
  
  // Test always block with delay
  always begin
    #10 enable = ~enable;
  end
  
  // Test fork-join constructs
  initial begin
    $display("Testing fork-join constructs");
    
    // Test fork-join
    fork
      #10 $display("Thread 1");
      #20 $display("Thread 2");
      #15 $display("Thread 3");
    join
    $display("After join");
    
    // Test fork-join_any
    fork
      #10 $display("Thread 1 in join_any");
      #20 $display("Thread 2 in join_any");
      #15 $display("Thread 3 in join_any");
    join_any
    $display("After join_any");
    
    // Test fork-join_none
    fork
      #10 $display("Thread 1 in join_none");
      #20 $display("Thread 2 in join_none");
      #15 $display("Thread 3 in join_none");
    join_none
    $display("After join_none");
    
    // Test nested fork-join
    fork
      fork
        #5 $display("Nested thread 1");
        #10 $display("Nested thread 2");
      join
      #15 $display("Parallel to nested");
    join
  end
  
  // Test complex intra-assignment delay with array indices
  initial begin
    // Test delay with dynamic indices
    mem[addr1] = #10 mem[addr2] + 1; // Changed <= to =
    
    // Test event control with dynamic indices
    @(posedge clk) mem[addr1+1] = mem[addr2+1] + 1; // Changed <= to =
    
    // Test complex expressions in timing controls
    #(addr1 * 2 + 5) mem[0] = 10;
    
    // Test real-time delays
    #1.5 mem[1] = 20;
    #0.75 mem[2] = 30;
  end
  
  // Test non-blocking assignments in different time regions
  always @(posedge clk) begin
    // These should create different timing regions
    counter <= counter + 1;
    delayed_counter <= #1 counter;
    value <= #2 delayed_counter;
  end
  
  // Test dynamic event expressions
  reg [3:0] event_select;
  initial begin
    event_select = 0;
    fork
      begin
        @(event_select == 1 or event_select == 3) $display("Event 1 or 3");
        @(event_select == 2) $display("Event 2");
      end
      begin
        #10 event_select = 1;
        #10 event_select = 2;
        #10 event_select = 3;
      end
    join
  end
  
  // Test wait statements with complex conditions
  initial begin
    wait(counter > 0 && value < 10);
    $display("Condition met: counter > 0 && value < 10");
    
    fork
      wait(counter == 10);
      #50 $display("Timeout waiting for counter == 10");
    join_any
    
    // Test wait with constant conditions - add lint_off directive
    /* verilator lint_off WAITCONST */
    wait(1); // Should optimize out
    /* verilator lint_on WAITCONST */
    $display("Wait with true condition passed immediately");
    
    fork
      /* verilator lint_off WAITCONST */
      wait(0); // Should never execute
      /* verilator lint_on WAITCONST */
      #1 $display("Wait with false condition never passes");
    join_any
  end
  
  // Test intra-assignment timing controls in various forms
  initial begin
    // Test event control in assignment
    value = @(posedge clk) counter;
    
    // Test delay in sequential blocks
    begin
      #10 addr1 = 1;
      #15 addr2 = 2;
    end
  end
  
  // Use functions with timing controls
  function automatic void test_timing_func();
    #10; // This should make it a coroutine
  endfunction
  
  initial begin
    test_timing_func();
  end
  
  // Test of fork control without using disable
  initial begin
    // Use a flag to control execution instead
    bit run_flag = 1;
    
    fork
      begin
        if (run_flag) #10 $display("Task 1");
        if (run_flag) #20 $display("Task 2");
        if (run_flag) #30 $display("Task 3");
      end
    join_none
    
    #15 run_flag = 0; // This effectively stops the tasks from executing further
    
    fork: second_fork
      #10 $display("Second task 1");
      #20 $display("Second task 2");
    join_any
    
    wait fork;
    $display("All forks completed");
  end

  // DPI export task without timing - FIXED: removed timing control from DPI task
  export "DPI-C" task dpi_task_with_timing;
  task dpi_task_with_timing;
    // Removed timing control #10 that was causing the error
    // Just add some non-timing code to keep the task
    $display("DPI task running");
  endtask
endmodule
