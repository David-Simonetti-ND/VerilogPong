module datapath(
	input clk,
	input [1:0]sel_x_ball,
	input en_x_ball,
	input [1:0]sel_y_ball,
	input en_y_ball,
	input [1:0]sel_y_paddle,
	input en_y_paddle,
	input [1:0]sel_y_ai,
	input en_y_ai,
	input sel_player_score,
	input en_player_score,
	input sel_ai_score,
	input en_ai_score,
	input [7:0] user_in,
	output reg [7:0] x_ball,
	output reg [6:0] y_ball,
	output reg [6:0] y_paddle,
	output reg [6:0] y_ai,
	output reg [3:0] player_score,
	output reg [3:0] ai_score,
	output y_sign,   // output wire of register control signal used to control ball's y velocity
	output x_sign,   // output wire of register control signal used to control ball's x velocity
	output paddle_up,
	output paddle_down,
	output ai_up,
	output ai_down,
	output ball_too_high,
	output ball_too_low,
	output paddle_too_low,
	output paddle_too_high,
	output ai_too_low,
	output ai_too_high,
	output player_collision,
	output ai_collision,
	output player_scored,
	output ai_scored,
	output game_over
	);
	
	parameter [3:0] x_velocity = 4'h3;
	parameter [3:0] y_velocity = 4'h2;
	parameter [3:0] ball_width = 4'h4;
	parameter [3:0] pad_width = 4'h2;
	parameter [3:0] pad_height = 4'h15;
	parameter [3:0] pad_vel = 4'h3;
	parameter [3:0] ai_width = 4'h2;
	parameter [3:0] ai_height = 4'h15;
	parameter [3:0] ai_vel = 4'h3;
	
	reg x_ball_state = 1'b0; // hold current state of x ball velocity
	reg y_ball_state = 1'b0; // hold current state of y ball velocity
	reg paddle_up_state = 1'b0;
	reg paddle_down_state = 1'b0;
	reg ai_up_state = 1'b0;
	reg ai_down_state = 1'b0;
	
	initial 
	begin
		x_ball = 8'd0;
		y_ball = 7'd0;
		y_paddle = 7'd0;
		y_ai = 7'd0;
		player_score = 4'd0;
		ai_score = 4'd0;
	end
	
	always @(posedge clk)
	begin
		if (en_x_ball)
			case (sel_x_ball)
				0: x_ball <= 8'h50;
				1: begin x_ball <= x_ball + x_velocity; x_ball_state <= 1'b1; end
				2: begin x_ball <= x_ball - x_velocity; x_ball_state <= 1'b0; end
			endcase
	end
	
	always @(posedge clk)
	begin
		if (en_y_ball)
			case (sel_y_ball)
				0: y_ball <= 8'h40;
				1: begin y_ball <= y_ball + y_velocity; y_ball_state <= 1'b1; end
				2: begin y_ball <= y_ball - y_velocity; y_ball_state <= 1'b0; end
			endcase
	end
	
	always @(posedge clk)
	begin
		if (en_y_paddle)
			case (sel_y_paddle)
				0: y_paddle <= 7'h5;
				1: y_paddle <= y_paddle + pad_vel; 
				2: y_paddle <= y_paddle - pad_vel;
				3: y_paddle <= y_paddle;
			endcase
	end
	
	always @(posedge clk)
	begin
		if (en_y_ai)
			case (sel_y_ai)
				0: y_ai <= 7'h5;
				1: y_ai <= y_ai + ai_vel; 
				2: y_ai <= y_ai - ai_vel;
				3: y_ai <= y_ai;
			endcase
	end
	
	always @(posedge clk)
	begin
		if (en_player_score)
			if (sel_player_score) player_score <= player_score + 1; 
			else player_score <= 0;
	end
	
	always @(posedge clk)
	begin
		if (en_ai_score)
			if (sel_ai_score) ai_score <= ai_score + 1; 
			else ai_score <= 0;
	end
	
	always @(posedge clk)
	begin
		if (user_in == 7'h77) begin paddle_up_state <= 1'b1; paddle_down_state <= 1'b0; end
		else if (user_in == 7'h73) begin paddle_up_state <= 1'b0; paddle_down_state <= 1'b1; end
		else if (user_in == 7'h41) begin ai_up_state <= 1'b1; ai_down_state <= 1'b0; end
		else if (user_in == 7'h42) begin ai_up_state <= 1'b0; ai_down_state <= 1'b1; end
	end
	
	assign ball_too_high = (y_ball >= 8'd120 - y_velocity - ball_width);
	assign ball_too_low = (y_ball <= y_velocity);
	assign paddle_too_low = (y_paddle <= 7'h3);
	assign paddle_too_high = (y_paddle > 100);
	assign ai_too_low = (y_ai <= 7'h3);
	assign ai_too_high = (y_ai > 100);
	assign player_collision = ( (x_ball <= 8'd18) & ( (y_ball + ball_width + 7'h4) >= y_paddle ) & (y_ball <= (y_paddle + pad_height + 8'h4)));
	assign ai_collision = ( (x_ball >= 8'd141) & ( (y_ball + ball_width + 7'h4) >= y_ai ) & (y_ball <= (y_ai + ai_height + 8'h4)));
	assign player_scored = x_ball >= 8'd158;
	assign ai_scored = x_ball <= 2;
	assign game_over = (player_score >= 9) | (ai_score >= 9);
	
	assign x_sign = x_ball_state;
	assign y_sign = y_ball_state;
	assign paddle_up = paddle_up_state;
	assign paddle_down = paddle_down_state;
	assign ai_up = ai_up_state;
	assign ai_down = ai_down_state;
	
endmodule