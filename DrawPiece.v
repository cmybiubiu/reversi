module DrawPiece(
            input clk;
            input resetn;
            input [2:0] x;
            input [2:0] y;
            input [1:0] colour;

            output reg [7:0] real_x;
            output reg [6:0] real_y;
            output reg [2:0] real_colour
            );

    always(posedeg clk)
    begin
        if (resetn) 
            begin
                real_x <= 1'b0;
                real_y <= 1'b0;
                real_colour <= 3'b010;
            end
        else
            begin 
                real_x <= x * 4;
                real_y <= y * 4;
                if (colour == 2'b11)
                    real_colour <= 3'b000;
                else if (colour == 2'b10)
                    real_colour <= 3'b111;
            end 
    end

endmodule