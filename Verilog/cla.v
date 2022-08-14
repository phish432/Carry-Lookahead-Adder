// 4-Bit Carry Lookahead Adder
module cla (a, b, cin, s, c);

	// Inputs
	input [3:0] a;
	input [3:0] b;
	input cin;

	//Outputs
	output [3:0] s;
	output [3:0] c;

	// Carry Propogate and Carry Generate Stage

	// Carry Propagates p_i = a_i XOR b_i
	wire [3:0] p;
	xor P0(p[0], a[0], b[0]);
	xor P1(p[1], a[1], b[1]);
	xor P2(p[2], a[2], b[2]);
	xor P3(p[3], a[3], b[3]);

	// Carry Generates g_i = a_i AND b_i
	wire [3:0] g;
	and G0(g[0], a[0], b[0]);
	and G1(g[1], a[1], b[1]);
	and G2(g[2], a[2], b[2]);
	and G3(g[3], a[3], b[3]);

	// Carry Lookahead Stage : c_{i+1} = g_i + p_i.c_i

	wire w0, w1, w2, w3, w4, w5, w6, w7, w8, w9;

	// c1 = g0 + p0.cin
	and AND20(w0, p[0], cin);
	or  OR20 (c[0], g[0], w0);

	// c2 = g1 + p1.g0 + p1.p0.cin
	and AND21(w1, p[1], g[0]);
	and AND30(w2, p[1], p[0], Cin);
	or  OR30 (c[1], g[1], w1, w2);

	// c3 = g2 + p2.g1 + p2.p1.g0 + p2.p1.p0.cin
	and AND22(w3, p[2], g[1]);
	and AND31(w4, p[2], p[1], g[0]);
	and AND40(w5, p[2], p[1], p[0], cin);
	or  OR40 (c[2], g[2], w3, w4, w5);

	// c4 = g3 + p3.g2 + p3.p2.g1 + p3.p2.p1.g0 + p3.p2.p1.p0.cin
	and AND23(w6, p[3], g[2]);
	and AND32(w7, p[3], p[2], g[1]);
	and AND41(w8, p[3], p[2], p[1], g[0]);
	and AND50(w9, p[3], p[2], p[1], p[0], cin);
	or  OR50 (c[3], g[3], w6, w7, w8, w9);

	// Sum Stage : s_i = p_i XOR c_i
	xor S0(s[0], p[0], cin);
	xor S1(s[1], p[1], c[0]);
	xor S2(s[2], p[2], c[1]);
	xor S3(s[3], p[3], c[2]);

endmodule