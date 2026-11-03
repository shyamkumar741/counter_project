// N-bit Synchronous Up/Down Counter with Load and Enable controls
module counter #(
    parameter N = 4 // Default width is 4 bits, adjustable at instantiation
)(
    input wire             clk,       // Clock signal
    input wire             reset,     // Active-high synchronous reset
    input wire             enable,    // Counter enable control
    input wire             up_down,   // 1 for counting UP, 0 for counting DOWN
    input wire             load,      // Active-high load control
    input wire     [N-1:0] data_in,   // Parallel data input for loading
    output reg     [N-1:0] count      // Counter register output
);

    // Sequential logic triggered on the rising edge of the clock
    always @(posedge clk) begin
        if (reset) begin
            count <= {N{1'b0}};       // Reset counter output to zero
        end 
        else if (load) begin
            count <= data_in;         // Load parallel data input
        end 
        else if (enable) begin
            if (up_down) begin
                count <= count + 1'b1; // Increment counter
            end 
            else begin
                count <= count - 1'b1; // Decrement counter
            end
        end
        // If enable is 0, the counter holds its current value implicitly
    end

endmodule
