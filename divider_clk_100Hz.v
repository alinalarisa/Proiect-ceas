//clk din 100MHz in 100 Hz

module divider_clk_100Hz(clk_in, clk_out_q, rst);
//modific fout din 100 in 10 000 pentru un testbench mai rapid 
parameter fin = 100000000;
parameter fout = 10000;

parameter divider = fin / fout;
parameter lenght_counter = $clog2(divider);

input clk_in,rst;
output clk_out_q;

reg clk_d, clk_out_q;
reg [lenght_counter-1:0]counter_d;
reg [lenght_counter-1:0]counter_q;

//Combinational logic

always @(*)
begin
    clk_d = clk_out_q;
    counter_d = counter_q;
	
    if(counter_q == (divider - 1)/2)
    begin
        clk_d = ~clk_d;
        counter_d = {lenght_counter{1'b0}};
    end

    else
    if(counter_q < divider - 1)
    begin
        counter_d = counter_d + 1'd1;
    end
end

//flip-flop
always @ (posedge clk_in or posedge rst )
begin
    if(rst) //daca e 1 
	begin
        clk_out_q <= 1'd0;
        counter_q <= {lenght_counter{1'b0}};
	end	
    else 
	begin
            clk_out_q <= clk_d;
            counter_q <= counter_d;
	end
end

endmodule
