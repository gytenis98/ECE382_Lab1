ECE382_Lab1
===========

###Simple Calculator

![Simple calculator](https://raw.githubusercontent.com/gytenis98/ECE382_Lab1/master/msp-exp430g2-e1281671410523.jpg?raw=true "Simple calculater")

##Objectives

To create a simple calculater on the MSP430 board

##Design chart

![Design chart](http://i61.tinypic.com/33xyio8.png?raw=true "Design chart")

##Required Functionality (done)

•The input and output for the calculator will be in memory locations. The calculator operations and operands will be stored in ROM - any location in ROM is acceptable. The results of the calculations will be stored in RAM starting at 0x0200. Labels shall be used in the program to refer to the location of your instructions and results.
•The input operands and output results will be positive integers between 0 and 255 (an unsigned byte).
•Good coding standards (labels, .equ where appropriate) must be used throughout.


##B Functionality (done)

In addition to the Required Functionality, your program will meet the following requirement:
•If a result exceeds 255, it is set to the maximum value of 255. If a result is less than 0, it is set to the minimum value of 0.

##A Functionality (Could not make it work)

In addition to B Functionality, your program will implement a multiply operation:

MUL_OP
An multiplication operation is coded by the value 0x33. It multiplies two numbers and stores the result.
The calculator program 0x02 0x33 0x04 is equivalent to 0x02 * 0x04. It would store the result 0x08.

The MSP430G2553 that you're using does not have a hardware multiplier, so you'll have to get creative to implement this.

There are a couple of ways to implement multiply - strive for the fastest possible implementation. Solutions that multiply in O(n) time will receive half points. Only solutions that multiply in O(log n) time will receive full points.

O(n) means that the time it takes to reach a solution varies with the size of the input. O(log n) means that time to solvevaries with the log of the size of the input.

##Debugging

The main problem occured with incrementing stored values. I could not make it work at first. I looked at few examples in the internet as well as in other people works and finally made it work. 

##Test cases values tested in this lab was as following:

### For "Required Functionality":

0x11, 0x11, 0x11, 0x11, 0x11, 0x44, 0x22, 0x22, 0x22, 0x11, 0xCC, 0x55

Result: 0x22, 0x33, 0x00, 0x00, 0xCC

###For "B Functionality":

0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0xDD, 0x44, 0x08, 0x22, 0x09, 0x44, 0xFF, 0x22, 0xFD, 0x55

Result: 0x22, 0x33, 0x44, 0xFF, 0x00, 0x00, 0x00, 0x02

###For "A Functionallity" did not work.


##Demonstartions: 
Prelab --> 5 points (On time)

Required functionality --> 35 points (on time)

B functionality   --> 10 points (on time)

A functionality --> 0 points (not done)

##Documentation
I used the Dr. Coulston handouts from class as well as MSP430 family user's guide. Also, I used internet to find how to do jumps and other peoples programs to find out how to properly increment location.


