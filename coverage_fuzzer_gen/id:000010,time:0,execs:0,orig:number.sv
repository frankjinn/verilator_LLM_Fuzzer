module number_test;
    // Different number formats and widths
    logic [31:0] a = 32'hDEADBEEF;           // Hex format
    logic [31:0] b = 32'b1010_1010_1010_1010_1010_1010_1010_1010; // Binary with underscores
    logic [31:0] c = 32'o76543210;           // Octal
    logic [31:0] d = 32'd123456789;          // Decimal
    logic [3:0] e = 4'b10x1;                 // With X
    logic [3:0] f = 4'b10z1;                 // With Z
    logic g = 1'b1;                          // Single bit
    logic signed [31:0] h = -32'sd12345;     // Signed number
    
    // Auto-extension
    logic j = '0;                            // SystemVerilog unsized 0
    logic k = '1;                            // SystemVerilog unsized 1
    logic l = 'x;                            // SystemVerilog unsized x
    logic m = 'z;                            // SystemVerilog unsized z
    
    // Test operations
    // Arithmetic
    logic [63:0] sum = a + b;                // Addition
    logic [63:0] diff = a - b;               // Subtraction
    logic [63:0] prod = a * b;               // Multiplication
    logic [63:0] quo = a / b;                // Division
    logic [63:0] rem = a % b;                // Modulus
    logic [63:0] pw = a ** 3;                // Power
    
    // Bitwise operations
    logic [31:0] bitwiseAnd = a & b;         // AND
    logic [31:0] bitwiseOr = a | b;          // OR
    logic [31:0] bitwiseXor = a ^ b;         // XOR
    logic [31:0] bitwiseNot = ~a;            // NOT
    
    // Reduction operations
    logic redAnd = &a;                       // Reduction AND
    logic redOr = |a;                        // Reduction OR
    logic redXor = ^a;                       // Reduction XOR
    
    // Shift operations
    logic [31:0] shiftL = a << 4;            // Shift left
    logic [31:0] shiftR = a >> 4;            // Shift right
    logic signed [31:0] shiftRS = h >>> 4;   // Arithmetic shift right
    
    // Concatenation and replication
    logic [63:0] concat = {a, b};            // Concatenation
    logic [127:0] replicate = {4{a}};        // Replication
    
    // Bit selection
    logic [7:0] slice = a[15:8];             // Bit selection
    
    // Comparison
    logic isEqual = (a == b);                // Equality
    logic isNotEqual = (a != b);             // Inequality
    logic isGreater = (a > b);               // Greater than
    logic isLess = (a < b);                  // Less than
    logic isGreaterOrEqual = (a >= b);       // Greater than or equal
    logic isLessOrEqual = (a <= b);          // Less than or equal
    
    // Real numbers
    real r1 = 123.456;                       // Real number
    real r2 = -45.67;                        // Negative real
    real rsum = r1 + r2;                     // Real addition
    real rdiff = r1 - r2;                    // Real subtraction
    real rprod = r1 * r2;                    // Real multiplication
    real rquo = r1 / r2;                     // Real division
    real rpow = r1 ** 2.0;                   // Real power
    
    // Integer to real conversion
    real i2r = a;                            // Integer to real
    
    // Real to integer conversion
    logic [31:0] r2i = int'(r1);             // Real to integer
    
    // 4-state bit operations
    logic [3:0] xorWithX = e ^ 4'b0101;      // XOR with X
    logic [3:0] andWithZ = f & 4'b1111;      // AND with Z
    
    // Edge cases
    logic [31:0] divByZero = a / 0;          // Division by zero
    logic [127:0] largeNumber = 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF; // Large number
    logic [31:0] outOfRange = largeNumber[127:96]; // Upper 32 bits selection (was 200:169)
    logic [15:0] truncation = 32'hABCDEF12;  // Truncation warning
    
    // String operations
    string str1 = "Hello";
    string str2 = "World";
    string strConcat = {str1, " ", str2};    // String concatenation
    string strReplicate = {3{str1}};         // String replication
    
    // String comparisons
    logic strEq = (str1 == "Hello");         // String equality
    logic strNeq = (str1 != str2);           // String inequality
    logic strGt = (str1 > str2);             // String greater than
    
    // Special string methods
    int len = str1.len();                    // Length
    byte char_val = str1.getc(1);            // Get character (renamed from c to avoid duplicate)
    string s = str1.substr(1, 3);            // Substring
    
    // Bit stream operations
    logic [19:0] stream = 20'b10110011101001011010;
    logic [19:0] streamR = {<<4{stream}};    // Stream left (4-bits at a time)
    
    // Logical operations
    logic logicalAnd = (a != 0) && (b != 0); // Logical AND
    logic logicalOr = (a != 0) || (b != 0);  // Logical OR
    logic logicalNot = !(a != 0);            // Logical NOT
    
    // Misc operations
    logic onehot = $onehot(8'b00010000);     // One hot
    logic onehot0 = $onehot0(8'b00000000);   // One hot zero
    int clog2val = $clog2(255);              // Ceiling log2
    
    // Signed operations
    logic signed [31:0] signedA = -1000;
    logic signed [31:0] signedB = 300;
    logic signed [31:0] signedSum = signedA + signedB;
    logic signed [31:0] signedGt = signedA > signedB;
    
    // Zero width operation
    logic [0:0] zeroWidth = 1'b1;
    
    // Add this declaration at the module level
    string hex_str = "FF"; // Add the string variable declaration here
    
    initial begin
        $display("Testing different number formats:");
        $display("Hex: %h, Binary: %b, Octal: %o, Decimal: %d", a, b, c, d);
        $display("With X: %b, With Z: %b", e, f);
        $display("Single bit: %b, Signed: %d", g, h);
        $display("Auto-extension: '0=%b, '1=%b, 'x=%b, 'z=%b", j, k, l, m);
        
        $display("\nArithmetic operations:");
        $display("Sum: %h, Difference: %h, Product: %h", sum, diff, prod);
        $display("Quotient: %h, Remainder: %h, Power: %h", quo, rem, pw);
        
        $display("\nBitwise operations:");
        $display("AND: %h, OR: %h, XOR: %h, NOT: %h", bitwiseAnd, bitwiseOr, bitwiseXor, bitwiseNot);
        
        $display("\nReduction operations:");
        $display("Reduction AND: %b, Reduction OR: %b, Reduction XOR: %b", redAnd, redOr, redXor);
        
        $display("\nShift operations:");
        $display("Shift left: %h, Shift right: %h, Arithmetic shift right: %h", shiftL, shiftR, shiftRS);
        
        $display("\nConcatenation and replication:");
        $display("Concatenation: %h, Replication: %h", concat, replicate);
        
        $display("\nBit selection:");
        $display("Slice: %h", slice);
        
        $display("\nComparison:");
        $display("Equal: %b, Not equal: %b", isEqual, isNotEqual);
        $display("Greater: %b, Less: %b", isGreater, isLess);
        $display("Greater or equal: %b, Less or equal: %b", isGreaterOrEqual, isLessOrEqual);
        
        $display("\nReal numbers:");
        $display("r1: %f, r2: %f", r1, r2);
        $display("Sum: %f, Difference: %f", rsum, rdiff);
        $display("Product: %f, Quotient: %f, Power: %f", rprod, rquo, rpow);
        
        $display("\nConversion:");
        $display("Integer to real: %f, Real to integer: %d", i2r, r2i);
        
        $display("\n4-state bit operations:");
        $display("XOR with X: %b, AND with Z: %b", xorWithX, andWithZ);
        
        $display("\nEdge cases:");
        $display("Division by zero: %h", divByZero);
        $display("Large number: %h", largeNumber);
        $display("Out of range: %h, Truncation: %h", outOfRange, truncation);
        
        $display("\nString operations:");
        $display("str1: %s, str2: %s", str1, str2);
        $display("Concatenation: %s, Replication: %s", strConcat, strReplicate);
        
        $display("\nString comparisons:");
        $display("Equal: %b, Not equal: %b, Greater than: %b", strEq, strNeq, strGt);
        
        $display("\nSpecial string methods:");
        $display("Length: %d, Character: %c, Substring: %s", len, char_val, s);
        
        $display("\nBit stream operations:");
        $display("Stream: %b, Stream right: %b", stream, streamR);
        
        $display("\nLogical operations:");
        $display("Logical AND: %b, Logical OR: %b, Logical NOT: %b", logicalAnd, logicalOr, logicalNot);
        
        $display("\nMisc operations:");
        $display("One hot: %b, One hot zero: %b, clog2: %d", onehot, onehot0, clog2val);
        
        $display("\nSigned operations:");
        $display("Signed a: %d, Signed b: %d", signedA, signedB);
        $display("Signed sum: %d, Signed greater than: %b", signedSum, signedGt);
        
        $display("\nZero width operation:");
        $display("Zero width: %b", zeroWidth);
        
        // Dynamic bit selection
        for (int i = 0; i < 32; i += 8) begin
            $display("Bit %d: %b", i, a[i]);
        end
        
        // Test case equality and wildcard equality
        $display("\nCase equality:");
        $display("a === b: %b", a === b);
        $display("a !== b: %b", a !== b);
        $display("e ==? 4'b1xx1: %b", e ==? 4'b1xx1);
        $display("e !=? 4'b1xx1: %b", e !=? 4'b1xx1);
        
        // Test number conversions
        $display("\nNumber conversions:");
        $display("Binary to ASCII: %s", $sformatf("%b", a));
        $display("Hex to ASCII: %s", $sformatf("%h", a));
        $display("Octal to ASCII: %s", $sformatf("%o", a));
        $display("Decimal to ASCII: %s", $sformatf("%d", a));
        
        // Test mathematical functions
        $display("\nMathematical functions:");
        $display("$ln(10.0) = %f", $ln(10.0));
        $display("$log10(100.0) = %f", $log10(100.0));
        $display("$exp(1.0) = %f", $exp(1.0));
        $display("$sqrt(25.0) = %f", $sqrt(25.0));
        $display("$pow(2.0, 10.0) = %f", $pow(2.0, 10.0));
        $display("$floor(3.7) = %f", $floor(3.7));
        $display("$ceil(3.2) = %f", $ceil(3.2));
        
        // Test string conversion functions
        $display("\nString conversion functions:");
        $display("Decimal string to integer: %d", str1.atoi());
        
        // Use the pre-declared variable instead of trying to declare it here
        $display("Hex string to integer: %d", hex_str.atohex());
    end
endmodule
