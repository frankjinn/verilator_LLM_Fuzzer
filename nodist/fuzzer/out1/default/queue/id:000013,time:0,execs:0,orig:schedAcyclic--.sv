/* vER */
module schc;
    // Si
    logic a, b, c, d, e, f;  //g
    logic [31:0] wide_bus; logic [15:0] medium_bus;
    logic [7:0] narrow_bus;
     // Si
    always_comb begin
    c= e; e = c;
end
 always_comb begin
    wide_bus = {medium_bus, medium_bus};
medium_bus = narrow_bus * 2; narrow_bus = wide_bus[7:0]; end  //(f)
always_comb begin
   end  //out
always_comb begin
    wide_bus[8] = f;
    end
 always_comb begin
    wide_bus[9] = f;
    end
 always_comb begin
    wide_bus[10] = f;
end
 logic [3:0] nested1, nested2, nested3, nested4;  always_comb begin
end
 // gic
logic cond_a, cond_b, cond_c;
     always_comb begin cond_a = cond_b & cond_c;
 b = cond_c ? cond_a : 0; cond_c = cond_a | cond_b;
    end

// Aion
initial begin
    a = 0; b = 1;
 wide_bus = 0; medium_bus = 1; narrow_bus = 2;
    nested1 = 0; nested2 = 1; nested3 = 2; nested4 = 3;
 a = 0; cond_b = 1; cond_c = 0;
    end
endmodule
/* ER */
