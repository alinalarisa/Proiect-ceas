module counter_top(
            load_butoane,
            h_butoane,
            min_butoane,
            load_uart,
            h_uart,
            min_uart, 
            clk_MHz,
            rst,
            enable,
            anod,
            catod
        );
//---------------input signals-------------	
input load_butoane;
input load_uart;
input rst,clk_MHz,enable;
input [5:0]min_uart;
input [5:0]min_butoane;
input [5:0]h_uart;
input [5:0]h_butoane;		

//---------------output signals-------------
output [3:0]anod;
output [7:0]catod;

wire [3:0]d0_min;
wire [3:0]d1_min;
wire [3:0]d0_h;
wire [3:0]d1_h;

wire[1:0]sel_q;


wire [5:0]secunda_q;
wire [5:0]minut_q;
wire [5:0]ora_q;

wire clk_1;
wire clk_100;

reg [5:0]min;
reg [5:0]h;
reg load;

// se selecteaza prin ce se face setarea ceasului (uart sau butoane)
always @(*)
begin 
if(load_butoane == 1'd1)
    begin
        load = load_butoane;
        min = min_butoane;
        h = h_butoane;
    end
else
if(load_uart == 1'd1)
    begin
        load = load_uart;
        min = min_uart;
        h = h_uart;
    end
end
		
//clk_in va fi divizat in clk de 1 HZ
divider_clk_1Hz clk1Hz(
.clk_in(clk_MHz), 
.clk_out_q(clk_1), 
.rst(rst)
);

//clk_in va fi divizat in clk de 100 HZ
divider_clk_100Hz clk100hz(
.clk_in(clk_MHz),     //input
.rst(rst),           //input
.clk_out_q(clk_100)//output
);

numarator_in_cascada numar(
.clk(clk_1),		//clk de 1 hz 
.rst(rst),
.enable(enable),
.load(load),
.min_setat(min),//min si h sunt cele setate 
.ora_setata(h),
.secunda_q(secunda_q),  // output
.minut_q(minut_q),      // output
.ora_q(ora_q)           // output
);

//Se descompune minutul 
separare_digiti minute(
.clk(clk_1),
.x(minut_q),
.d0(d0_min),
.d1(d1_min)
);
//Se descompune ora
separare_digiti ore(
.clk(clk_1),
.x(ora_q),
.d0(d0_h),
.d1(d1_h)
);		

//linia de selectie
counter_100HZ linie_selectie(
.clk_100(clk_100),
.rst(rst),     //active high
.sel_q(sel_q)
);

//afisare
display_all afisaj(	
.d0_min_in(d0_min),
.d1_min_in(d1_min),
.d0_h_in(d0_h),
.d1_h_in(d1_h),
.rst(rst),
.clk_in(clk_100), //clk de 100 HZ
.sel_q(sel_q),
.an(anod),
.digit_out(catod)
);
endmodule