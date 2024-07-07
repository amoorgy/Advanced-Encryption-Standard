# 8086 Implementation of 128-bit Advanced Encryption Standard (AES)

## Project Overview

The Advanced Encryption Standard (AES) is a widely used symmetric block cipher established by the U.S. government to secure sensitive information. This project involves implementing a single cycle of the AES algorithm for a 128-bit block size and a 128-bit key on the 8086 microprocessor. The implementation includes reading 128-bit input from the user, performing the AES encryption, and displaying the result.

## Project Requirements

1. **Input/Output Procedures**: 
    - Implement two procedures based on interrupts to read 128-bit input from the user and print the result on the screen.

2. **AES Modules Using Macros**:
    - Implement the following AES modules using macros:
        - `SubBytes()`
        - `ShiftRows()`
        - `MixColumns()`
        - `AddRoundKey()`
    - These macros should operate on 128-bit data.

3. **Main Program**:
    - Use the implemented macros and subroutines to perform 10 rounds of AES encryption.
    - Read the data from the user, apply the AES rounds, and print the encrypted result.

4. **Key Schedule (Bonus)**:
    - Implement the Key Schedule for AES (required for groups of 4 students, optional as a bonus for smaller groups).

5. **Testing**:
    - Use the key and input provided by the AES standard for testing purposes.

6. **EMU8086 Emulator**:
    - The use of the EMU8086 emulator is encouraged for this project, though other 8086 emulators are acceptable.

## Files

### main.asm

This file contains the complete implementation of the AES encryption algorithm for the 8086 microprocessor. Below is a breakdown of the main sections of the code:

- **Data Segment**: Defines necessary variables, constants (such as SBox and Rcon), input buffers, and temporary storage.
- **Code Segment**: Contains the main program logic, input/output procedures, and AES encryption macros.

### Functions and Macros

- **Input/Output Procedures**:
    - `input_characters`: Reads 16 ASCII characters (128 bits) from the user.
    - `print_characters`: Prints 16 ASCII characters.
    - `input_digits_hex`: Reads 32 hexadecimal digits (128 bits) from the user.
    - `print_digits`: Prints 16 bytes as hexadecimal digits.
    - `convert_to_hex`: Converts an ASCII character to its hexadecimal value.
    - `print_hex_nibble`: Prints a single hexadecimal nibble.

- **AES Macros**:
    - `First_Stage`: Initial round key addition.
    - `SubBytes`: Performs the SubBytes transformation using the S-Box.
    - `SHIFT`: Performs the ShiftRows transformation.
    - `MixColumns`: Performs the MixColumns transformation.
    - `ADD_ROUND_KEYS`: Adds the round keys and generates new keys for each round.

### Sample Usage

1. **Reading User Input**:
    - The program prompts the user to input either 16 ASCII characters or 32 hexadecimal digits.

2. **AES Encryption**:
    - The program applies 10 rounds of AES transformations (SubBytes, ShiftRows, MixColumns, AddRoundKey) to the input data.

3. **Output**:
    - The encrypted result is printed to the screen in either ASCII or hexadecimal format based on the input format.

### Running the Program

To run the program on the EMU8086 emulator:

1. Load the `main.asm` file into the EMU8086 emulator.
2. Assemble and run the program.
3. Follow the on-screen prompts to input the data.
4. The program will display the encrypted result after performing the AES encryption.

### Key Points

- **SubBytes**: Uses the S-Box for byte substitution.
- **ShiftRows**: Rotates the rows of the state array.
- **MixColumns**: Multiplies the state columns by a fixed polynomial.
- **AddRoundKey**: XORs the state with the round key.

## References

- [NIST AES Standard](http://csrc.nist.gov/publications/fips/fips197/fips-197.pdf)
- [Rijndael Animation](https://formaestudio.com/rijndaelinspector/archivos/Rijndael_Animation_v4_enghtml5.html)
- [MixColumns Description](http://www.angelfire.com/biz7/atleast/mix_columns.pdf)
- [EMU8086 Emulator](http://www.emu8086.com)

## Conclusion

This project demonstrates a thorough implementation of the AES encryption algorithm on the 8086 microprocessor. By breaking down the algorithm into individual macros and procedures, we achieve a modular and understandable approach to AES encryption. The project serves as a practical exercise in both cryptography and assembly language programming.
