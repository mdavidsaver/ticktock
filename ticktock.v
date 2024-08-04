`timescale 1us/1ns
module ticktock(
  input wire clk12, // 12 MHz
  output wire [4:0] led,
  output reg tick,
  output wire tock
);

`ifdef __ICARUS__
wire locked = 1;
assign tock = tick;
wire clk = clk12;
`else
wire clk;
wire locked;
pll pll(
  .clock_in(clk12),
  .clock_out(clk),
  .locked(locked)
);

SB_IO #(
  .PIN_TYPE(6'b010100) // registered output
) tock_r(
  .PACKAGE_PIN(tock),
  .OUTPUT_CLK(clk),
  //.CLOCK_ENABLE(1'b1),
  .D_OUT_0(tick)
);
`endif

localparam LIMIT = 124500000;
localparam MAX = LIMIT-1;
localparam WIDTH = $clog2(MAX);

reg [WIDTH-1:0] cnt = 0;

assign led[3:0] = 4'b0000;
assign led[4] = cnt > LIMIT/2;

always @(posedge clk) begin
  tick <= 0;
  if(cnt==MAX || !locked) begin
    cnt <= 0;
    tick<= 1;
  end else begin
    cnt <= cnt+1;
  end
end

endmodule

