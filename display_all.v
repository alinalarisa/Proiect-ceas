module display_all(	
            d0_min_in,
            d1_min_in,
            d0_h_in,
            d1_h_in,
            rst,
            clk_in,
            sel_q,
            an,
            digit_out
            );
//---------------input signals-------------	
input [3:0]d0_min_in;
input [3:0]d1_min_in;
input [3:0]d0_h_in;
input [3:0]d1_h_in;			
input rst,clk_in;
	
//---------------output signals-------------	
output [1:0]sel_q;
output [7:0]digit_out;
output [3:0]an;

reg [3:0]digit;

counter_100HZ linie_de_selectie(
.clk_100(clk_in),
.sel_q(sel_q),
.rst(rst)
);

display_anod anod(
.sel(sel_q),
.an(an)
);	
// se alege ce cifra ca va fi iluminata
always @(sel_q)
begin 
    case (sel_q)
    2'd0: digit = d0_min_in;
    2'd1: digit = d1_min_in;
    2'd2: digit = d0_h_in;
    2'd3: digit = d1_h_in;	
    endcase
end	
display_catod catod(
.in(digit), 
.out(digit_out)
);	
endmodule