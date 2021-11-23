`timescale 1ns / 1ps

module BaudGenTest;

	reg i_clk;
	reg enable;

	wire o_clk;

	BaudGen uut (
		.i_clk(i_clk), 
		.enable(enable), 
		.o_clk(o_clk)
	);

	initial begin
		i_clk = 0;
		enable = 1;

		#100;
        
		forever  #50 i_clk = ~i_clk;
	end
	
      
endmodule

