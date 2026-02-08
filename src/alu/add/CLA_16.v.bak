module CLA_16 (
    input [15:0] A,
    input [15:0] B,
    input cin,
    output [15:0] sum,
    output cout
    output GG16, PG16 // for next hierachy level
);

    wire [3:0] G, P;
    wire [4:1] C;

    // instantiate the 4-bit CLA blocks
    CLA_4 cla0 (.A(A[3:0]), .B(B[3:0]), .cin(cin), .sum(sum[3:0]), .GG(G[0]), .PG(P[0]));
    CLA_4 cla1 (.A(A[7:4]), .B(B[7:4]), .cin(C[1]), .sum(sum[7:4]), .GG(G[1]), .PG(P[1]));
    CLA_4 cla2 (.A(A[11:8]), .B(B[11:8]), .cin(C[2]), .sum(sum[11:8]), .GG(G[2]), .PG(P[2]));
    CLA_4 cla3 (.A(A[15:12]), .B(B[15:12]), .cin(C[3]), .sum(sum[15:12]), .GG(G[3]), .PG(P[3]));

    // carry lookahead logic for 16 bits
    assign C[1] = G[0] | (P[0] & cin);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & cin);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & cin);
    assign C[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & cin);

    assign cout = C[4];

    //group signals for next hierachy level
    assign GG16 = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);
    assign PG16 = P[3] & P[2] & P[1] & P[0];

endmodule