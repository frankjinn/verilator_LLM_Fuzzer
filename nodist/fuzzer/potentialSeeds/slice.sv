module slice_test;
  // Basic unpacked arrays with different dimensions
  logic [7:0] arr1D [0:9];
  logic [7:0] arr1D_rev [9:0];  // Descending range
  logic [7:0] arr2D [0:3][0:2]; // 2D array
  logic [7:0] arr_small [0:2];  // Smaller array for dimension mismatch

  // Arrays for comparison testing
  logic [3:0] comp_arr1 [0:3];
  logic [3:0] comp_arr2 [0:3];
  logic result;

  // Structure for testing struct arrays
  typedef struct packed {
    logic [7:0] field1;
    logic [3:0] field2;
  } mystruct_t;
  
  // Array of structures
  mystruct_t struct_arr [0:3];
  
  // For conditionals and complex expressions
  logic sel;
  int idx;
  
  // Declare arrays that were inside initial block
  logic [3:0] init_arr [0:5];
  logic [7:0] pattern_arr [0:5];
  logic [3:0] small_arr [0:1];
  
  initial begin
    // Basic array assignment (full slice)
    arr1D = '{10{8'hAA}};
    
    // Assignment to descending range array
    arr1D_rev = arr1D;
    
    // Partial array assignments
    arr1D[2:5] = '{4{8'h55}};
    
    // Assignment between differently sized arrays (implicit slicing)
    arr_small = arr1D[0:2];
    
    // 2D array assignments
    arr2D[1] = arr1D[3:5];
    arr2D[0][1:2] = arr1D[7:8];
    
    // Array initialization - now just assignment
    init_arr = '{4'd1, 4'd2, 4'd3, 4'd4, 4'd5, 4'd6};
    
    // Simple pattern array assignment - avoiding complex initializers
    pattern_arr[0] = 8'h11;
    pattern_arr[1] = 8'h22;
    pattern_arr[2] = 8'h33;
    pattern_arr[3] = 8'h44;
    pattern_arr[4] = arr1D[4];
    pattern_arr[5] = sel ? 8'h77 : 8'h88;
    
    // Testing BiOp expansion (Eq/Neq for arrays)
    comp_arr1 = '{4'h1, 4'h2, 4'h3, 4'h4};
    comp_arr2 = '{4'h1, 4'h2, 4'h3, 4'h4};
    
    // Array equality test
    result = (comp_arr1 == comp_arr2);
    result = (comp_arr1 != comp_arr2);
    result = (comp_arr1 === comp_arr2);
    result = (comp_arr1 !== comp_arr2);
    
    // Conditional expressions with arrays
    sel = 1'b1;
    arr_small = sel ? arr1D[0:2] : arr1D[7:9];
    
    // Initialize struct array
    struct_arr = '{
      '{field1: 8'h11, field2: 4'h1},
      '{field1: 8'h22, field2: 4'h2},
      '{field1: 8'h33, field2: 4'h3},
      '{field1: 8'h44, field2: 4'h4}
    };
    
    // Access struct array elements
    struct_arr[2].field1 = arr1D[0];
    
    // Array concatenation assignment
    arr_small = {arr1D[0], arr1D[5], arr1D[9]};
    
    // Dynamic array index
    idx = 3;
    arr1D[idx] = 8'hFF;
    
    // Array replication operation - now just assignment
    small_arr = '{2{4'hA}};
    
    // Fix reversed range slices - use 9:7 instead of 7:9 for descending range
    arr1D[1:3] = arr1D_rev[9:7];
    
    // Also fix these reversed ranges
    arr1D[3:4] = sel ? arr1D_rev[4:3] : arr1D_rev[6:5];
  end
  
  // Add some procedural assignments
  always_comb begin
    for (int i = 0; i < 3; i++) begin
      arr_small[i] = arr1D[i+2];
    end
  end
  
  // Verify both ascending and descending accesses
  always_comb begin
    for (int i = 0; i < 10; i++) begin
      arr1D_rev[9-i] = arr1D[i];
    end
  end
  
endmodule
