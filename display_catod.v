module display_catod (in, out);

input[3:0] in;
output reg[7:0] out;

//out[0] = CA iar out[6] = CG,out[7]=DP
always @(*)
begin		
    case(in)
        4'h0: out = 8'b11000000; //192
        4'h1: out = 8'b11111001; //249
        4'h2: out = 8'b10100100; //164
        4'h3: out = 8'b10110000; //176
        4'h4: out = 8'b10011001; //153
        4'h5: out = 8'b10010010; //146
        4'h6: out = 8'b10000010; //130
        4'h7: out = 8'b11111000; //248
        4'h8: out = 8'b10000000; //128
        4'h9: out = 8'b10010000; //144
	default: out = 8'b11111111;  //255
    endcase
end
	
endmodule

