module task_test;
    int a, b, c, d;
    int arr[10];
    logic [31:0] vec;
    string str;
    byte bytes[10];
    function int add(int x, int y);
        return x + y;
    endfunction
    function int add_default(int x, int y = 5);
        return x + y;
    endfunction
    function void swap(ref int x, ref int y);
        int temp;
        temp = x;
        x = y;
        y = temp;
    endfunction
    task process_array(input int size, ref int data[10]);
        for (int i = 0; i < size; i++) begin
            data[i] = data[i] * 2;
        end
    endtask
    task delay_task(input int cycles = 10);
        repeat (cycles) @(posedge clk);
    endtask
    function int multiply(int x, int y);
        `pragma no_inline_task
        return x * y;
    endfunction
    import "DPI-C" function int c_function(input int value);
    export "DPI-C" function v_function;
    function int v_function(input int value);
        return value * 2;
    endfunction
    import "DPI-C" context function void c_context_function(input int value);
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
    function int square_test(int x);
        return x * x;
    endfunction
    bit [7:0] bits8;
    shortint shorts;
    int ints;
    longint longs;
    byte byteval;
    bit bit1;
    logic logic1;
    chandle handle;
    real realval;
    real shortreal_val;
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
    function int factorial(int n);
        if (n <= 1) return 1;
        else return n * factorial(n-1);
    endfunction
    import "DPI-C" pure function int c_pure_function(input int value);
    function logic [63:0] complex_return(input logic [31:0] a, input logic [31:0] b);
        return {a, b};
    endfunction
    initial begin
        int result, x, y;
        logic [63:0] big_result;
        MyClass obj;
        int output_val;
        int local_arr[10];
        result = add(10, 20);
        $display("Add result: %d", result);
        result = add_default(10);
        $display("Default arg result: %d", result);
        result = add_default(10, 15);
        $display("Explicit args result: %d", result);
        x = 5; y = 10;
        swap(x, y);
        $display("After swap: x=%d, y=%d", x, y);
        for (int i = 0; i < 10; i++) local_arr[i] = i;
        process_array(10, local_arr);
        result = multiply(6, 7);
        $display("Multiply result: %d", result);
        result = c_function(42);
        c_context_function(100);
        result = v_function(25);
        obj = new(42);
        result = obj.get_value();
        obj.set_value(100);
        result = obj.get_value();
        result = MyClass::static_func(50);
        result = square_test(7);
        bits8 = 8'hAA;
        shorts = 1000;
        ints = 100000;
        longs = 1000000;
        byteval = 8'h55;
        bit1 = 1;
        logic1 = 0;
        handle = null;
        result = c_complex_function(bits8, shorts, ints, longs, byteval, bit1, logic1, handle, output_val);
        result = factorial(5);
        big_result = complex_return(32'hAAAAAAAA, 32'h55555555);
        result = add(.y(30), .x(40));
        a = add(10, 20);
        b = add(10, add(20, 30));
        result = add(10, 20);
        begin
            automatic int auto_var = 10;
            auto_var = auto_var + 1;
        end
    end
    bit clk = 0;
    always #5 clk = ~clk;
    initial begin
        delay_task();
        delay_task(5);
    end
    wire test_wire;
    always @(a, b) begin
        c = a + b;
    end
    assign test_wire = (add(a, b) > 0);
endmodule
