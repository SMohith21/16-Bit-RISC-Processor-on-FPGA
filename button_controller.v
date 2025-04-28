module button_controller(
    input clk,
    input reset,
    input btnc,
    output btnc_db,
    output btnc_pressed,
    output btnc_released
);
    reg [2:0] btn_sync;
    reg btnc_prev;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            btn_sync <= 3'b000;
            btnc_prev <= 0;
        end else begin
            btn_sync <= {btn_sync[1:0], btnc};
            btnc_prev <= btnc_db;
        end
    end

    assign btnc_db = &btn_sync;
    assign btnc_pressed = btnc_db & ~btnc_prev;
    assign btnc_released = ~btnc_db & btnc_prev;
endmodule