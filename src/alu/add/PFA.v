module PFA (
    input a, b, cin,
    output s, g, p
);
    assign s = a ^ b ^ cin; // sum
    assign g = a & b;       // generate
    assign p = a ^ b;       // propagate
endmodule