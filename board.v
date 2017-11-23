
module board();
	input player; // 1 is black, 0 is white
	input clock;
	input resten;
	input play; // go !
	
	reg // row 0
			r0_c0 = 9'b000_000_000,
			r0_c1 = 9'b000_000_001,
			r0_c2 = 9'b000_000_010,
			r0_c3 = 9'b000_000_011,
			r0_c4 = 9'b000_000_100,
			r0_c5 = 9'b000_000_101,
			r0_c6 = 9'b000_000_110,
			r0_c7 = 9'b000_000_111,
			//row 1
			r1_c0 = 9'b000_001_000,
			r1_c1 = 9'b000_001_001,
			r1_c2 = 9'b000_001_010,
			r1_c3 = 9'b000_001_011,
			r1_c4 = 9'b000_001_100,
			r1_c5 = 9'b000_001_101,
			r1_c6 = 9'b000_001_110,
			r1_c7 = 9'b000_001_111,
			// row 2 
			r2_c0 = 9'b000_010_000,
			r2_c1 = 9'b000_010_001,
			r2_c2 = 9'b000_010_010,
			r2_c3 = 9'b000_010_011,
			r2_c4 = 9'b000_010_100,
			r2_c5 = 9'b000_010_101,
			r2_c6 = 9'b000_010_110,
			r2_c7 = 9'b000_010_111,
			//row 3
			r3_c0 = 9'b000_011_000,
			r3_c1 = 9'b000_011_001,
			r3_c2 = 9'b000_011_010,
			r3_c3 = 9'b000_011_011,
			r3_c4 = 9'b000_011_100,
			r3_c5 = 9'b000_011_101,
			r3_c6 = 9'b000_011_110,
			r3_c7 = 9'b000_011_111,
			//row 4
			r4_c0 = 9'b000_100_000,
			r4_c1 = 9'b000_100_001,
			r4_c2 = 9'b000_100_010,
			r4_c3 = 9'b000_100_011,
			r4_c4 = 9'b000_100_100,
			r4_c5 = 9'b000_100_101,
			r4_c6 = 9'b000_100_110,
			r4_c7 = 9'b000_100_111,
			//row 5
			r5_c0 = 9'b000_101_000,
			r5_c1 = 9'b000_101_001,
			r5_c2 = 9'b000_101_010,
			r5_c3 = 9'b000_101_011,
			r5_c4 = 9'b000_101_100,
			r5_c5 = 9'b000_101_101,
			r5_c6 = 9'b000_101_110,
			r5_c7 = 9'b000_101_111,
			//row 6
			r6_c0 = 9'b000_110_000,
			r6_c1 = 9'b000_110_001,
			r6_c2 = 9'b000_110_010,
			r6_c3 = 9'b000_110_011,
			r6_c4 = 9'b000_110_100,
			r6_c5 = 9'b000_110_101,
			r6_c6 = 9'b000_110_110,
			r6_c7 = 9'b000_110_111,		
			//row 7
			r7_c0 = 9'b000_111_000,
			r7_c1 = 9'b000_111_001,
			r7_c2 = 9'b000_111_010,
			r7_c3 = 9'b000_111_011,
			r7_c4 = 9'b000_111_100,
			r7_c5 = 9'b000_111_101,
			r7_c6 = 9'b000_111_110,
			r7_c7 = 9'b000_111_111,			
	



	controll_node c00 (.clk(clock), .resetn(resetn), .curr(r0_c0), .play(play), .set_black(player), .next(r0_c0[8:6]));
	controll_node c01 (.clk(clock), .resetn(resetn), .curr(r0_c1), .play(play), .set_black(player), .next(r0_c1[8:6]));
	controll_node c02 (.clk(clock), .resetn(resetn), .curr(r0_c2), .play(play), .set_black(player), .next(r0_c2[8:6]));
	controll_node c03 (.clk(clock), .resetn(resetn), .curr(r0_c3), .play(play), .set_black(player), .next(r0_c3[8:6]));
	controll_node c04 (.clk(clock), .resetn(resetn), .curr(r0_c4), .play(play), .set_black(player), .next(r0_c4[8:6]));
	controll_node c05 (.clk(clock), .resetn(resetn), .curr(r0_c5), .play(play), .set_black(player), .next(r0_c5[8:6]));
	controll_node c06 (.clk(clock), .resetn(resetn), .curr(r0_c6), .play(play), .set_black(player), .next(r0_c6[8:6]));
	controll_node c07 (.clk(clock), .resetn(resetn), .curr(r0_c7), .play(play), .set_black(player), .next(r0_c7[8:6]));
	
   controll_node c10 (.clk(clock), .resetn(resetn), .curr(r1_c0), .play(play), .set_black(player), .next(r1_c0[8:6]));
	controll_node c11 (.clk(clock), .resetn(resetn), .curr(r1_c0), .play(play), .set_black(player), .next(r1_c1[8:6]));
	controll_node c12 (.clk(clock), .resetn(resetn), .curr(r1_c0), .play(play), .set_black(player), .next(r1_c2[8:6]));
	controll_node c13 (.clk(clock), .resetn(resetn), .curr(r1_c0), .play(play), .set_black(player), .next(r1_c3[8:6]));
	controll_node c14 (.clk(clock), .resetn(resetn), .curr(r1_c0), .play(play), .set_black(player), .next(r1_c4[8:6]));
	controll_node c15 (.clk(clock), .resetn(resetn), .curr(r1_c0), .play(play), .set_black(player), .next(r1_c5[8:6]));
	controll_node c16 (.clk(clock), .resetn(resetn), .curr(r1_c0), .play(play), .set_black(player), .next(r1_c6[8:6]));
	controll_node c17 (.clk(clock), .resetn(resetn), .curr(r1_c0), .play(play), .set_black(player), .next(r1_c7[8:6]));
	
	controll_node c20 (.clk(clock), .resetn(resetn), .curr(r2_c0), .play(play), .set_black(player), .next(r2_c0[8:6]));	
	controll_node c21 (.clk(clock), .resetn(resetn), .curr(r2_c0), .play(play), .set_black(player), .next(r2_c1[8:6]));
	controll_node c22 (.clk(clock), .resetn(resetn), .curr(r2_c0), .play(play), .set_black(player), .next(r2_c2[8:6]));
	controll_node c23 (.clk(clock), .resetn(resetn), .curr(r2_c0), .play(play), .set_black(player), .next(r2_c3[8:6]));
	controll_node c24 (.clk(clock), .resetn(resetn), .curr(r2_c0), .play(play), .set_black(player), .next(r2_c4[8:6]));
	controll_node c25 (.clk(clock), .resetn(resetn), .curr(r2_c0), .play(play), .set_black(player), .next(r2_c5[8:6]));
	controll_node c26 (.clk(clock), .resetn(resetn), .curr(r2_c0), .play(play), .set_black(player), .next(r2_c6[8:6]));
	controll_node c27 (.clk(clock), .resetn(resetn), .curr(r2_c0), .play(play), .set_black(player), .next(r2_c7[8:6]));
	
	controll_node c30 (.clk(clock), .resetn(resetn), .curr(r3_c0), .play(play), .set_black(player), .next(r3_c0[8:6]));
	controll_node c31 (.clk(clock), .resetn(resetn), .curr(r3_c0), .play(play), .set_black(player), .next(r3_c1[8:6]));
	controll_node c32 (.clk(clock), .resetn(resetn), .curr(r3_c0), .play(play), .set_black(player), .next(r3_c2[8:6]));
	controll_node c33 (.clk(clock), .resetn(resetn), .curr(r3_c0), .play(play), .set_black(player), .next(r3_c3[8:6]));
	controll_node c34 (.clk(clock), .resetn(resetn), .curr(r3_c0), .play(play), .set_black(player), .next(r3_c4[8:6]));
	controll_node c35 (.clk(clock), .resetn(resetn), .curr(r3_c0), .play(play), .set_black(player), .next(r3_c5[8:6]));
	controll_node c36 (.clk(clock), .resetn(resetn), .curr(r3_c0), .play(play), .set_black(player), .next(r3_c6[8:6]));
	controll_node c37 (.clk(clock), .resetn(resetn), .curr(r3_c0), .play(play), .set_black(player), .next(r3_c7[8:6]));
	
	controll_node c40 (.clk(clock), .resetn(resetn), .curr(r4_c0), .play(play), .set_black(player), .next(r4_c0[8:6]));
	controll_node c41 (.clk(clock), .resetn(resetn), .curr(r4_c0), .play(play), .set_black(player), .next(r4_c1[8:6]));
	controll_node c42 (.clk(clock), .resetn(resetn), .curr(r4_c0), .play(play), .set_black(player), .next(r4_c2[8:6]));
	controll_node c43 (.clk(clock), .resetn(resetn), .curr(r4_c0), .play(play), .set_black(player), .next(r4_c3[8:6]));
	controll_node c44 (.clk(clock), .resetn(resetn), .curr(r4_c0), .play(play), .set_black(player), .next(r4_c4[8:6]));
	controll_node c45 (.clk(clock), .resetn(resetn), .curr(r4_c0), .play(play), .set_black(player), .next(r4_c5[8:6]));
	controll_node c46 (.clk(clock), .resetn(resetn), .curr(r4_c0), .play(play), .set_black(player), .next(r4_c6[8:6]));
	controll_node c47 (.clk(clock), .resetn(resetn), .curr(r4_c0), .play(play), .set_black(player), .next(r4_c7[8:6]));
	
	controll_node c50 (.clk(clock), .resetn(resetn), .curr(r5_c0), .play(play), .set_black(player), .next(r5_c0[8:6]));
	controll_node c51 (.clk(clock), .resetn(resetn), .curr(r5_c0), .play(play), .set_black(player), .next(r5_c1[8:6]));
	controll_node c52 (.clk(clock), .resetn(resetn), .curr(r5_c0), .play(play), .set_black(player), .next(r5_c2[8:6]));
	controll_node c53 (.clk(clock), .resetn(resetn), .curr(r5_c0), .play(play), .set_black(player), .next(r5_c3[8:6]));
	controll_node c54 (.clk(clock), .resetn(resetn), .curr(r5_c0), .play(play), .set_black(player), .next(r5_c4[8:6]));
	controll_node c55 (.clk(clock), .resetn(resetn), .curr(r5_c0), .play(play), .set_black(player), .next(r5_c5[8:6]));
	controll_node c56 (.clk(clock), .resetn(resetn), .curr(r5_c0), .play(play), .set_black(player), .next(r5_c6[8:6]));
	controll_node c57 (.clk(clock), .resetn(resetn), .curr(r5_c0), .play(play), .set_black(player), .next(r5_c7[8:6]));
	
	controll_node c60 (.clk(clock), .resetn(resetn), .curr(r6_c0), .play(play), .set_black(player), .next(r6_c0[8:6]));
	controll_node c61 (.clk(clock), .resetn(resetn), .curr(r6_c0), .play(play), .set_black(player), .next(r6_c1[8:6]));
	controll_node c62 (.clk(clock), .resetn(resetn), .curr(r6_c0), .play(play), .set_black(player), .next(r6_c2[8:6]));
	controll_node c63 (.clk(clock), .resetn(resetn), .curr(r6_c0), .play(play), .set_black(player), .next(r6_c3[8:6]));
	controll_node c64 (.clk(clock), .resetn(resetn), .curr(r6_c0), .play(play), .set_black(player), .next(r6_c4[8:6]));
	controll_node c65 (.clk(clock), .resetn(resetn), .curr(r6_c0), .play(play), .set_black(player), .next(r6_c5[8:6]));
	controll_node c66 (.clk(clock), .resetn(resetn), .curr(r6_c0), .play(play), .set_black(player), .next(r6_c6[8:6]));
	controll_node c67 (.clk(clock), .resetn(resetn), .curr(r6_c0), .play(play), .set_black(player), .next(r6_c7[8:6]));
	
	controll_node c70 (.clk(clock), .resetn(resetn), .curr(r7_c0), .play(play), .set_black(player), .next(r7_c0[8:6]));
	controll_node c71 (.clk(clock), .resetn(resetn), .curr(r7_c0), .play(play), .set_black(player), .next(r7_c1[8:6]));
	controll_node c72 (.clk(clock), .resetn(resetn), .curr(r7_c0), .play(play), .set_black(player), .next(r7_c2[8:6]));
	controll_node c73 (.clk(clock), .resetn(resetn), .curr(r7_c0), .play(play), .set_black(player), .next(r7_c3[8:6]));
	controll_node c74 (.clk(clock), .resetn(resetn), .curr(r7_c0), .play(play), .set_black(player), .next(r7_c4[8:6]));
	controll_node c75 (.clk(clock), .resetn(resetn), .curr(r7_c0), .play(play), .set_black(player), .next(r7_c5[8:6]));
	controll_node c76 (.clk(clock), .resetn(resetn), .curr(r7_c0), .play(play), .set_black(player), .next(r7_c6[8:6]));
	controll_node c77 (.clk(clock), .resetn(resetn), .curr(r7_c0), .play(play), .set_black(player), .next(r7_c7[8:6]));
	
	

endmodule 



module controll_node(clk, resetn, curr, play, set_black, next);
	input clk;
	inout resetn;
	input [8:0] curr;
	input play;
	input set_black;
	output [2:0] next; 
	
	wire [5:0] position = curr[5:0];
	
	reg [2:0] curr_state, next_state;
	
	curr_state = curr[8:6];
	
	localparam EMPTY = 3'd0,
				  ENABLE = 3'd1,
				  BLACK = 3'd2,
				  WHITE = 3'd3;
	
	// SET the nest state of this node
	always @(*)
	begin: state_table
			case (curr_state)
				EMPTY: next_state = play ?  ENABLE : EMPTY ;
				ENABLE: begin 
								if (play) 
									begin
										if (set_black)
											next_state = BALCK;
										else 
											next_state = white;
									end
								else 
									next_state = ENABLE;
						  end ;
				BLACK : next_state = play ? WHITE : BLACK;
				WHITE : next_state = play ? BLACK : WHITE;
						 
			endcase
		
	end
	
	 // current_state registers
	always@(posedge clk)
		begin: state_FFs
			  if(resetn)  // initial the node
					begin 
						if (position == 6'b011_011 || position == 6'b100_100)
							curr_state <= WHITE;
						else if (position == 6'b100_011|| position == 6'b011_100)
							curr_state <= BLACK;
						else 
							curr_state <= EMPTY;
					end 
					
			  else
					curr_state <= next_state;
		end // state_FFS
		
	assign next = curr_state; 
endmodule  

