`timescale 1ns / 1ps

module TxUARTTest;

	reg i_clk;
	reg [7:0] data_input;
	reg active;
	reg enable;


	wire Tx;
	wire [7:0] data_output;
	wire ready;


	TxUART uut1 (
		.i_clk(o_clk), 
		.data_input(data_input), 
		.active(active), 
		.Tx(Tx)
	);
	
	BaudGen uut (
		.i_clk(i_clk), 
		.enable(enable), 
		.o_clk(o_clk)
	);
	
	defparam uut.OVER_SAMPELING =1;
	
	BaudGen uut2 (
		.i_clk(i_clk), 
		.enable(enable), 
		.o_clk(o_clk2)
	);
	
	RxUART uut3 (
		.i_clk(o_clk2), 
		.Rx(Tx), 
		.ready(ready), 
		.data_output(data_output)
	);

	initial begin
		i_clk = 0;
		forever  #50 i_clk = ~i_clk;

	end

	initial begin
		data_input = 8'b00001000;
		active = 1;
		enable = 1;

		#100000000;
		
		data_input = 8'b00111000;

		
		
        

	end
	
      
endmodule

