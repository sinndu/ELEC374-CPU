module CLA_4 (
    input [3:0] A,
    input [3:0] B,
    input cin,
    output [3:0] sum,
    output GG, PG // for next hierachy level
);
    wire [3:0] g, p;
    wire [4:0] c;
    assign c[0] = cin;

    // instantiate the partial full adders
    PFA pfa0 (A[0], B[0], c[0], sum[0], g[0], p[0]);
    PFA pfa1 (A[1], B[1], c[1], sum[1], g[1], p[1]);
    PFA pfa2 (A[2], B[2], c[2], sum[2], g[2], p[2]);
    PFA pfa3 (A[3], B[3], c[3], sum[3], g[3], p[3]);

    // carry lookahead logic
    assign c[1] = g[0] | (p[0] & c[0]);
    assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c[0]);
    assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & c[0]);
    
    //group signals for CLA_16 to look at
    assign GG = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);
    assign PG = p[3] & p[2] & p[1] & p[0];

endmodule