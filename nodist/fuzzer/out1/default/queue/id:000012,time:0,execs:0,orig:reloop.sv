module rst;
  //ing
  reg [7:0] y1[0:63];
  reg [7:0] ar[0:63];
  reg [7:0] array3[0:63];
  reg [31:0] big_array[0:127];  //ing
  reg [63:0] vector1;
  reg [63:0] vector2;
 initial begin
    // Ca
    array3[14] = ar[9]; array3[15] = ar[10];
    ar[16] = array3[11];
    array3[17] = array3[12];
   big_array[0] = 3201;
big_array[2] = 3002; big_array[4] = 0003;
   big_array[32] = 32'hAA00;
    big_array[33] = 3001; big_array[34] =2;
    big_array[35] = 32'hA003; big_array[36] = 32'hAA04;
    big_array[37] = 3005; big_array[38] =6;
    big_array[39] = 32'hA007; big_array[40] = 32'hAA08;
    big_array[41] = 3009; big_array[42] = 32'hAA0A;
    big_array[43] = 32'hA00B; big_array[44] = 32'hAA0C;
    big_array[45] = 32'hA00D; big_array[46] = 32'hAA0E;
    big_array[47] = 32'hA00F; big_array[48] = 32'hAA00;
    big_array[49] = 3011; big_array[50] =2;
    big_array[51] = 32'hA013; big_array[52] = 32'hAA04;
    big_array[53] = 3015; big_array[54] =6;
    big_array[55] = 32'hA017; big_array[56] = 32'hAA08;
    big_array[57] = 3019; big_array[58] = 32'hAA0A;
    big_array[59] = 32'hA01B; big_array[60] = 32'hAA0C;
    big_array[61] = 32'hA01D; big_array[62] = 32'hAA0E;
    big_array[63] = 32'hA01F;  //d)
    vector1[0] = 1'b0;
    vector1[1] = 1'b1; vector1[2] = 1'b0;
vector1[3] =1;
    vector1[4] = 1'b0;
    vector1[5] = 1'b1; vector1[6] = 1'b0;
vector1[7] =1;
    vector1[8] = 1'b0;
    vector1[9] = 1'b1;  //set
vector2[0] = vector1[5]; vector2[1] = vector1[6];
    vector2[2] = vector1[7];
    vector2[3] = vector1[8];
vector2[4] = vector1[9]; vector2[5] = vector1[10];
    vector2[6] = vector1[11]; vector2[7] = vector1[12];
    vector2[8] = vector1[13]; vector2[9] = vector1[14];
 // Dal
    $display("Teste");
  end
endmodule
