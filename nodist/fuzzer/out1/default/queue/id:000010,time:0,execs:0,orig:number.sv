module nst;
// Dhs
    logic [31:0] a = 32'hBEEF;   // Ht
    logic [31:0] b = 310; // Bes
    logic [31:0] c = 3210;    logic [31:0] d = 32789;  //
    logic [3:0] e = 4'b10x1;   logic [3:0] f = 4'b10z1; //  Z
    logic g =1;    logic signed [31:0] h = -35;     // Sion
    logic j = '0;// S
    logic [63:0] sum = b;    logic [63:0] diff = a - b;   // Sun
    logic [63:0] prod = a * b;   // Mu
    logic [63:0] quo = b;    //n
    logic [63:0] rem = b;    // Mos
    logic [63:0] pw = a ** 3;  // ns
    logic [31:0] bitwiseAnd = b; // AND
    logic [31:0] bitwiseOr = b;    logic [31:0] bitwiseXor = b;     // XOR
    logic [31:0] bitwiseNot = ~a; logic [31:0]ftR = a ;    // ght
logic signed [31:0] tRS = h >>> 4;   // 
    logic [63:0] co = {a, b};    //on
    logic [127:0]te = {4{a}}; logic [7:0]ce = a[15:8];      // Eqty
    logic isN= (a != b);    // Rers
    real r1 = 123;      real r2 = -45.67;// N
    real rsum =+ r2;     //on
    real rdiff =  r2;// Rion
real rprod = r1 ;    // ion
real rquo =  r2; // n
    real r= r1 ** 2.0;   // Re9)
    logic [15:0] DEF12;  // Tg
  string str1 = "H";
    string str2 = "World";
    string strConcat = {str1, 2};    // Ston
    string strReplicate = {3{str1}};    // St
    logic strEq = (str1 == "Hello");    logic sq = (str1 !=2);   //ty
    logic strGt = (str1 >2); // Ss
    int len = str1.len();    // Le
    byte char_val = str1.getc(1);    //e)
    string s = str1.substr(1, 3);// Sns
    logic [19:0] stream =0;
    logic [19:0] amR = {<<4{stream}};// S
    logic logicalAnd = (a != 0) && (b != 0); //
    logic logicalOr = (b != 0);logic logicalNot = !(a != 0);    // ons
logic on = $onehot(800);logic onehot0 = $onehot0(8'b0000);   // 
    int clog2val = $clog2(255);   // Sions
logic signed [31:0] signedA = -1000; logic signed [31:0] signedB = 300;
logic signed [31:0] signedSum = signedA + signedB;
    logic[31:0] signedGt = signedA > signedB;  //n
    logic [0:0] zeb1;
 // 
    initial begin
    $display("Tess:");
    $display(" %d", a,);
    $display("Wit %b", e, f); $display("Sd", );
    $display("Aut=%b", j,);
 $display("\ns:");
    $display("", sum, , prod); $display("Qh", );
 $display("\nns:");
    $display("AND%h", bitwiseAnd, bitwiseOr, bitwiseXor, bitwiseNot);  $display("%s",1, str2);
    $display("%s", strConcat, strReplicate);
  $display("L %s", len, char_val, s);  $display("");
$display("St%b",);
 $display("\nns:");
    $display("Logb", logicalAnd, logicalOr, logicalNot);
 $display("\ %d", onehot0, clog2val);
     $display("\nS:"); $display("S", signedSum, signedGt);for (int i = 0; 32; i += 8) begin
    $display("%b",a[i]);
    end
 // T;
    $display(" %b"=== b);
$display("a b", a !== b);
    $display("b", e ==? 4'b1xx1);
$display("e  %b", e !=? 4'b1xx1);
     // Te
    end
endmodule
