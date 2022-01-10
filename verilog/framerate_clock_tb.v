`timescale 1ns/1ns
module framerate_clock_tb();
	reg  clk = 1'b0;
	wire t;
	
	framerate_clock uut(
		.VGA_CLK(clk),
		.t(t)
	);
	
	always #5 clk = ~clk;
	
	initial 
	begin
		while (~t) #5;
	end
endmodule