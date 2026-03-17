import openpyxl

def generate_mem_files_from_excel(excel_file="HDL_attendance.xlsx", 
                                   roll_numbers_file="roll_numbers.mem", 
                                   attendance_file="attendance.mem"):
    try:
        # Load the workbook and sheet
        wb = openpyxl.load_workbook(excel_file)
        sheet = wb.active  # Assuming the data is in the first sheet

        # Open the memory files for writing
        with open(roll_numbers_file, "w") as roll_file, open(attendance_file, "w") as attendance_file:
            # Iterate over the rows in the Excel sheet (skip the header row)
            for row in sheet.iter_rows(min_row=2, values_only=True):  # Skip header row
                roll_number = row[0]  # Roll Number is in the first column
                attendance_data = row[1:]  # Attendance data starts from the second column

                # Convert roll number (last digits) to binary (7 bits)
                roll_number_bin = f"{int(roll_number):07b}"
                roll_file.write(roll_number_bin + "\n")

                # Determine the number of days from the attendance data
                num_days = len(attendance_data)  # Number of days (columns)

                # Convert attendance data (1 or 0) to a binary string based on the number of days
                attendance_bin = ''.join([str(day) for day in attendance_data])

                # Ensure the attendance data is exactly `num_days` bits long
                if len(attendance_bin) != num_days:
                    raise ValueError(f"Attendance data for Roll Number {roll_number} does not match the expected number of days ({num_days}).")

                # Write the attendance binary string to the mem file
                attendance_file.write(attendance_bin + "\n")

        print(f"Files {roll_numbers_file} and {attendance_file} generated successfully.")
    
    except Exception as e:
        print(f"Error generating MEM files: {e}")

# Example usage: specify the Excel file path and run the function
generate_mem_files_from_excel("HDL_attendance.xlsx")
