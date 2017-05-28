//an[0]=AN0=P17, an[1]=AN1=P18 ,an[2]=AN2=N15 ,an[3]=AN3=N16
module display_anod( sel, an  );

input [1:0]sel;
output reg [3:0]an;

always @(*)
begin
    case (sel)
        2'd0: an = 4'd14;
        2'd1: an = 4'd13;
        2'd2: an = 4'd11;
        2'd3: an = 4'd7;
	default: an = 4'd15;
    endcase
end
endmodule
