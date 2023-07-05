module tb_electronic_lock;
  wire [2:0]t_st;
  wire t_out;
  reg t_b0, t_b1, t_clk, t_rst, temp ;
  integer i=0;
  reg [18:0]data;
  
  electronic_lock m(t_clk, t_rst, t_b0, t_b1, t_out,t_st);
  always #10 t_clk= ~t_clk;
  
  initial begin
    $dumpfile("tb_electronic_lock.vcd");
    $dumpvars(1,tb_electronic_lock);
    $monitor(" i= %0d, Time= %0d, b0=%b, b1=%b, out= %b state=%d", i,$time,t_b0,t_b1,t_out,t_st);
    t_clk=0;
    t_rst =1;
    data = 19'b1101010110101101011 ;
    #20 t_rst = 0;
    #350 $finish;
  end
  
  always @(posedge t_clk) begin
    data<= data>>1 ;
    temp = #10 data[0];
    case(temp)
      0 : begin t_b0 <= 1; t_b1 <=0; end
      1 : begin t_b0 <=0 ; t_b1 <= 1; end
    endcase
    i=i+1;
  end
endmodule
