# Digital-Clock-VHDL
A VHDL description of a digital clock system on FPGAs. Part of COL215 course project.

## Problem Statement

This exercise involves use of VHDL for describing design of a digital clock. The design is to be done keeping in view the inputs and outputs provided by a specific type of commonly usef FPGA board.

Design a digital clock that displays the time of the day in hours, minutes and seconds. Make a provision for user to set the time to a desired value. The design has to work with the following inputs and outputs provided by the BASYS3 FPGA board.
1. 4 seven-segment displays, each one can display a digit, optionally with a decimal point
2. 5 push-button switches are available, but try to use as few as possible, keeping in mind convenience of the user
3. A 10 MHz clock signal
Assume a 24 hour format for the time, that is, time would range from 00:00:00 hr:min:sec
to 23:59:59 hr:min:sec.


## Solution

The system maintains the current time, and updates it after a specific number of clock cycles (For example, if clock has a 100Hz frequency, the system will wait for 100 clock cycles). 

Different modes can be switched easily using the buttons and also, time setting can be done is slow as well as fast modes. It is easy and intuitive to set the time initially and this makes the use of the system convenient for the user.

## Conclusion

Thus, a fairly complex system like a Digital CLock system can also be described adequately by properly using a simple description language like VHDL. This is a first step to building more complex systems.
