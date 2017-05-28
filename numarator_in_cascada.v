module numarator_in_cascada
		(	clk	,
			rst	,
			enable	,
			load	,
			ora_setata,
			min_setat,
			minut_q	,
			secunda_q,
			ora_q		
		);				//---------------input signals-------------		
input clk;
input rst;  // active high
input enable;
input load;
input [5:0]ora_setata;
input [5:0]min_setat;
//---------------output signals-------------
output reg [5:0]secunda_q;
output reg [5:0]minut_q;
output reg [5:0]ora_q;

reg [5:0]secunda_d;
reg [5:0]minut_d;
reg [5:0]ora_d;
//Flip flops
always @ (posedge clk or posedge rst)
begin
    if(rst) 
	begin
	    secunda_q <= 6'd0;
	    minut_q <= 6'd0;
	    ora_q <= 5'd0;
	end	
    else 
	begin
	    secunda_q <= secunda_d;
	    minut_q <= minut_d;
	    ora_q <= ora_d;
	end
end
//Combinational logic
always @(*)
begin
    secunda_d = secunda_q;
    minut_d = minut_q;
    ora_d = ora_q;

    if(load)
	begin
	    ora_d = ora_setata;
	    minut_d = min_setat;
	end
    else	
	if(enable)
	    begin
		if( secunda_q >= 0 && secunda_q < 59 )
		    begin
			    secunda_d = secunda_d + 1'd1;
		    end
				
		else
		    if(secunda_q ==  59)
		        begin
			    secunda_d = 0;
			    if(minut_q >= 0 && minut_q < 59)	
				    begin
					    minut_d = minut_d + 1'd1;
				    end
			    else
				    if(minut_q ==  59)
					begin
					    minut_d = 0;
						if(ora_q >=0 && ora_q < 24)
						    begin
							    ora_d = ora_d + 1'd1;
						    end
						else
						    begin
							    ora_d =0;
						    end						
		            end
	            end
	    end
end		
endmodule
