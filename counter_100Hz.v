module counter_100HZ(
			clk_100,
			rst,//active high
			sel_q
			);
		
//---------------input signals-------------					
input clk_100;
input rst;

//---------------output signals-------------
output reg [1:0]sel_q;
reg [1:0]sel_d;

always @(posedge clk_100 or posedge rst)
begin
    if(rst)
    begin
        sel_q <= 2'd0;
    end
    else
    begin
        sel_q <= sel_d;
    end   
end	
always @(*)
begin
    sel_d = sel_q;
    if(sel_q < 3'd4)
        begin
            sel_d = sel_d + 1'd1;
        end
    else
    begin
        sel_d = 2'd0;
    end
end						
endmodule