// Main Attendance Processor Module
module attendance_processor;

    // Parameters
    parameter STUDENT_COUNT = 148;

    // Registers for roll numbers, attendance, and calculations
    reg [21:0] roll_number[0:STUDENT_COUNT-1];  // Roll numbers (22 bits)
    reg [32:0] attendance[0:STUDENT_COUNT-1]; // Attendance matrix (max 1024 days for safety)
    reg [9:0] days_present[0:STUDENT_COUNT-1];  // Days present (max 1024)
    reg [9:0] days_absent[0:STUDENT_COUNT-1];   // Days absent (max 1024)
    reg [6:0] percentage[0:STUDENT_COUNT-1];    // Attendance percentage

    integer i, j;
    integer file;         // File handle for results
    integer TOTAL_DAYS;   // Total valid days dynamically calculated

    // Inline percentage calculation
    function [6:0] calculate_percentage;
        input [9:0] present_days;
        input integer total_days;
        begin
            if (total_days > 0)
                calculate_percentage = (present_days * 100) / total_days;
            else
                calculate_percentage = 0;
        end
    endfunction

    // Simulation process
    initial begin
        // Read roll numbers
        $readmemb("roll_numbers.mem", roll_number);

        // Read attendance data
        $readmemb("attendance.mem", attendance);

        // Determine TOTAL_DAYS dynamically
        TOTAL_DAYS = 0;
        for (j = 0; j < 32; j = j + 1) begin
            for (i = 0; i < STUDENT_COUNT; i = i + 1) begin
                if (attendance[i][j] === 1'b1 || attendance[i][j] === 1'b0) begin
                    if (j + 1 > TOTAL_DAYS)
                        TOTAL_DAYS = j + 1;
                end
            end
        end

        // Open output file
        file = $fopen("results.txt", "w");
        if (file) begin
            // Write header
            $fdisplay(file, "Roll Number\tDays Present\tDays Absent\tPercentage");

            // Process attendance for each student
            for (i = 0; i < STUDENT_COUNT; i = i + 1) begin
                days_present[i] = 0;

                // Count days present
                for (j = 0; j < TOTAL_DAYS; j = j + 1) begin
                    if (attendance[i][j] == 1'b1) begin
                        days_present[i] = days_present[i] + 1;
                    end
                end

                // Calculate absent days and percentage
                days_absent[i] = TOTAL_DAYS - days_present[i];
                percentage[i] = calculate_percentage(days_present[i], TOTAL_DAYS);

                // Write results to file
                $fdisplay(file, "%d\t%d\t%d\t%d%%", roll_number[i], days_present[i], days_absent[i], percentage[i]);
            end

            $fclose(file);
        end else begin
            $display("Error: Unable to open results.txt");
        end
    end

endmodule
