// =================================================================================
// Assignment - Number Base in C/C++
// =================================================================================
// Programmer: Cameron Perry
// Instructor: Mr. Conrad
// Class: CSC 11
// =================================================================================
// Description:
//		This program converts any base 10 unsighned integer into a different base
//		of the user's choice.
// =================================================================================
#include <cstdio>
int main() {
	const int NUM_DIGITS = 36;
	int digits[NUM_DIGITS];
	int newNum[NUM_DIGITS];
	unsigned int num;
	int newBase;
	int remainder;
	int counter = 0;
	int spaceCounter = 1;

	// this for-loop assigns values to the 36 elements in the digits array
	for (int i = 0; i < NUM_DIGITS; i++) {
		// the first 10 digits (0-9) are assigned the values 0 to 9
		if (i < 10)
			digits[i] = i;
		// the last 26 digits (10 - 35) are assigned the values 65 to 90
		else
			digits[i] = i + 55;
	}
	
	// the user is asked to enter a base 10 unsigned int
	printf("Enter any base 10 unsigned integer ");
	scanf("%d", &num);
	printf("\n");

	// the user is asked to enter the new base he/she wants to convert their base
	// 10 int into
	printf("What base do you want to convert the base 10 unsigned integer into? (Base must be from 2 to 36) ");
	scanf("%d", &newBase);
	printf("\n");

	while (num >= newBase) {
		remainder = num % newBase;
		// the elements in the number array are assigned values from the
		// digits array depending on the value of the remainder
		newNum[counter] = ("%d", digits[remainder]);
		// num is reassigned
		num /= newBase;
		counter++;
	}
	// once num is no longer greater than the new base the corresponding 
	// digit from the digits array is assigned to the last element
	//  in the newNum array
	newNum[counter] = digits[num];

	// for-loop used to iterate through the newNum array backwards
	// So that the new number can be displayed from right to left
	for (int i = counter; i >= 0; i--) {
		// if the element in the newNum array is less than 10 a
		// digit is displayed
		if (newNum[i] < 10)
			printf("%d", newNum[i]);
		// if the element in the newNum array is not less than 10
		// the corresponding character equivalent to that digit is displayed
		else
			printf("%c", newNum[i]);
		// this is used to create spaces every 4 digits
		if (spaceCounter % 4 == 0)
			printf(" ");
		spaceCounter++;
	}
	printf("\n\n");
}