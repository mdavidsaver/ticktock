`timescale 1us/1ns
module ticktock(
  input wire clk12, // 12 MHz
  output wire [4:0] led,
  output reg tick,
  output wire tock
);

assign tock = tick;

`ifdef __ICARUS__
wire locked = 1;
wire clk = clk12;
`else
wire clk;
wire locked;
pll pll(
  .clock_in(clk12),
  .clock_out(clk),
  .locked(locked)
);
`endif

localparam LIMIT = 124500000;
localparam MAX = LIMIT-1;
localparam WIDTH = $clog2(MAX);

reg [WIDTH-1:0] cnt = 0;

assign led[2:0] = 3'b000;
assign led[3] = locked;
reg led4 = 0;
assign led[4] = led4;

always @(posedge clk) begin
  tick <= 0;
  if(cnt==MAX | !locked) begin
    cnt <= 0;
    tick<= 1;
    led4 <= ~led4;
  end else begin
    cnt <= cnt+1;
  end
end

endmodule
