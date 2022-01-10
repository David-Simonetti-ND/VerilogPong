module scoreboard ( 
   input                clk,   
	input 		   [3:0] score,
   input          [2:0] x,
   input          [2:0] y,  
   output   reg   [2:0] dout
   );
      
   wire [7:0] addr  = 4*y + x;
   
   reg [3:0] mem1 [0:27];
	reg [3:0] mem2 [0:27];
	reg [3:0] mem3 [0:27];
	reg [3:0] mem4 [0:27];
	reg [3:0] mem5 [0:27];
	reg [3:0] mem6 [0:27];
	reg [3:0] mem7 [0:27];
	reg [3:0] mem8 [0:27];
	reg [3:0] mem9 [0:27];
	reg [3:0] mem0 [0:27];
   initial $readmemh("Sprites/1.mem", mem1);
	initial $readmemh("Sprites/2.mem", mem2);
	initial $readmemh("Sprites/3.mem", mem3);
	initial $readmemh("Sprites/4.mem", mem4);
	initial $readmemh("Sprites/5.mem", mem5);
	initial $readmemh("Sprites/6.mem", mem6);
	initial $readmemh("Sprites/7.mem", mem7);
	initial $readmemh("Sprites/8.mem", mem8);
	initial $readmemh("Sprites/9.mem", mem9);
	initial $readmemh("Sprites/0.mem", mem0);

   always @(posedge clk)
			case (score)
				0: dout <= mem0[addr];
				1: dout <= mem1[addr];
				2: dout <= mem2[addr];
				3: dout <= mem3[addr];
				4: dout <= mem4[addr];
				5: dout <= mem5[addr];
				6: dout <= mem6[addr];
				7: dout <= mem7[addr];
				8: dout <= mem8[addr];
				9: dout <= mem9[addr];
				default: dout <= 3'd0;
			endcase
         
   
endmodule
