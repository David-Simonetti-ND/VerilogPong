module system_de2(
	input				CLOCK_50,				//	50 MHz
	input          UART_RXD,
	output			VGA_CLK,   				//	VGA Clock
	output			VGA_HS,					//	VGA H_SYNC
	output			VGA_VS,					//	VGA V_SYNC
	output			VGA_BLANK,				//	VGA BLANK
	output			VGA_SYNC,				//	VGA SYNC
	output [9:0]	VGA_R,   				//	VGA Red[9:0]
	output [9:0]	VGA_G,	 				//	VGA Green[9:0]
	output [9:0]	VGA_B,	   			//	VGA Blue[9:0]
	output [6:0]   HEX0,
	output [6:0]   HEX1,
	output [6:0]   HEX2,
	output [6:0]   HEX3,
	output [6:0]   HEX4,
	output [6:0]   HEX5,
	output [6:0]   HEX6,
	output [6:0]   HEX7
	);
	
	wire       w_RX_DV;
   wire [7:0] w_RX_Byte;
	reg [7:0] current_data;
	
	wire [7:0] 	xvga;
	wire [6:0] 	yvga;
   wire [2:0]  color;
	
	wire [7:0] x_ball;
	wire [6:0] y_ball;
	wire [6:0] y_paddle;
	wire [6:0] y_ai;
	wire [3:0] player_score;
	wire [3:0] ai_score;
	
	always @(posedge CLOCK_50) if (w_RX_DV) current_data <= w_RX_Byte;
	
	UART_RX #(.CLKS_PER_BIT(5208)) UART_RX_Inst (
      .i_Clock       (CLOCK_50),
      .i_RX_Serial   (UART_RXD),
      .o_RX_DV       (w_RX_DV),
      .o_RX_Byte     (w_RX_Byte)
   );
	
	system system(
		.clk           (CLOCK_50),
		.current_data  (current_data),
		.x_ball			(x_ball),
		.y_ball			(y_ball),
		.y_paddle		(y_paddle),
		.y_ai				(y_ai),
		.player_score	(player_score),
		.ai_score		(ai_score)
	);
	
	sprite_manager sprite_manager (
      .VGA_CLK      (VGA_CLK),
      .x_ball       (x_ball),
      .y_ball       (y_ball),
		.x_paddle (8'h10),
		.y_paddle (y_paddle),
		.x_ai     (8'd145),
		.y_ai		 (y_ai),
      .xvga    (xvga),
      .yvga    (yvga),
		.player_score(player_score),
		.ai_score(ai_score),
      .color   (color)
   );
	
	vga_xy_controller vga_xy_controller (
      .CLOCK_50      (CLOCK_50),
		.resetn        (1'b1),
      .color         (color),
      .x             (xvga),
      .y             (yvga),
      .VGA_R         (VGA_R),
      .VGA_G         (VGA_G),
      .VGA_B         (VGA_B),
      .VGA_HS        (VGA_HS),
      .VGA_VS        (VGA_VS),
      .VGA_BLANK     (VGA_BLANK),
      .VGA_SYNC      (VGA_SYNC),
      .VGA_CLK       (VGA_CLK)				
   );
	
	assign HEX0 = 7'h0;
   assign HEX1 = 7'h0;
	assign HEX2 = 7'h0;
	assign HEX3 = 7'h0;
	assign HEX4 = 7'h0;
	assign HEX5 = 7'h0;
	assign HEX6 = 7'h0;
	assign HEX7 = 7'h0;

endmodule
