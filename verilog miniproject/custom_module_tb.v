module custom_module_tb;

    // Inputs
    reg clk;
    reg reset;
    reg [1:0] select;
    reg serial_in;
    reg [7:0] parallel_in;

    // Outputs
    wire [7:0] parallel_output;

    // Instantiate the Unit Under Test (UUT)
    custom_module uut (
        .clk(clk),
        .reset(reset),
        .select(select),
        .serial_in(serial_in),
        .parallel_in(parallel_in),
        .parallel_output(parallel_output)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock period of 10 time units
    end

    // Test sequence
    initial begin
        // Initialize inputs
        reset = 0;
        select = 2'b00;
        serial_in = 0;
        parallel_in = 8'b10101010;

        // Apply reset
        #10 reset = 1;

        // Test shift right
        #10 select = 2'b00; serial_in = 1;
        #10 select = 2'b00; serial_in = 0;
        #10 select = 2'b00; serial_in = 1;

        // Test shift left
        #10 select = 2'b01; serial_in = 1;
        #10 select = 2'b01; serial_in = 0;
        #10 select = 2'b01; serial_in = 1;

        // Test loading parallel input (no serial input involved)
        #10 select = 2'b11;

        // Test shifting into temp register
        #10 select = 2'b10; serial_in = 1;
        #10 select = 2'b10; serial_in = 0;
        #10 select = 2'b10; serial_in = 1;

        // End of test
        #20 $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0d, clk: %b, reset: %b, select: %b, serial_in: %b, parallel_in: %b, parallel_output: %b",
                 $time, clk, reset, select, serial_in, parallel_in, parallel_output);
    end

endmodule

