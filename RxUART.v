`timescale 1ns / 1ps

module RxUART(
	input i_clk,
	input Rx,
	output reg ready = 0,
	output reg [7:0] data_output
    );

	// i_clk should be OVER_SAMPELING times more than baudrate that
	// set in the params

	parameter DATA_BITS = 8;
	parameter S_IDLE = 2'b00;
	parameter S_START = 2'b01;
	parameter S_DATA = 2'b10;
	parameter S_STOP = 2'b11;

	reg [2:0] state = 0;
	reg [2:0] data_index = 0;
	reg [2:0] counter = 0;

	always @(posedge i_clk) begin
		counter <= counter + 1;
		case(state)
			S_IDLE: begin
				ready <= 1;
				if(~Rx) begin
					state <= S_START;
					counter <= 0;
					ready <=0;
				end
			end

			S_START: begin
				if(~Rx && counter==3) begin
					state <= S_DATA;
					counter <= 1;
				end
			end

			S_DATA: begin
				if(data_index == 7 && counter==0) begin
					state <= S_STOP;
				end
				if(counter == 0) begin
					data_output[data_index] <= Rx;
					data_index <= data_index + 1;
				end
			end

			S_STOP: begin
				if(counter == 0) begin
					ready <= 1;
					state <= S_IDLE;
				end
			end

		endcase
	end
	
endmodule
