`default_nettype none

//-- Servo test
module ServoUnit(input wire clk,         //-- System clock
                 input wire [7:0] pos,   //-- Servo pos 0 - 255
                 output reg servo);     //-- Servo control signal

localparam M = 47;
localparam N = $clog2(M);

reg [N-1:0] divcounter = 0;
reg tic = 0;

//-- Ticks generation. A pulse is emmited every M system clock cycles
always @(posedge clk)
 tic <= (divcounter == M - 2);

//-- Module M counter
always @(posedge clk)
 if (tic)
   divcounter <= 0;
 else
   divcounter <= divcounter + 1;

//-- Angle counter
reg [11:0] angle_counter = 0;

always @(posedge clk)
 if (tic)
   angle_counter <= angle_counter + 1;

always @(posedge clk)
 servo <= (angle_counter < {4'b0001, pos});


endmodule
