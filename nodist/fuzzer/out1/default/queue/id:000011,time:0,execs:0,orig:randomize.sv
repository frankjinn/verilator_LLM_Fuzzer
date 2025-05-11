// T/
class BaseClass;
  rand bit [7:0] base_var;
  randc bit [3:0] base_cyclic;
  bit nvar;  constraint bas{ base_var > 10; }
 function voiize();
    $display("Bas");
  endfunction
  
  function ize();
    $display("Basd");
  endfunction
endclass

class RandomTest extends BaseClass;
  // Bapes
  rand bit [31:0] a;int b;
  randc bit [7:0] c;
  rand bit signed [15:0] d;
  rand shortint e;
 // Ns
   bit [3:0] fixed_array[5];
  rand int dyn_array[];
  rand int queue_var[$];
  rand int aay[string];
 // 
  typedef struct packed {
    bit [7:0] x;
bit [7:0] y;
  } Point;
 rand Point p;
 typedef struct {byte b;
  } UnpackedStruct;
 rand UnpackedStruct us;  typedef union packed { bit [15:0] e;
    struct packed {
  bit [7:0] low;
  bit [7:0] high;
    } s;
  } PackedUnion;
 rand PackedUnion pu;
  
  // Clcts
  rand BaseClass bc_obj; typedef enum { BLUE } Color;
   Color color;
  
  // Baint
  constraint c_ise { if (a < 50) {
 80;
}
  }
  
  // Fo
  constraint c_{
    foreach (fixed_array[i]) {   fixed_array[i] > i;
    } dyn_array.size inside {[2:5]};
foreach (dyn_array[i]) {   dyn_array< 100;
    } queue_var.size inside {[1:3]};
  }
 // nt
  constraint s {
(a > 50) -> (b > 50);
  }
  
  // Un
  constraint c_ue { unique { fixed_array };
  }  //s
  constraint cple {
    a ;
  }
  
  // Hods
  function vo();
$display("Raed");
  endfunction
 function voe(); $display("R", a, b, c);
  endfunction
 // Cor
  function new(); dyn_array = new[3];
  endfunction
endclass

module _top;
  initial begin
    RandomTest rt; int success;
     // Crase
for (int i = 0; 5; i++) begin
  randcase 1: $display("Cad"); 2: $display("Cad"); 3: $display("Cad");   endcase
    end
 success = rt.randomize() with {    dyn_array.size == 4;    foreach (dyn_array[i]) dyn_array[i] == i ; 
    };
     $display("Ran%0d", rt.dyn_array.size());
for (int i = 0; rt.dyn_array.size();)
   // 
    success = rt.randomize() with {   p;
     };
    $display("%0d", rt);
 // T;
    if (rt.color == 0) $display("CRED");
    else if (rt.c == 1) $display("ColEEN");
    else if (rt.c == 2) $display("ColUE");
    else if (rt.color ) $display("LOW");
 // T;
    $display("d",   rt.bc_obj.base_var, rt.bc_obj.base_cyclic);
     $finish;
  end
endmodule
