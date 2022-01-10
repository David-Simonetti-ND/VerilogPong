`timescale 1ns/1ns
module system_tb();
	
	reg          clk = 1'b0;
	reg  [7:0]   current_data = 8'd0;
	reg  [7:0]   xvga = 8'd0;
	reg  [7:0]   yvga = 8'd0;
	wire [7:0]   x_ball;
	wire [6:0]   y_ball;
	wire [6:0]   y_paddle;
	wire [6:0]   y_ai;
	wire [3:0]   player_score;
	wire [3:0]   ai_score;
	
	parameter c_CLOCK_PERIOD_NS = 20;
	parameter c_CLKS_PER_BIT    = 434;
	parameter c_BIT_PERIOD      = 8600;

	reg r_Clock = 0;
	reg r_RX_Serial = 1;
	wire [7:0] w_RX_Byte;
	wire w_RX_DV;


	// Takes in input byte and serializes it 
	task UART_WRITE_BYTE;
	 input [7:0] i_Data;
	 integer     ii;
	 begin
		
		// Send Start Bit
		r_RX_Serial <= 1'b0;
		#(c_BIT_PERIOD);
		#1000;
		
		// Send Data Byte
		for (ii=0; ii<8; ii=ii+1)
		  begin
			 r_RX_Serial <= i_Data[ii];
			 #(c_BIT_PERIOD);
		  end
		
		// Send Stop Bit
		r_RX_Serial <= 1'b1;
		#(c_BIT_PERIOD);
	  end
	endtask // UART_WRITE_BYTE
	
	UART_RX #(.CLKS_PER_BIT(434)) UART_RX_Inst (
      .i_Clock       (r_Clock),
      .i_RX_Serial   (r_RX_Serial),
      .o_RX_DV       (w_RX_DV),
      .o_RX_Byte     (w_RX_Byte)
   );
	
	
	always
    #(c_CLOCK_PERIOD_NS/2) r_Clock <= !r_Clock;
		
	integer i;
	integer j;
	
	system system(
		.clk           (r_Clock),
		.current_data  (current_data),
		.x_ball			(x_ball),
		.y_ball			(y_ball),
		.y_paddle		(y_paddle),
		.y_ai				(y_ai),
		.player_score	(player_score),
		.ai_score		(ai_score)
	);
	
	// 40 nanosecond wait to get a 25mHz VGA clock, this simulates the xvga and yvga signals system would recieve
	always 
	begin
		for (i = 0; i < 120; i = i + 1)
		begin
			yvga = i;
			for (j = 0; j < 160; j = j + 1)
			begin
				#40 xvga = j;
			end
			end
	end
	
	always @(posedge r_Clock) if (w_RX_DV) current_data <= w_RX_Byte; // update current_data whenever we recieve a new valid byte
	
	initial 
	begin
			current_data = 8'd0;
			#60000000 // wait for a bunch of state transitions before writing a new byte
			@(posedge r_Clock);
				UART_WRITE_BYTE(8'h0);
			#60000000
			@(posedge r_Clock);
				UART_WRITE_BYTE(8'h77);
			#60000000
			@(posedge r_Clock);
				UART_WRITE_BYTE(8'h73);
			#60000000
			@(posedge r_Clock);
				UART_WRITE_BYTE(8'h41);
			#60000000
			@(posedge r_Clock); 
				UART_WRITE_BYTE(8'h42);
			#5 $stop;
	end
endmodule