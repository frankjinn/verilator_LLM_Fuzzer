module tristate_top;
    // Various tristate signals with different pull configurations
    tri0 t0;            // has pulldown - corrected from wire tri0 to tri0
    tri1 t1;            // has pullup - corrected from wire tri1 to tri1
    tri t_plain;        // plain tristate
    tri [3:0] t_bus;    // tristate bus
    tri [7:0] t_array;  // wider tristate
    
    // Multiple drivers with different strengths
    wire [3:0] multi_drive;
    assign (strong0, strong1) multi_drive = 4'b1010;
    assign (pull0, pull1) multi_drive = 4'b0101;
    assign (weak0, weak1) multi_drive = 4'bzzzz;
    
    // Asymmetric strength test 
    wire asym_drive;
    assign (strong0, weak1) asym_drive = 1'b1;
    assign (weak0, strong1) asym_drive = 1'b0;
    
    // Test of tristate assignments and strengths
    wire [3:0] net_with_z = 4'b10zz;
    assign (strong0, strong1) t_bus[0] = 1'b1;
    assign (pull0, pull1) t_bus[1] = 1'b0;
    assign (weak0, weak1) t_bus[2] = 1'bz;
    assign (weak0, weak1) t_bus[3] = (net_with_z[3]) ? 1'b1 : 1'b0;  // Changed highz0/1 to weak0/1
    
    // Don't use direct assignment to array elements - Verilator doesn't support these for tristates
    // Commenting these out as they're unsupported
    /*
    tri [3:0] tri_array [0:3];
    assign tri_array[0] = 4'bz10z;
    assign tri_array[1][2] = 1'bz;
    */
    
    // Test of case equality with z
    wire eq_result1 = (4'b10zz === net_with_z);
    wire eq_result2 = (4'b10zz === 4'b10zz);
    wire eq_result3 = (4'b10zz !== 4'b100z);
    wire eq_result4 = (4'b10zz ==? 4'b10??);  // Wildcard equality
    wire eq_result5 = (4'b10zz !=? 4'b1???);  // Wildcard inequality
    
    // Test tristate buffers
    wire control1 = 1'b1;
    wire control2 = 1'b0;
    wire data = 1'b1;
    bufif1 buf1(t_plain, data, control1);  // enabled by 1
    bufif0 buf2(t_plain, data, control2);  // enabled by 0
    
    // More complex buffer connections
    tri complex_tri;
    bufif1 buf3(complex_tri, t_bus[0], net_with_z[0]);
    bufif0 buf4(complex_tri, t_bus[1], net_with_z[1]);
    
    // Test wired logic
    wor w_or;
    wand w_and;
    trior tri_or;
    triand tri_and;
    
    assign w_or = 1'b1;
    assign w_or = 1'b0;
    
    assign w_and = 1'b1;
    assign w_and = 1'b0;
    
    assign tri_or = 1'b1;
    assign tri_or = 1'b0;
    
    assign tri_and = 1'b1;
    assign tri_and = 1'b0;
    
    // Test of countones with z
    wire [3:0] count_result = $countones(4'b10zz);
    wire [3:0] count_bits_result = $countbits(4'b10zz, 1'b1, 1'b0, 1'bz);
    
    // Remove passing tristate to module boundary - unsupported with top-level IO
    // Using a local wire instead
    wire [3:0] local_net_with_z = net_with_z;
    
    // Test tristate through more complex expressions
    wire [3:0] tri_and_z = net_with_z & 4'b1zzz;  // AND with Z
    wire [3:0] tri_or_z = net_with_z | 4'b1zzz;   // OR with Z
    wire [3:0] tri_not_z = ~net_with_z;           // NOT with Z
    
    // Remove unsupported add operation with tristates
    // wire [3:0] tri_add_z = net_with_z + 4'bzz11;  // Addition with Z - unsupported
    
    // Test tristate in conditional
    wire cond_result1 = control1 ? 1'bz : 1'b0;
    wire cond_result2 = net_with_z[0] ? net_with_z[1] : net_with_z[2];
    
    // Test conditional with tristate in condition
    wire cond_z_result = net_with_z[3] ? 1'b1 : 1'b0;
    
    // Test other tristate operations
    wire [7:0] concat_tri = {net_with_z, 4'bz01z};
    wire sel_tri = concat_tri[2];  // select from tristate
    
    // Test selects from tristates
    wire [1:0] sel_bus = t_bus[3:2];
    wire [3:0] ext_tri = {3'b0, t_plain};
    
    // Test unconnected tristate
    tri unconnected;
    
    // Test extends with tristate values
    wire [7:0] ext_z = {4'b0, net_with_z};
    
    // Test slices with tristate
    wire [1:0] slice_tri = t_bus[2:1];
    
    // Additional edge cases
    tri edge_tri;
    assign edge_tri = &net_with_z ? 1'bz : 1'b1;  // Reduction with Z
    
    // Self-assignment through tristate
    tri self_tri;
    assign self_tri = self_tri ? 1'b1 : 1'bz;
    
    // Complex multibit tristate
    tri [3:0] mb_tri;
    assign mb_tri = net_with_z[0] ? 4'bzzzz : 4'b1010;
    assign mb_tri = net_with_z[1] ? 4'b0101 : 4'bzzzz;
    
    // Test more nested expressions
    wire [3:0] nested_z = net_with_z & (t_bus | 4'bz00z);

    initial begin
        #10;
        $display("t0 = %b", t0);
        $display("t1 = %b", t1);
        $display("t_plain = %b", t_plain);
        $display("t_bus = %b", t_bus);
        $display("multi_drive = %b", multi_drive);
        $display("asym_drive = %b", asym_drive);
        $display("eq_result1 = %b", eq_result1);
        $display("eq_result4 = %b", eq_result4);
        $display("w_or = %b", w_or);
        $display("w_and = %b", w_and);
        $display("count_result = %d", count_result);
        $display("count_bits_result = %d", count_bits_result);
        $display("tri_and_z = %b", tri_and_z);
        $display("tri_or_z = %b", tri_or_z);
        $display("cond_result1 = %b", cond_result1);
        $display("cond_z_result = %b", cond_z_result);
        $display("concat_tri = %b", concat_tri);
        $display("sel_tri = %b", sel_tri);
        $display("slice_tri = %b", slice_tri);
        $display("ext_z = %b", ext_z);
        $display("edge_tri = %b", edge_tri);
        $display("mb_tri = %b", mb_tri);
        $display("nested_z = %b", nested_z);
    end
endmodule

// Add lint_off directives to prevent MULTITOP warnings for all non-primary modules
/* verilator lint_off MULTITOP */
// Create a simplified version of this module without using arrays of tristates
// which are unsupported in the tristate implementation
module submodule(
    inout wire io_pin,
    inout wire [3:0] io_bus,
    input wire [3:0] in_z
);
    // Test through assignment
    assign io_pin = (in_z[0]) ? 1'bz : 1'b1;
    
    // Test tristate enable pin connection
    bufif1 inner_buf(io_bus[0], 1'b1, in_z[1]);
    
    // Test direct z assignment
    assign io_bus[1] = 1'bz;
    
    // Test with equation
    wire tmp;
    assign tmp = in_z[2] & 1'b1;
    assign io_bus[2] = tmp ? 1'bz : 1'b0;
    
    // Test case equality inside module
    wire internal_eq = (in_z === 4'b10zz);
    
    // Test nested tristate propagation
    wire nested_tri;
    assign nested_tri = in_z[3] ? 1'bz : io_pin;
    assign io_bus[3] = nested_tri;
    
    // Test complex propagation
    wire [1:0] internal_bus;
    assign internal_bus[0] = io_bus[0];
    assign io_bus[3] = internal_bus[0] ? 1'bz : 1'b0;
    
    // Removed array propagation which is unsupported
    // Using simple connections instead
    wire simple_tri;
    assign simple_tri = {io_pin, 1'bz}[0];
    assign io_bus[2] = simple_tri;
endmodule

// Module to test inout pins and bidirectional behavior
module inout_test;
    tri io1, io2, io3;
    wire internal1, internal2;
    
    // Bidirectional test
    assign io1 = (internal1) ? 1'b1 : 1'bz;
    assign internal2 = io1;
    
    // Complex inout with multiple drivers
    assign (strong0, strong1) io2 = (internal1) ? 1'b1 : 1'bz;
    assign (pull0, pull1) io2 = (internal2) ? 1'b0 : 1'bz;
    
    // Inout with bufif
    bufif1 inout_buf(io3, internal1, internal2);
    
    // Feedback loop through tristate
    assign internal1 = io3;
    
    // More complex inout pattern
    tri [3:0] complex_io;
    
    // Drive only when needed
    assign complex_io[0] = internal1 ? 1'b1 : 1'bz;
    assign complex_io[1] = internal2 ? 1'b0 : 1'bz;
    
    // Read when not driving
    assign internal1 = complex_io[2];
    assign internal2 = complex_io[3];
    
    // Pull specifications
    tri0 pull_down;
    tri1 pull_up;
    
    // Connect to non-tristates
    assign (weak0, weak1) pull_down = internal1 ? 1'b1 : 1'bz;
    assign (weak0, weak1) pull_up = internal2 ? 1'b0 : 1'bz;
endmodule
/* verilator lint_on MULTITOP */
