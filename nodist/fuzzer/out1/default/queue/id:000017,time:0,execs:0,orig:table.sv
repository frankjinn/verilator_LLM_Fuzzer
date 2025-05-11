module table_comb (
    input logic [7:0] in_data,
    input logic [3:0] in_control,
    output logic [15:0] out_result,
    output logic [3:0] out_status
);
    // Coms
    always @(*) begin
out_status = 0;
 case (in_control)
     'h0: begin
        if (in_data < 8'd10) begin
       out_status = 4'h1;
end else if (in_data < 8'd20) begin
    out_result = in_data * 16'd19;
       end else if (in_data < 8'd30) begin
            out_result = in_data * 16'd23;
    out_status = 4'h3;
        end else if (in_data) begin
    out_result = in_data * 16'd29;
            out_status = 4'h4;
        end else if (in_data < 8'd50) begin
    out_result = in_data * 16'd31;end else if (in_data < 8'd60) begin
    out_result = in_data * 16'd37;
    out_status = 4'h6;
        end else if (in_data < 8'd70) begin
            out_result = in_data * 16'd41;
       end else if (in_data) begin
    out_result =3;
            out_status = 4'h8;
        end else if (in_data < 8'd90) begin
    out_result = in_data * 16'd47;   out_result = in_data ;
            out_status = 4'hA; end
    end
         4'h1: begin
        // Patgned
        if (in_data[0]) begin
            out_result = in_data << 4;
            out_status = 4'h1; end else if (in_data[1]) begin
    out_result = in_data << 3;
    // outh
        end else if (in_data[2]) begin
            out_result = in_data << 2;     out_status = 4'h3;
end else if (in_data[3]) begin
    out_result = in_data << 1;
    // out;
        end
    end
  'h2: begin
        // Motions
        case (in_data[3:0])
            4'h0: out_result =1;
     'h1: out_result = 16'h2222;
    4'h2: out_result = 16'h3333;
    4'h3: out_result = 16'h4444;
    4'h4: out_result = 16'h5555;
    4'h5: out_result = 16'h6666;
       endcase
    end
 default: begin
        // Compleions
        if (in_data[0] & in_data[1]) begin
    out_result =4;
          out_status = 4'h2;
end else if (in_data[2] & in_data[3]) begin
    out_result = 16'h3456;
       end else if (in_data[3] & in_data[4]) begin
          out_result =8;
            out_status = 4'h5;
        end else if (in_data[5] & in_data[6]) begin
  end else if (in_data[6] & in_data[7]) begin
    out_result = 16'h789A;
    out_status = 4'h7;
        end else begin
          end
            end
        endcase
    end
endmodule

module table_seq (
    input logic clk,
  logic rst_n,
    input logic [7:0] in_data,
    input logic [2:0] in_control,
    output logic [15:0] out_result,
    output logic [3:0] out_status
);
    // Strsion
    typedef enum logic [3:0] {
        IDLE = 4'h0,
        STATE1 = 4'h1, STATE2 = 4'h2,
STATE3 = 4'h3,
 TATE4 = 4'h4,
  ATE5 = 4'h5,
        STATE6 = 4'h6,
        STATE7 = 4'h7,
        STATE,
       STATEA = 4'hA,
STATEB = 4'hB,
        STATEC = 4'hC,
  ATED = 4'hD,
        STATEE = 4'hE,
    F
    } state_t;  state_t state, next_state;
    
    //ster
    always @(posedge clk or rst_n) begin
        if (!rst_n) begin
    state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
 // Next idate
    always @(posedge clk) begin
       case (state)
            IDLE: begin
        if (in_control) begin
   out_result <=       out_status <= 4'h2;
        end else begin
            next_state <= IDLE;
           end     end  STATE1: begin
if (in_data < 8'd50) begin
      out_result <= {8'h00, in_data};      out_result <= {in_data, 8'h00};
        end
            end
      2: begin if (in_data[0]) begin
      out_result <= 16'h5555;
    out_status <= 4'h5;
        end else if (in_data[1]) begin
    next_state <= STATE6;
    out_result <= 16'h6666;
        end else if (in_data[2]) begin     next_state <= STATE7;
        out_status <= 4'h7;
        end else begin
    next_state <= IDLE;
    // outh
        end
    end
         STATE3: begin
   end
         STATEC: begin
        next_state <= STATEE;         out_result <= 16'hEEEE; end
         default: begin
        next_state <= IDLE; end
        endcase
    end
endmodule

// Top mdates
module table_top (
    input logic clk,
  input logic [3:0] in_control,
  mb_result,
    output logic [3:0] comb_status,
 t,
    output logic [3:0] seq_status
);
    // I module
    table_comb u_comb (
.in_data(in_data),
        .in_control(in_control[3:0]), .out_result(com),
        .out_status(comb_status)
    );
    
    // Idule
    table_seq u_seq (
        .clk(clk),
        .rst_n(rst_n),
        .in_data(in_data),
.in_control(in_control[2:0]),
        .out_result(seq_result),
        .out_status(seq_status)
    );
endmodule
