`define CHECK (pass ? "PASS" : "FAIL")
module test_tristate;

    reg in;
    reg en;
    wire out_h;
    wire out_l;

    tri_h #(1) ts_h(in, out_h, en);
    tri_l #(1) ts_l(in, out_l, en);

    localparam N = 4;
    reg [1:N] test_in = 8'b0011;
    reg [1:N] test_en = 8'b0101;
    reg [1:N] exp_out_h = 8'bz0z1;
    reg [1:N] exp_out_l = 8'b0z1z;

    integer i;

    integer pass;
    integer overall_pass;
    initial begin
        $dumpfile("test_tristate.vcd");
        $dumpvars(0, test_tristate);

        overall_pass = 1;
        for (i = 1; i <= N; i = i + 1) begin
            #1;
            in = test_in[i];
            en = test_en[i];
            #1;

            pass = (out_h === exp_out_h[i]);
            if (overall_pass)
                overall_pass = pass;
            $display("tri_h in=%0d, en=%0d => out=%0d, exp=%0d [%s]", in, en, out_h, exp_out_h[i], `CHECK);


            pass = (out_l === exp_out_l[i]);
            if (overall_pass)
                overall_pass = pass;
            $display("tri_l in=%0d, en=%0d => out=%0d, exp=%0d [%s]", in, en, out_l, exp_out_l[i], `CHECK);

            $display();
        end


        if (overall_pass)
            $display("PASS");
        else
            $display("FAIL");

        $finish();
    end
endmodule
