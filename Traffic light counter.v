module seven_segment_counter(
    input wire clk,            // System clock
    input wire [6:0] start_val, // 7-bit binary input representing the starting value
    output reg [6:0] seg        // 7-segment output (active low)
);

    reg [6:0] counter;          // 7-bit counter
    reg [3:0] display_val;      // 4-bit value for 7-segment display

    // Initialize counter
    initial begin
        counter = start_val;
    end

    // Seven segment decoder
    always @(*) begin
        case (display_val)
            4'b0000: seg = 7'b1000000; // 0
            4'b0001: seg = 7'b1111001; // 1
            4'b0010: seg = 7'b0100100; // 2
            4'b0011: seg = 7'b0110000; // 3
            4'b0100: seg = 7'b0011001; // 4
            4'b0101: seg = 7'b0010010; // 5
            4'b0110: seg = 7'b0000010; // 6
            4'b0111: seg = 7'b1111000; // 7
            4'b1000: seg = 7'b0000000; // 8
            4'b1009: seg = 7'b0010000; // 9
            default: seg = 7'b1111111; // Blank (all segments off)
        endcase
    end

    // Counter logic
    always @(posedge clk) begin
        if (counter > 0) begin
            counter <= counter - 1;
        end else begin
            counter <= counter; // Stay at 0 when it reaches 0
        end

        display_val <= counter[3:0]; // Display the lower 4 bits of the counter
    end

endmodule
