timeunit 1ns;
timeprecision 1ps;
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
class ExtendedClass extends BaseClass;
  virtual task wait_task(input int cycles);
    #(cycles * 2) done = 1;
  endtask
  virtual function automatic void delay_func();
    #5;
  endfunction
endclass
module timing_test;
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
  always #5 clk = ~clk;
  assign #3 delayed_wire = enable;
  assign #(2.5) delayed_bus = counter;
  initial begin
    $display("Testing initial block with timing");
    rst_n = 0;
    #10;
    rst_n = 1;
    @(posedge clk);
    $display("After posedge clk");
    @(posedge clk or negedge rst_n);
    $display("After posedge clk or negedge rst_n");
    ->ev1;
    @ev1;
    $display("After event ev1");
    counter = 0;
    fork
      begin
        wait(counter == 5);
        $display("Counter reached 5");
      end
      begin
        repeat(10) @(posedge clk) counter = counter + 1;
      end
    join
    delayed_counter = #15 counter + 1;
    #5 value = 1;
    #10 value = 2;
    #15 value = 3;
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
    fork
      #20 value = 20;
      #10 value = 15;
    join_any
    wait fork;
    base = new();
    ext = new();
    fork
      base.wait_task(10);
      ext.wait_task(5);
    join
    base.wait_for_condition(enable);
    #100 $finish;
  end
  always @(posedge clk) begin
    if (rst_n) counter <= counter + 1;
  end
  always @* begin
    value = counter * 2;
  end
  always begin
    #10 enable = ~enable;
  end
  initial begin
    $display("Testing fork-join constructs");
    fork
      #10 $display("Thread 1");
      #20 $display("Thread 2");
      #15 $display("Thread 3");
    join
    $display("After join");
    fork
      #10 $display("Thread 1 in join_any");
      #20 $display("Thread 2 in join_any");
      #15 $display("Thread 3 in join_any");
    join_any
    $display("After join_any");
    fork
      #10 $display("Thread 1 in join_none");
      #20 $display("Thread 2 in join_none");
      #15 $display("Thread 3 in join_none");
    join_none
    $display("After join_none");
    fork
      fork
        #5 $display("Nested thread 1");
        #10 $display("Nested thread 2");
      join
      #15 $display("Parallel to nested");
    join
  end
  initial begin
    mem[addr1] = #10 mem[addr2] + 1;
    @(posedge clk) mem[addr1+1] = mem[addr2+1] + 1;
    #(addr1 * 2 + 5) mem[0] = 10;
    #1.5 mem[1] = 20;
    #0.75 mem[2] = 30;
  end
  always @(posedge clk) begin
    counter <= counter + 1;
    delayed_counter <= #1 counter;
    value <= #2 delayed_counter;
  end
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
  initial begin
    wait(counter > 0 && value < 10);
    $display("Condition met: counter > 0 && value < 10");
    fork
      wait(counter == 10);
      #50 $display("Timeout waiting for counter == 10");
    join_any
    wait(1);
    $display("Wait with true condition passed immediately");
    fork
      wait(0);
      #1 $display("Wait with false condition never passes");
    join_any
  end
  initial begin
    value = @(posedge clk) counter;
    begin
      #10 addr1 = 1;
      #15 addr2 = 2;
    end
  end
  function automatic void test_timing_func();
    #10;
  endfunction
  initial begin
    test_timing_func();
  end
  initial begin
    bit run_flag = 1;
    fork
      begin
        if (run_flag) #10 $display("Task 1");
        if (run_flag) #20 $display("Task 2");
        if (run_flag) #30 $display("Task 3");
      end
    join_none
    #15 run_flag = 0;
    fork: second_fork
      #10 $display("Second task 1");
      #20 $display("Second task 2");
    join_any
    wait fork;
    $display("All forks completed");
  end
  export "DPI-C" task dpi_task_with_timing;
  task dpi_task_with_timing;
    $display("DPI task running");
  endtask
endmodule
