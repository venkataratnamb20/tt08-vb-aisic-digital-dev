
/*
Title: 12-bit SAR Logic
Author: Venkata Ratnam Bhumireddy
Date: 24/06/2024
Description: 

*/

module sarlogic(clk, reset, d, bitout, conv_done);
  input clk;
  input reset;
  input d;
  output wire [11:0] bitout;
  output wire conv_done;
  

  // shift 1 to right and save input - d from MSB
  reg [11:0] bitout_d;
  reg [11:0] bitout_q;
  // HIGH When Conversion is done
  reg conv_done_d;
  reg conv_done_q;
  
  // state register
  reg [3:0] state_d;
  reg [3:0] state_q;
  
  assign bitout = bitout_q;
  assign conv_done = conv_done_q;
  
  always @(posedge clk) begin
    if(reset)
      begin
        bitout_q <= 12'b000000000000;
        conv_done_q <= 1'b0;
      end
    else
      bitout_q <= bitout_d;
    conv_done_q <= conv_done_d;
  end
  
  always @(posedge clk) begin
    if(reset)
      begin
        state_q <= 4'b0000;
      end
    else
      state_q <= state_d;
  end
  
  always @(*) begin
    case(state_q)
      4'b0000: 
        begin
          bitout_d = 12'b100000000000;
          conv_done_d = 0;
          state_d = state_q + 1;
        end
      4'b0001: 
        begin
          bitout_d[9:0] = bitout_q[1:0];
          bitout_d[10] = 1'b1;
          bitout_d[11] = d;
          conv_done_d = 0;
          state_d = state_q + 1;
        end
      4'b0010: 
        begin
          bitout_d[8:0] = bitout_q[8:0];
          bitout_d[9] = 1'b1;
          bitout_d[10] = d;
          bitout_d[11] = bitout_q[11];
          conv_done_d = 0;
          state_d = state_q + 1;
        end
      4'b0011: 
        begin
          bitout_d[7:0] = bitout_q[7:0];
          bitout_d[8] = 1'b1;
          bitout_d[9] = d;
          bitout_d[11:10] = bitout_q[11:10];
          conv_done_d = 0;
          state_d = state_q + 1;
        end
      4'b0100: 
        begin
          bitout_d[6:0] = bitout_q[6:0];
          bitout_d[7] = 1'b1;
          bitout_d[8] = d;
          bitout_d[11:9] = bitout_q[11:9];
          conv_done_d = 0;
          state_d = state_q + 1;
        end
      4'b0101: 
        begin
          bitout_d[5:0] = bitout_q[5:0];
          bitout_d[6] = 1'b1;
          bitout_d[7] = d;
          bitout_d[11:8] = bitout_q[11:8];
          conv_done_d = 0;
          state_d = state_q + 1;
        end
      4'b0110: 
        begin
          bitout_d[4:0] = bitout_q[4:0];
          bitout_d[5] = 1'b1;
          bitout_d[6] = d;
          bitout_d[11:7] = bitout_q[11:7];
          conv_done_d = 0;
          state_d = state_q + 1;
        end
      4'b0111: 
        begin
          bitout_d[3:0] = bitout_q[3:0];
          bitout_d[4] = 1'b1;
          bitout_d[5] = d;
          bitout_d[11:6] = bitout_q[11:6];
          conv_done_d = 0;
          state_d = state_q + 1;
        end
      4'b1000: 
        begin
          bitout_d[2:0] = bitout_q[2:0];
          bitout_d[3] = 1'b1;
          bitout_d[4] = d;
          bitout_d[11:5] = bitout_q[11:5];
          conv_done_d = 0;
          state_d = state_q + 1;
        end
      4'b1001: 
        begin
          bitout_d[1:0] = bitout_q[1:0];
          bitout_d[2] = 1'b1;
          bitout_d[3] = d;
          bitout_d[11:4] = bitout_q[11:4];
          conv_done_d = 0;
          state_d = state_q + 1;
        end
      4'b1010: 
        begin
          bitout_d[0] = bitout_q[0];
          bitout_d[1] = 1'b1;
          bitout_d[2] = d;
          bitout_d[11:3] = bitout_q[11:3];
          conv_done_d = 0;
          state_d = state_q + 1;
        end
      4'b1011: 
        begin
          bitout_d[0] = 1'b1;
          bitout_d[1] = d;
          bitout_d[11:2] = bitout_q[11:2];
          conv_done_d = 0;
          state_d = state_q + 1;
        end
      4'b1100: 
        begin
          bitout_d[11:1] = bitout_q[11:1];
          bitout_d[0] = d;
          conv_done_d = 1;
          state_d = 4'b0000;
        end
      default: 
        begin
          bitout_d = bitout_q;
          conv_done_d = 0;
          state_d = 4'b0000;
        end
    endcase
  end
endmodule
