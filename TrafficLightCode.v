module traffic_light_controller (
    input wire clk,          // FPGA clock (e.g., 50MHz)
    input wire reset_n,      // Active-low reset
    output reg red_ns,       // North-South Red light
    output reg yellow_ns,    // North-South Yellow light
    output reg green_ns,     // North-South Green light
    output reg red_ew,       // East-West Red light
    output reg yellow_ew,    // East-West Yellow light
    output reg green_ew      // East-West Green light
);

// Define states
typedef enum {
    NS_GREEN_EW_RED,
    NS_YELLOW_EW_RED,
    NS_RED_EW_GREEN,
    NS_RED_EW_YELLOW
} traffic_state_t;

// State register
traffic_state_t current_state, next_state;

// Timing parameters (in clock cycles)
parameter GREEN_TIME  = 25_000_000; // 0.5 sec at 50MHz
parameter YELLOW_TIME = 5_000_000;  // 0.1 sec at 50MHz
parameter ALL_RED_TIME = 1_000_000; // Brief all-red for safety

// Timer register
reg [31:0] timer;

// State machine
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        current_state <= NS_GREEN_EW_RED;
        timer <= 0;
    end else begin
        // Update timer
        if (timer > 0) begin
            timer <= timer - 1;
        end else begin
            current_state <= next_state;
            
            // Set timer for next state
            case (next_state)
                NS_GREEN_EW_RED:  timer <= GREEN_TIME;
                NS_YELLOW_EW_RED: timer <= YELLOW_TIME;
                NS_RED_EW_GREEN:  timer <= GREEN_TIME;
                NS_RED_EW_YELLOW: timer <= YELLOW_TIME;
                default:          timer <= GREEN_TIME;
            endcase
        end
    end
end

// Next state logic
always @(*) begin
    case (current_state)
        NS_GREEN_EW_RED:  next_state = (timer == 0) ? NS_YELLOW_EW_RED : NS_GREEN_EW_RED;
        NS_YELLOW_EW_RED: next_state = (timer == 0) ? NS_RED_EW_GREEN  : NS_YELLOW_EW_RED;
        NS_RED_EW_GREEN:  next_state = (timer == 0) ? NS_RED_EW_YELLOW : NS_RED_EW_GREEN;
        NS_RED_EW_YELLOW: next_state = (timer == 0) ? NS_GREEN_EW_RED  : NS_RED_EW_YELLOW;
        default:          next_state = NS_GREEN_EW_RED;
    endcase
end

// Output logic
always @(*) begin
    // Default outputs (all lights off - for safety)
    red_ns = 1'b0;
    yellow_ns = 1'b0;
    green_ns = 1'b0;
    red_ew = 1'b0;
    yellow_ew = 1'b0;
    green_ew = 1'b0;
    
    case (current_state)
        NS_GREEN_EW_RED: begin
            green_ns = 1'b1;
            red_ew = 1'b1;
        end
        NS_YELLOW_EW_RED: begin
            yellow_ns = 1'b1;
            red_ew = 1'b1;
        end
        NS_RED_EW_GREEN: begin
            red_ns = 1'b1;
            green_ew = 1'b1;
        end
        NS_RED_EW_YELLOW: begin
            red_ns = 1'b1;
            yellow_ew = 1'b1;
        end
    endcase
end

endmodule