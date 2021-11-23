`timescale 1ns / 1ps

module TxUART(
	input i_clk,
	input [7:0] data_input,
	input active,
	output reg Tx = 1
    );
	 
	// i_clk should be equal to baudrate
	
	parameter DATA_BITS = 8;
	parameter S_IDLE = 2'b00;
	parameter S_START = 2'b01;
	parameter S_DATA = 2'b10;
	parameter S_STOP = 2'b11;
	
	reg [2:0] state = 0;
	reg [2:0] data_index = 0;
	
	always @(posedge i_clk) begin
		case(state) 
			S_IDLE: begin
				Tx <= 1;
				if(active) begin
					state <= S_START;
				end
			end
			
			S_START: begin
				Tx <= 0;
				state <= S_DATA;
				data_index <= 0;
			end
			
			S_DATA: begin
				if(data_index == 7) begin
					state <= S_STOP; 
				end
				Tx <= data_input[data_index];
				data_index <= data_index + 1;
			end
			
			S_STOP: begin
				Tx <= 1;
				state <= S_IDLE;
			end
		
		endcase

	end	

endmodule
