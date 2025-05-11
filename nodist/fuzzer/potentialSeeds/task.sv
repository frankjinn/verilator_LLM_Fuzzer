module task_test;
    // Basic variables for testing
    int a, b, c, d;
    int arr[10];
    logic [31:0] vec;
    string str;
    byte bytes[10];
    
    // Basic function with arguments and return
    function int add(int x, int y);
        return x + y;
    endfunction

    // Function with default arguments
    function int add_default(int x, int y = 5);
        return x + y;
    endfunction

    // Function with output arguments
    function void swap(ref int x, ref int y);
        int temp;
        temp = x;
        x = y;
        y = temp;
    endfunction

    // Task with complex arguments - fixed size array to match local_arr
    task process_array(input int size, ref int data[10]);
        for (int i = 0; i < size; i++) begin
            data[i] = data[i] * 2;
        end
    endtask

    // Task with default arguments
    task delay_task(input int cycles = 10);
        repeat (cycles) @(posedge clk);
    endtask

    // Function marked with pragma for no inline
    function int multiply(int x, int y);
        `pragma no_inline_task
        return x * y;
    endfunction

    // DPI import function
    import "DPI-C" function int c_function(input int value);

    // DPI export function
    export "DPI-C" function v_function;
    function int v_function(input int value);
        return value * 2;
    endfunction

    // DPI context function
    import "DPI-C" context function void c_context_function(input int value);

    // Class with methods to test method handling
    class MyClass;
        int value;
        
        function new(int init_val = 0);
            value = init_val;
        endfunction
        
        function int get_value();
            return value;
        endfunction
        
        function void set_value(int val);
            value = val;
        endfunction
        
        static function int static_func(int x);
            return x * 2;
        endfunction
    endclass

    // Simple square function (replaced "with" statement with direct calculation)
    function int square_test(int x);
        return x * x;
    endfunction

    // Varying argument types for DPI testing
    bit [7:0] bits8;
    shortint shorts;
    int ints;
    longint longs;
    byte byteval;
    bit bit1;
    logic logic1;
    chandle handle;
    real realval;
    real shortreal_val; // Changed from shortreal to real as recommended
    
    // Complex DPI import with multiple argument types
    import "DPI-C" function int c_complex_function(
        input bit[7:0] a,
        input shortint b,
        input int c,
        input longint d,
        input byte e,
        input bit f,
        input logic g,
        input chandle h,
        output int i
    );
    
    // Recursive function test
    function int factorial(int n);
        if (n <= 1) return 1;
        else return n * factorial(n-1);
    endfunction
    
    // Test pure DPI functions
    import "DPI-C" pure function int c_pure_function(input int value);
    
    // Function with complex return type
    function logic [63:0] complex_return(input logic [31:0] a, input logic [31:0] b);
        return {a, b};
    endfunction
    
    // Logic to exercise all the above functions/tasks
    initial begin
        int result, x, y;
        logic [63:0] big_result;
        MyClass obj;
        int output_val;
        int local_arr[10];
        
        // Test basic function
        result = add(10, 20);
        $display("Add result: %d", result);
        
        // Test function with default args
        result = add_default(10);
        $display("Default arg result: %d", result);
        result = add_default(10, 15);
        $display("Explicit args result: %d", result);
        
        // Test ref args
        x = 5; y = 10;
        swap(x, y);
        $display("After swap: x=%d, y=%d", x, y);
        
        // Test array processing
        for (int i = 0; i < 10; i++) local_arr[i] = i;
        process_array(10, local_arr);
        
        // Test no_inline function
        result = multiply(6, 7);
        $display("Multiply result: %d", result);
        
        // Test DPI functions
        result = c_function(42);
        c_context_function(100);
        result = v_function(25);
        
        // Test class methods
        obj = new(42);
        result = obj.get_value();
        obj.set_value(100);
        result = obj.get_value();
        result = MyClass::static_func(50);
        
        // Test square function (previously with statement)
        result = square_test(7);
        
        // Test complex DPI function
        bits8 = 8'hAA;
        shorts = 1000;
        ints = 100000;
        longs = 1000000;
        byteval = 8'h55;
        bit1 = 1;
        logic1 = 0;
        handle = null;
        
        // Store return value to avoid warning
        result = c_complex_function(bits8, shorts, ints, longs, byteval, bit1, logic1, handle, output_val);
        
        // Test recursive function
        result = factorial(5);
        
        // Test complex return
        big_result = complex_return(32'hAAAAAAAA, 32'h55555555);
        
        // Named argument calls
        result = add(.y(30), .x(40));
        
        // Multiple ways to call functions
        a = add(10, 20);
        b = add(10, add(20, 30));
        
        // Store result to avoid warning
        result = add(10, 20);
        
        // Check automatic variables
        begin
            automatic int auto_var = 10;
            auto_var = auto_var + 1;
        end
    end

    // Clock generation for testing delay_task
    bit clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        delay_task();        // Use default
        delay_task(5);       // Explicit value
    end
    
    // Fix: Remove function call from sensitivity list, use signals instead
    wire test_wire;
    always @(a, b) begin  // Changed from @(add(a, b))
        c = a + b;
    end
    
    // Test assigning to wire (will convert to always)
    assign test_wire = (add(a, b) > 0);
    
endmodule
