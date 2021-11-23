`timescale 1ns / 1ps

module BaudGen (
	input i_clk,
	input enable,
	output reg o_clk = 0
    );
	 
	parameter INPUT_FREQ = 10000000;
	parameter BAUD_RATE = 9600;
	parameter OVER_SAMPELING = 8;
	
	parameter INIT = ( INPUT_FREQ / ( BAUD_RATE * OVER_SAMPELING ) ) / 2 - 1;
	parameter FREQ_ERROR = ( INPUT_FREQ / ( INIT * 2 ) ) - ( BAUD_RATE * OVER_SAMPELING );
	initial $display(" init  is %d \n FREQ_ERROR %d \n freq is %d", INIT,  FREQ_ERROR, INPUT_FREQ / INIT);
	
	reg [$clog2(INIT):0] cnt = 0;
	
	always @(posedge i_clk) begin
		if(enable)
			if(cnt != INIT - 1)
				cnt <= cnt + 1;
			else begin
				cnt <= 0;
				o_clk <= ~o_clk;
			end
		else
			o_clk <= 0;
	end
	

endmodule
