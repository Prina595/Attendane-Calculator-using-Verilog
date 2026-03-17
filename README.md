# Attendane-Calculator-using-Verilog
Attendance Management System

Project Overview
The Attendance Management System is a project that processes and manages student attendance using Verilog hardware logic and a Python GUI interface. The system reads attendance data from memory files, processes it using a Verilog module, and displays or manages the results through a user-friendly interface. This project demonstrates the integration of Hardware Description Language (HDL) with software tools to simulate an attendance tracking system.

Features

Upload and read attendance data from Excel files

Convert attendance records into memory files (.mem)

Process attendance using Verilog logic

Store student roll numbers and attendance records

Display results through a Python GUI

Generate attendance results file

Technologies Used
Python

Tkinter (GUI)

OpenPyXL (Excel file processing)

Verilog HDL

Attendance processor module

Hardware logic simulation

Tools

Icarus Verilog (for simulation)

Excel (attendance data storage)

Project Structure
Group34_project_files
attendance_gui.py – Python GUI for attendance system
generate_memfile.py – Converts Excel attendance data to memory file
attendance_processor.v – Verilog module for processing attendance
attendance_processor.vvp – Compiled Verilog simulation file
attendance.mem – Attendance memory file
roll_numbers.mem – Roll numbers memory file
results.txt – Output results after processing
HDL_attendance.xlsx – Excel file containing attendance data

How the System Works

Input Attendance Data
Attendance is stored in an Excel file (HDL_attendance.xlsx).

Generate Memory File
generate_memfile.py converts the Excel data into .mem format.

Process Using Verilog
The attendance_processor.v module reads the .mem file and processes attendance data using hardware logic.

Simulation
The Verilog file is compiled and executed to generate results.

Display Results
The Python GUI (attendance_gui.py) allows users to interact with the system and view attendance results.

Installation and Setup

Install Required Python Libraries
Install openpyxl using pip.

Install Icarus Verilog
Download and install Icarus Verilog from its official website.

Running the Project

Step 1: Generate Memory File
Run the Python script generate_memfile.py to convert Excel data.

Step 2: Run Verilog Simulation
Compile the Verilog file using iverilog and then run it using vvp.

Step 3: Launch the GUI
Run the Python file attendance_gui.py.

Output
The system generates processed attendance data and stores the results in a file named results.txt.

Applications

Digital Logic design demonstrations

Hardware-software integration projects

Educational attendance systems

Verilog simulation practice
