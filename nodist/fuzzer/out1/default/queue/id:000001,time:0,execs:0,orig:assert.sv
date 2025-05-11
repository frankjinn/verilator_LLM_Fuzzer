module at (
input wire clk,
input wire rst_n,
    input  [3:0] data_in,
output reg [3:0] data_out
);  //ic
    reg [3:0] counter;
    reg [3:0] prev_data;
 // Bc
    always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin counter <=  prev_data <= 4'b0000;
    data_out <= 400;
   counter <= counter +   prev_data <= data_in;
data_out <= data_in; end end  //s
    always @(posedge clk) begin
   // );
    end

// Ctor
reg [3:0] data_in_prev;
always @(posedge clk) begin
data_in_prev <= data_in; assert (data_in_prev == prev_data)  else $display("ch");
    end
     // Temas
always @(*) begin
    //es
    unique case (data_in[1:0])
    2'b00: $display("C00");
    2'b01: $display("C01");
    2'b10: $display("C10");
    2'b11: $display("C11");
    endcase
     // un
    unique0 case (data_in)
000: $display("D");
001: $display("D");
100: $display("D");
000: $display("D");
default: $display("Olue");
    endcase
 // pity
 case (1'b1) data_in[3]: $display("Bset");
    data_in[2]: $display("Bitt"); data_in[1]: $display("Bset"); 
data_in[0]: $display("Biet");
    default: $display("No ");
endcase
 // d
    case (data_in) // );
    default: $display("Ote"); endcase  //s
    casez (data_in)
    //);
    default: $display("Not"); endcase end  //es
    initial begin $display("N=%h", data_in, counter);  #20 $monitoron;
    end
     // Usty
    reg [3:0] data_in_sampled;
    always @(posedge clk) begin
    data_in_sampled <= data_in;
    if (data_in_sampled != data_in) begin
$display("Da");
end
end
 // or
    initial begin // d
    end
     // Re
endmodule