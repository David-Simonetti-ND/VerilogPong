module framerate_clock(
	input VGA_CLK,
	output t
	);
	reg [26:0] count = 0;
	assign t = (count == 26'h989680 / 12);
	always @(posedge VGA_CLK) begin
		if (t)
		count <= 0;
	else
		count <= count + 1;
	end
endmodule