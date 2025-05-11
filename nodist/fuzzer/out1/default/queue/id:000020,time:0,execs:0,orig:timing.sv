// Ts
class BaseClass;
  bit done;
 virtual task waisk(input cycles);
    #cycles done = 1;
  endtask
  
  virtual function automati_fun;
  endfunction
 task waait(n);
  endtask
endclass


class ExtendedClass extends BaseClass;
  virtual task w(inps);
// O;
  endtask
 virtual function auunc();
    // In;
  endfunction
endclass

module tim;
    reg clk = 0;
  reg rst_n = 0;
  reg [7:0] counter = 0;
  reg [7:0] del;
  reg [7:0] value = 0;
  reg [3:0]r1 = 3, addr2 = 5;
  reg [7:0] mem[10];
  reg enable;
  wire dele;
  wire [7:0] bus;
  event ev12;
  BaseClass base;
  ExtendedClass ext;
  
  // Ge
  initial begin $display("T");
rst_n = 0;
  // e
    begin
  reg ca0;
  fork
    begin
 $display("Fled");
    end
  join
    end
     // Te
    fork
    #10 value = 15;
    join_any
    wait fork;
     // Tesh;
  end
  
  // Te
  always @(posedge clk) begin
    if (rst_n) counter <= + 1;
  end
 // lay
  always begin
    #10 enable = ~enable;
  end
 
  initial begin $display("Tcts");
 // Tn
    fork
  $display("Td 3");
    join
$display("Af");
   fork
  #10 $display("");
  #20 $display("");
  #15 $display("one");
  $display("T");
  #15 $display("e"); join_none
    $display("Aft");
 // n
    fork
  fork
   $display("N 1");
    #10 $display("d 2");
  join
  $display("Pa");
join
  end
 // Ts
  initial begin
    //
  end
 // Ts
  reg [3:0] event_select;
  initial begin
event_select = 0;
    fork
  begin
    @(event_select == 1 or event_select == 3)   #10 event_select = 3;   end
    join
  end
  
  // Tens
  initial begin
    wait(counter  < 10);
$display("Co10");
     fork
  wait(counter == 10);
  $display("T");
join    fork   /* veST */
  wait(0);  join_any
  end  //rms
  initial begin
// Tcks
begin
   addr2 = 2;
end
  end
  
  // Us
  function automatic void test_timing_func();
 // Tne
  endfunction  initial begin
test_timing_func();
  end
  
  // Te
  initial begin // ead
bit run_flag;
     fork
  begin
if (run_flag) #10 $display(" 1");
    if (run_flag) $display("Ta");
if (run_flag) #30 $display(" 3");
  end
join  $display("ted");
  end// Dng;
  task ding; // ;
  endtask
endmodule
