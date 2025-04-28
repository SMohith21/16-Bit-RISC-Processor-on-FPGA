module last_written_tracker(
    input clk,
    input reset,
    input btnc_released,
    input reg_write,
    input [15:0] reg_write_data,
    input btnc_db,
    input [15:0] reg_data2,
    output reg [15:0] out
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= 16'd0;
        else if (btnc_released && reg_write)
            out <= reg_write_data;
        else if (btnc_db)
            out <= reg_data2;
    end
endmodule