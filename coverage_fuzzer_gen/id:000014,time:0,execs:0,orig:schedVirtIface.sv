// Define an interface
interface MyInterface;
    logic data;
    logic valid;
    logic [7:0] addr;
    
    modport master (output data, output valid, output addr);
    modport slave (input data, input valid, input addr);
    
    // Task within interface to test interface methods
    task set_data(logic val);
        data = val;
    endtask
endinterface

// Module that writes to a virtual interface - using only non-blocking assignments
module VirtualIfWriter(input logic clk);
    // Virtual interface handle
    virtual MyInterface.master vif;
    
    logic toggle;
    logic [7:0] counter;
    
    initial begin
        toggle = 0;
        counter = 0;
        // Use separate initial blocks for virtual interface initialization
    end
    
    // Initial block for interface initialization - using blocking assignments
    initial begin
        vif.data = 0;         // Changed from <= to =
        vif.valid = 0;        // Changed from <= to =
        vif.addr = 0;         // Changed from <= to =
    end
    
    // Test sequential write to virtual interface
    always @(posedge clk) begin
        toggle <= ~toggle;
        vif.data <= toggle;
        counter <= counter + 1;
    end
    
    // Test combinational write to virtual interface - still use non-blocking
    always @(toggle) begin
        vif.valid <= toggle;  // Non-blocking to match other assignments
    end
    
    // Test control structures with virtual interface writes
    always @(posedge clk) begin
        // If/else with virtual interface writes
        if (toggle) begin
            vif.addr[0] <= 1'b1;
        end else begin
            vif.addr[0] <= 1'b0;
        end
    end
    
    // Separate always block for a different signal
    always @(posedge clk) begin
        // Loop with interface writes
        for (int i = 1; i < 3; i++) begin
            vif.addr[i] <= counter[i];
        end
    end
    
    // Test AssignPost behavior
    always @(posedge clk) begin
        vif.addr[7:4] <= vif.addr[7:4] + 1; // Should convert to AlwaysPost
    end
endmodule

// Module that reads from a virtual interface
module VirtualIfReader(input logic clk);
    virtual MyInterface.slave vif;
    
    logic internal_data;
    logic [7:0] internal_addr;
    
    // Read from virtual interface
    always @(posedge clk) begin
        internal_data <= vif.data;
        
        // Control structure reading from virtual interface
        if (vif.valid) begin
            internal_addr <= vif.addr;
        end
    end
endmodule

// Top module to connect everything
module top;
    logic clk = 0;
    
    // Generate clock
    always #5 clk = ~clk;
    
    // Instantiate interface
    MyInterface intf();
    
    // Instantiate modules
    VirtualIfWriter writer(.clk(clk));
    VirtualIfReader reader(.clk(clk));
    
    // Connect virtual interfaces
    initial begin
        writer.vif = intf;
        reader.vif = intf;
        
        // Test interface method
        #20 intf.set_data(1'b1);
        
        // Run simulation
        #100 $finish;
    end
endmodule
