`timescale 1ns/1ps
module testbench();
	reg [3:0] a;
	reg [3:0] b;
	reg cin;

	output [3:0] s;
	output [3:0] c;

	cla X(a, b, cin, s, c);

	initial begin
		$dumpfile("cla.vcd");
		$dumpvars(0,testbench);

		$monitor($time, " a = %d, b = %d, cin = %d, carry = %d, sum = %d", a, b, cin, c[3], s);
		a = 4'd0; b = 4'd0; cin = 1'd0;

		#20 a = 4'd6; b = 4'd2; cin = 0;
		#20 a = 4'd3; b = 4'd10; cin = 0;
		#20 a = 4'd11; b = 4'd10; cin = 1;
		#20 a = 4'd0; b = 4'd0; cin = 0;
		#20 a = 4'd9; b = 4'd0; cin = 1;
		#20 a = 4'd15; b = 4'd15; cin = 1;
		#20 a = 4'd6; b = 4'd2; cin = 0;
		
		$finish;
	end
endmodule