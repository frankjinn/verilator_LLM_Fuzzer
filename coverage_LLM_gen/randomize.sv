// Test class with various types of randomization features
/* verilator lint_off CONSTRAINTIGN */
class BaseClass;
  rand bit [7:0] base_var;
  randc bit [3:0] base_cyclic;
  bit non_rand_var;
  
  constraint base_c { base_var > 10; }
  
  function void pre_randomize();
    $display("BaseClass::pre_randomize called");
  endfunction
  
  function void post_randomize();
    $display("BaseClass::post_randomize called");
  endfunction
endclass

class RandomTest extends BaseClass;
  // Basic rand/randc variables of different types
  rand bit [31:0] a;
  rand int b;
  randc bit [7:0] c;
  rand bit signed [15:0] d;
  rand shortint e;
  
  // Non-randomized variables
  bit [31:0] not_rand;
  
  // Arrays
  rand bit [3:0] fixed_array[5];
  rand int dyn_array[];
  rand int queue_var[$];
  rand int assoc_array[string];
  
  // Struct and Union
  typedef struct packed {
    bit [7:0] x;
    bit [7:0] y;
  } Point;
  
  rand Point p;
  
  typedef struct {
    int a;
    byte b;
  } UnpackedStruct;
  
  rand UnpackedStruct us;
  
  typedef union packed {
    bit [15:0] whole;
    struct packed {
      bit [7:0] low;
      bit [7:0] high;
    } bytes;
  } PackedUnion;
  
  rand PackedUnion pu;
  
  // Class objects
  rand BaseClass bc_obj;
  
  // Enum type
  typedef enum { RED, GREEN, BLUE, YELLOW } Color;
  rand Color color;
  
  // Basic constraints
  constraint c1 { a > 10; a < 100; }
  constraint c2 { b == 42; }
  constraint c3 { c != 0; }
  constraint c4 { d inside {[-100:100]}; }
  
  // If-else constraint
  constraint c_if_else {
    if (a < 50) {
      b < 20;
    } else {
      b > 80;
    }
  }
  
  // Foreach constraint
  constraint c_foreach {
    foreach (fixed_array[i]) {
      fixed_array[i] > i;
    }
    dyn_array.size inside {[2:5]};
    foreach (dyn_array[i]) {
      dyn_array[i] < 100;
    }
    queue_var.size inside {[1:3]};
  }
  
  // Implication constraint
  constraint c_implies {
    (a > 50) -> (b > 50);
  }
  
  // Unsupported constraints - to test warning messages
  constraint c_unique {
    unique { fixed_array };
  }
  
  // Simple constraint - avoid distribution which might be causing issues
  constraint c_simple {
    a > 40;
  }
  
  // Hook methods
  function void pre_randomize();
    $display("RandomTest::pre_randomize called");
  endfunction
  
  function void post_randomize();
    $display("RandomTest::post_randomize called");
    $display("Randomized values: a=%0d, b=%0d, c=%0d", a, b, c);
  endfunction
  
  // Constructor
  function new();
    bc_obj = new();
    dyn_array = new[3];
  endfunction
endclass

module test_top;
  initial begin
    RandomTest rt;
    int success;
    
    // Create the class
    rt = new();
    
    // Basic randomize
    success = rt.randomize();
    $display("Randomization %s", success ? "succeeded" : "failed");
    
    // Randomize with inline constraint
    success = rt.randomize() with { a == 42; b > 100; };
    $display("Randomize with inline constraint %s", success ? "succeeded" : "failed");
    
    // Test randcase
    for (int i = 0; i < 5; i++) begin
      randcase
        1: $display("Case 1 selected");
        2: $display("Case 2 selected");
        3: $display("Case 3 selected");
      endcase
    end
    
    // Test randomize on arrays
    success = rt.randomize() with { 
      dyn_array.size == 4; 
      foreach (dyn_array[i]) dyn_array[i] == i * 10; 
    };
    
    $display("Randomized dynamic array: size=%0d", rt.dyn_array.size());
    for (int i = 0; i < rt.dyn_array.size(); i++)
      $display("  dyn_array[%0d] = %0d", i, rt.dyn_array[i]);
    
    // Test structure randomization
    success = rt.randomize() with {
      p.x == 42;
      p.y == 84;
    };
    $display("Randomized struct: p.x=%0d, p.y=%0d", rt.p.x, rt.p.y);
    
    // Test enum output
    success = rt.randomize();
    if (rt.color == 0) $display("Color is RED");
    else if (rt.color == 1) $display("Color is GREEN");
    else if (rt.color == 2) $display("Color is BLUE");
    else if (rt.color == 3) $display("Color is YELLOW");
    
    // Test class object randomization 
    success = rt.randomize();
    $display("Base object randomized: base_var=%0d, base_cyclic=%0d", 
             rt.bc_obj.base_var, rt.bc_obj.base_cyclic);
    
    $finish;
  end
endmodule
