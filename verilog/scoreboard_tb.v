`timescale 1ns/1ns
module scoreboard_tb();
	reg                clk = 1'b0; 
	reg 		    [3:0] score = 4'd0;
   reg          [2:0] x = 3'd0;
   reg          [2:0] y = 3'd0;
   wire         [2:0] dout;
	
	scoreboard uut(
		.clk(clk),
		.score(score),
		.x(x),
		.y(y),
		.dout(dout)
	);
	
	integer i;
	integer j;
	integer k;
	
	always #20 clk = ~clk; // 20 nanoseocnd 50mHz clock
	
	// 40 nanosecond wait to get a 25mHz VGA clock, this simulates the xvga and yvga signals system would recieve
	always 
	begin
		for (i = 0; i < 120; i = i + 1)
		begin
			y = i;
			for (j = 0; j < 160; j = j + 1)
			begin
				#40 x = j;
			end
			end
	end
	
	initial 
	begin
		for (k = 0; k < 10; k = k + 1)
		begin
			score = k;
			#768000; // wait for one vga cycle
			end
	end
endmodule