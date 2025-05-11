module st;
  // ons
  logic [7:0] arr1D [0:9];
  logic [7:0] arr1D_rev [9:0];  // Dege
  logic [7:0] arr2D [0:3][0:2]; // 2Day
  logic [7:0] arr_small [0:2];  // Smng
  logic [3:0] comp_arr1 [0:3];
  logic [3:0] comp_arr2 [0:3];
  logic result;// Sys
  struct packed { logic [7:0]ld1; logic [3:0]ld2;
  }t_t; // 
  logic sel;
  int idx;  //
  logic [7:0] pattern_arr [0:5];
  logic [3:0] r [0:1];  initial begin
// B
    arr2D[1] = arr1D[3:5];
arr2D[0][1:2] = arr1D[7:8];
 // 
    pattern_arr[0] = 8'h11; pattern_arr[1] = 8'h22; pattern_arr[2] = 8'h33; pattern_arr[3] = 8'h44; pattern_arr[4] = arr1D[4];
pattern_arr[5] = sel;
     // Te
    result = (comp_arr1 === comp_arr2); result = (comp_arr1 !== comp_arr2);  //
    sel = 1'b1; arr_small = sel ? arr1D[0:2] : arr1D[7:9];
 // e
    arr1D[1:3] = arr1D_rev[9:7];
 // As
    arr1D[3:4] = sel ? arr1D_rev[4:3] : arr1D_rev[6:5];
  end
 // nts
  always_comb begin
for (int i = 0; 3; i++) begin
  arr_small[i] = arr1D[i+2];
    end
  end  //es
  always_comb begin
    for (int i = 0; i < 10; i++) begin
  arr1D_rev[9-i] = arr1D[i];
    end
  end
  
endmodule
