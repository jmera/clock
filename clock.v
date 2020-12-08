module clock (
  input clk,
  input reset,
  output [6:0] led_a,
  output [6:0] led_b
);

reg [16:0] elapsed_seconds;
reg [7:0] seconds;
reg [26:0] cycles;
reg [6:0] seg_data0;
reg [6:0] seg_data1;

always @ (posedge clk) begin // or negedge reset
  if (reset == 0) begin
    cycles <= 0;
    elapsed_seconds <= 0;
  end

  if (cycles == 50_000_000) begin
    cycles <= 0;
    elapsed_seconds <= elapsed_seconds + 1;
  end
  else
    cycles <= cycles + 1;
end

always @ (elapsed_seconds) begin
  seconds <= elapsed_seconds % 60;
  case (seconds % 10)
    0:
      seg_data0 = 7'b0000001;
    1:
      seg_data0 = 7'b1001111;
    2:
      seg_data0 = 7'b0010010;
    3:
      seg_data0 = 7'b0000110;
    4:
      seg_data0 = 7'b1001100;
    5:
      seg_data0 = 7'b0100100;
    6:
      seg_data0 = 7'b0100000;
    7:
      seg_data0 = 7'b0001111;
    8:
      seg_data0 = 7'b0000000;
    9:
      seg_data0 = 7'b0000100;
  endcase

  case (seconds / 10)
    0:
      seg_data1 = 7'b0000001;
    1:
      seg_data1 = 7'b1001111;
    2:
      seg_data1 = 7'b0010010;
    3:
      seg_data1 = 7'b0000110;
    4:
      seg_data1 = 7'b1001100;
    5:
      seg_data1 = 7'b0100100;
  endcase
end

assign led_a = seg_data0;
assign led_b = seg_data1;

endmodule
