### Topic 5: Implementation of Basic Ciphers

Description: This project aims to demonstrate various simple ciphers, such as the Vernam Cipher, Caesar Cipher, Atbash Cipher, and potentially others, using basic logic gates and flip-flops on the Nexys A7 FPGA board. Each cipher enabling users to input plaintext messages and observe the resulting ciphertext generated by the encryption process. Buttons and switches can serve as input devices for users to input plaintext messages and control the encryption/decryption process. LEDs can provide visual feedback on the status of the encryption/decryption process, indicating ready to receive input, encryption/decryption in progress, and complete. The 7-segment display shows the ciphertext or plaintext output.

### Team members
* Tomáš Šebestyán
* Martin Poč
* Elena Melicharová
* Jan Slavik

## Theoretical description and explanation

Enter a description of the problem and how to solve it.

### Caesarova šifra 

Caesar's Cipher consists in shifting the characters in the entered text by the same entered numerical value in the alphabet. For example, if you enter 'hello' and shift is set to 1, then all the characters in this word will be shifted exactly one character forward, i.e. a 'beep' will be produced.

### Vernamova šifra

The Vernam Cipher lies in the entered password. The text is shifted by just as many characters as the individual letters in the password, depending on the sequence. For example, if we enter 'hello' and 'a' as the password, then all the letters in the word will be moved by exactly one -> 'beep' will be created.

### Atbashova šifra

Atbash Cipher is a simple, classic, monoalphabetic substitution cipher, built on one coding table. The basic principle of Atbash is to reverse the order of characters in the encryption table. The first character of the plaintext alphabet thus corresponds to the last character of the cipher alphabet.

![abc](https://github.com/Keshaay/Project/blob/main/.PNG/atbash_abeceda.png)

## Hardware description of demo application

Zde je ukázka našeho top_levelu, který jsme naimplementovali na desku NEXYS A7 50t

![toplvl1](https://github.com/Keshaay/Project/blob/main/.PNG/toplevel_1.png)
![toplvl2](https://github.com/Keshaay/Project/blob/main/.PNG/toplevel_2.png)
![toplvl3](https://github.com/Keshaay/Project/blob/main/.PNG/toplevel_3.png)

## Software description

### Caesarova šifra 

![cesr](https://github.com/Keshaay/Project/blob/main/.PNG/cesar.png)
### Vernamova šifra

![cesr](https://github.com/Keshaay/Project/blob/main/.PNG/vernam.png)
### Atbashova šifra
Zde můžeme vidět testbench, který ukazuje jak naše šífra funguje

![cesr](https://github.com/Keshaay/Project/blob/main/.PNG/atbash.png)

Put flowchats/state diagrams of your algorithm(s) and direct links to source/testbench files in `src` and `sim` folders. 

### Component(s) simulation

Write descriptive text and put simulation screenshots of your components.

## Instructions

Write an instruction manual for your application, including photos and a link to a short app video.

## References
