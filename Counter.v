module counter
		(	clk		,
			rst		,
			minut	,
			secunda	,
			ora		,
			enable	,
			load	,
			ora_setata,
			min_setat
		);
input clk;
input rst;
input enable;
input load;
input [4:0]ora_setata;
input [5:0]min_setat;
output reg [5:0]secunda;
output reg [5:0]minut;
output reg [4:0]ora;
	
always @(posedge clk )
begin
	if(rst == 1'b1)
		begin
			secunda <= 8'b0;
			minut <= 8'b0;
			ora <= 7'b0;
		end
	else 
	if(load)
		begin
			ora <= ora_setata;
			minut <= min_setat;
		end
		
	if(enable)
		begin
			if(secunda >= 0 && secunda < 8'b00111011)
				begin
					secunda <= secunda + 8'b00000001;
				end
				
			else
				if(secunda ==  8'b00111011)
				begin
					secunda <= 0;
					if(minut >= 0 && minut < 8'b00111011)	
						begin
							minut <= minut + 8'b00000001;
						end
					else
						if(minut ==  8'b00111011)
							begin
								minut <= 0;
								if(ora >=0 && ora < 11000)
									begin
										ora = ora + 8'b00000001;
									end
								else
									begin
										ora <=0;
									end
									
							end
				
				end
		end
end		
endmodule
