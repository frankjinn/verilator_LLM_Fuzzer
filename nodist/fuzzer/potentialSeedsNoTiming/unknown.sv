module unknown_test;
    reg [4:0] x_const;
    reg [7:0] x_const2;
    reg [7:0] my_array [0:9];
    reg [3:0] my_array2d [0:3][0:3];
    reg [3:0] index;
    reg [3:0] index2;
    string str;
    reg [3:0] a, b;
    reg result;
    initial begin
        x_const = 5'b1xxxx;
        x_const2 = 8'bxxxx_xxxx;
        index = 15;
        my_array[index] = 8'h42;
        my_array[3] = my_array[index];
        index = 2;
        index2 = 5;
        my_array2d[index][index2] = 4'hA;
        a = 4'b1010;
        a[5] = 1'b1;
        a[index] = 1'b0;
        a = 4'b10x0;
        b = 4'b10x0;
        result = (a == b);
        result = (a === b);
        result = (a ==? 4'b10x0);
        result = (a !=? 4'b1xx0);
        case (a)
            4'b10x0: $display("Case equality match");
            default: $display("No match");
        endcase
        casez (a)
            4'b10?0: $display("Casez match");
            default: $display("No casez match");
        endcase
        if ($isunknown(a)) $display("A is unknown");
        $display("Count of 1s: %d", $countbits(a, 1'b1, 1'b0, 1'bx));
        $display("Count of Xs: %d", $countbits(a, 1'bx, 1'bx, 1'bx));
        $display("Count of mix: %d", $countbits(a, 1'b1, 1'bx, 1'b0));
        str = "test";
        if (index > 3) str = str[15];
    end
    wire [4:0] w_xconst = 5'bx_1_x;
    wire [7:0] w_array_value = my_array[index];
    
    always @(posedge result) begin
        a[index] <= 1'b1;
        my_array[index] <= 8'hFF;
    end
    
    always_comb begin
        if (index > 0) begin
            my_array[20] = 8'hFF;
            my_array[21] = 8'hEE;
        end else begin
            my_array[0] = 8'h00;
        end
    end
    
    reg [7:0] mod_idx;
    always_comb begin
        mod_idx = index % 8;
        my_array[mod_idx] = 8'h42;
        my_array[index % 15] = 8'h24;
    end
    
    parameter P_WITH_X = 8'b1010_1x1x;
    localparam LP_WITH_X = 4'bx1x0;
endmodule

class XTest;
    bit [3:0] x_val = 4'bx1x0;
endclass
