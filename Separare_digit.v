module separare_digiti(clk,x , d0, d1);
// d0 = cifra unitatilor
// d1 = cifra zecilor

//---------------input signals-------------
input clk;
input [5:0]x;

//---------------output signals------------

output reg [3:0]d0;
output reg [3:0]d1;

always @(*)
begin

    if(x < 10)
	begin
	    d0=x;
	    d1=0;
    end
    else
    if( x < 20 )
	begin
        d0=x-10;
	    d1=1;
	end
    else
    if(x<30)
	begin
	    d0=x-20;
	    d1=2;
	end
    else
    if(x<40)
	begin
	    d0=x-30;
        d1=3;
	end
    else
    if(x<50)
	begin
        d0=x-40;
	    d1=4;
	end
    else
    if(x<60)
	begin
	    d0=x-50;
	    d1=5;
	end
end

endmodule