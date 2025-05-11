module table_comb (
    input logic [7:0] in_data,
    input logic [3:0] in_control,
    output logic [15:0] out_result,
    output logic [3:0] out_status
);
    // Complex combinational always block that should convert to a table
    // Has many instructions relative to input/output bits
    always @(*) begin
        out_result = 0;
        out_status = 0;
        
        case (in_control)
            4'h0: begin
                if (in_data < 8'd10) begin
                    out_result = in_data * 16'd17;
                    out_status = 4'h1;
                end else if (in_data < 8'd20) begin
                    out_result = in_data * 16'd19;
                    out_status = 4'h2;
                end else if (in_data < 8'd30) begin
                    out_result = in_data * 16'd23;
                    out_status = 4'h3;
                end else if (in_data < 8'd40) begin
                    out_result = in_data * 16'd29;
                    out_status = 4'h4;
                end else if (in_data < 8'd50) begin
                    out_result = in_data * 16'd31;
                    out_status = 4'h5;
                end else if (in_data < 8'd60) begin
                    out_result = in_data * 16'd37;
                    out_status = 4'h6;
                end else if (in_data < 8'd70) begin
                    out_result = in_data * 16'd41;
                    out_status = 4'h7;
                end else if (in_data < 8'd80) begin
                    out_result = in_data * 16'd43;
                    out_status = 4'h8;
                end else if (in_data < 8'd90) begin
                    out_result = in_data * 16'd47;
                    out_status = 4'h9;
                end else begin
                    out_result = in_data * 16'd53;
                    out_status = 4'hA;
                end
            end
            
            4'h1: begin
                // Path where not all outputs are assigned
                if (in_data[0]) begin
                    out_result = in_data << 4;
                    out_status = 4'h1;
                end else if (in_data[1]) begin
                    out_result = in_data << 3;
                    // out_status not assigned in this path
                end else if (in_data[2]) begin
                    out_result = in_data << 2;
                    out_status = 4'h3;
                end else if (in_data[3]) begin
                    out_result = in_data << 1;
                    // out_status not assigned in this path
                end else begin
                    out_result = in_data;
                    out_status = 4'h5;
                end
            end
            
            4'h2: begin
                // More complex operations
                case (in_data[3:0])
                    4'h0: out_result = 16'h1111;
                    4'h1: out_result = 16'h2222;
                    4'h2: out_result = 16'h3333;
                    4'h3: out_result = 16'h4444;
                    4'h4: out_result = 16'h5555;
                    4'h5: out_result = 16'h6666;
                    4'h6: out_result = 16'h7777;
                    4'h7: out_result = 16'h8888;
                    4'h8: out_result = 16'h9999;
                    4'h9: out_result = 16'hAAAA;
                    4'hA: out_result = 16'hBBBB;
                    4'hB: out_result = 16'hCCCC;
                    4'hC: out_result = 16'hDDDD;
                    4'hD: out_result = 16'hEEEE;
                    4'hE: out_result = 16'hFFFF;
                    4'hF: out_result = 16'h0000;
                endcase
                
                case (in_data[7:4])
                    4'h0: out_status = 4'h0;
                    4'h1: out_status = 4'h1;
                    4'h2: out_status = 4'h2;
                    4'h3: out_status = 4'h3;
                    4'h4: out_status = 4'h4;
                    4'h5: out_status = 4'h5;
                    4'h6: out_status = 4'h6;
                    4'h7: out_status = 4'h7;
                    4'h8: out_status = 4'h8;
                    4'h9: out_status = 4'h9;
                    4'hA: out_status = 4'hA;
                    4'hB: out_status = 4'hB;
                    4'hC: out_status = 4'hC;
                    4'hD: out_status = 4'hD;
                    4'hE: out_status = 4'hE;
                    4'hF: out_status = 4'hF;
                endcase
            end
            
            default: begin
                // Complex nested if-else to create more instructions
                if (in_data[0] & in_data[1]) begin
                    out_result = 16'h1234;
                    out_status = 4'h1;
                end else if (in_data[1] & in_data[2]) begin
                    out_result = 16'h2345;
                    out_status = 4'h2;
                end else if (in_data[2] & in_data[3]) begin
                    out_result = 16'h3456;
                    out_status = 4'h3;
                end else if (in_data[3] & in_data[4]) begin
                    out_result = 16'h4567;
                    out_status = 4'h4;
                end else if (in_data[4] & in_data[5]) begin
                    out_result = 16'h5678;
                    out_status = 4'h5;
                end else if (in_data[5] & in_data[6]) begin
                    out_result = 16'h6789;
                    out_status = 4'h6;
                end else if (in_data[6] & in_data[7]) begin
                    out_result = 16'h789A;
                    out_status = 4'h7;
                end else begin
                    out_result = 16'h89AB;
                    out_status = 4'h8;
                end
            end
        endcase
    end
endmodule

module table_seq (
    input logic clk,
    input logic rst_n,
    input logic [7:0] in_data,
    input logic [2:0] in_control,
    output logic [15:0] out_result,
    output logic [3:0] out_status
);
    // State machine with lots of states - good candidate for table conversion
    typedef enum logic [3:0] {
        IDLE = 4'h0,
        STATE1 = 4'h1,
        STATE2 = 4'h2,
        STATE3 = 4'h3,
        STATE4 = 4'h4,
        STATE5 = 4'h5,
        STATE6 = 4'h6,
        STATE7 = 4'h7,
        STATE8 = 4'h8,
        STATE9 = 4'h9,
        STATEA = 4'hA,
        STATEB = 4'hB,
        STATEC = 4'hC,
        STATED = 4'hD,
        STATEE = 4'hE,
        STATEF = 4'hF
    } state_t;
    
    state_t state, next_state;
    
    // Sequential block for state register
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state and output logic - good table candidate
    always @(posedge clk) begin
        // Default values
        out_result <= 16'h0000;
        out_status <= 4'h0;
        
        case (state)
            IDLE: begin
                if (in_control == 3'h0) begin
                    next_state <= STATE1;
                    out_result <= 16'h1111;
                    out_status <= 4'h1;
                end else if (in_control == 3'h1) begin
                    next_state <= STATE2;
                    out_result <= 16'h2222;
                    out_status <= 4'h2;
                end else begin
                    next_state <= IDLE;
                    // Default values used
                end
            end
            
            STATE1: begin
                if (in_data < 8'd50) begin
                    next_state <= STATE3;
                    out_result <= {8'h00, in_data};
                    out_status <= 4'h3;
                end else begin
                    next_state <= STATE4;
                    out_result <= {in_data, 8'h00};
                    out_status <= 4'h4;
                end
            end
            
            STATE2: begin
                if (in_data[0]) begin
                    next_state <= STATE5;
                    out_result <= 16'h5555;
                    out_status <= 4'h5;
                end else if (in_data[1]) begin
                    next_state <= STATE6;
                    out_result <= 16'h6666;
                    out_status <= 4'h6;
                end else if (in_data[2]) begin
                    next_state <= STATE7;
                    out_result <= 16'h7777;
                    out_status <= 4'h7;
                end else begin
                    next_state <= IDLE;
                    // out_status not assigned in this path
                end
            end
            
            STATE3: begin
                next_state <= STATE8;
                out_result <= 16'h8888;
                out_status <= 4'h8;
            end
            
            STATE4: begin
                next_state <= STATE9;
                out_result <= 16'h9999;
                out_status <= 4'h9;
            end
            
            STATE5: begin
                next_state <= STATEA;
                out_result <= 16'hAAAA;
                out_status <= 4'hA;
            end
            
            STATE6: begin
                next_state <= STATEB;
                out_result <= 16'hBBBB;
                out_status <= 4'hB;
            end
            
            STATE7: begin
                next_state <= STATEC;
                out_result <= 16'hCCCC;
                out_status <= 4'hC;
            end
            
            STATE8, STATE9: begin
                next_state <= STATED;
                out_result <= 16'hDDDD;
                out_status <= 4'hD;
            end
            
            STATEA, STATEB, STATEC: begin
                next_state <= STATEE;
                out_result <= 16'hEEEE;
                out_status <= 4'hE;
            end
            
            default: begin
                next_state <= IDLE;
                out_result <= 16'hFFFF;
                out_status <= 4'hF;
            end
        endcase
    end
endmodule

// Top module that instantiates both table candidates
module table_top (
    input logic clk,
    input logic rst_n,
    input logic [7:0] in_data,
    input logic [3:0] in_control,
    output logic [15:0] comb_result,
    output logic [3:0] comb_status,
    output logic [15:0] seq_result,
    output logic [3:0] seq_status
);
    // Instantiate combinational module
    table_comb u_comb (
        .in_data(in_data),
        .in_control(in_control[3:0]),
        .out_result(comb_result),
        .out_status(comb_status)
    );
    
    // Instantiate sequential module
    table_seq u_seq (
        .clk(clk),
        .rst_n(rst_n),
        .in_data(in_data),
        .in_control(in_control[2:0]),
        .out_result(seq_result),
        .out_status(seq_status)
    );
endmodule
