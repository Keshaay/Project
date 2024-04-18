### Topic 5: Implementation of Basic Ciphers

Description: This project aims to demonstrate various simple ciphers, such as the Vernam Cipher, Caesar Cipher, Atbash Cipher, and potentially others, using basic logic gates and flip-flops on the Nexys A7 FPGA board. Each cipher enabling users to input plaintext messages and observe the resulting ciphertext generated by the encryption process. Buttons and switches can serve as input devices for users to input plaintext messages and control the encryption/decryption process. LEDs can provide visual feedback on the status of the encryption/decryption process, indicating ready to receive input, encryption/decryption in progress, and complete. The 7-segment display shows the ciphertext or plaintext output.

### Team members
* Tomáš Šebestyán
* Martin Poč
* Elena Melicharová
* Jan Slavik

## Theoretical description and explanation

Enter a description of the problem and how to solve it.

#Caesarova šifra 

spočívá v posunu znaků v zadaném textu vždy o stejnou zadanou číselnou hodnotu v abecedě. Například pokud zadáte 'ahoj' a posun zvolíte 1 pak se všechny znaky v tomto slově posunou právě o jeden znak vpřed čili vznikne 'bipk'.

#Vernamova šifra

spočívá v zadaném hesle. Text se posune právě o tolik znaků, kolik činí v závislosti na posloupnosti jednotlivá písmena v hesle. Pokud například zadáme 'ahoj' a jako heslo 'a' pak se všechna písmena ve slově posunou právě o jedno -> vznikne 'bipk'.

#Atbashova šifra

je jednoduchou, klasickou, monoalfabetickou substituční šifrou, postavenou na jedné kódovací tabulce. Základním principem Atbashe je převrácení pořadí znaků v šifrovací tabulce. První znak abecedy otevřeného textu tak odpovídá poslednímu znaku abecedy šifry.

![abc](https://github.com/Keshaay/Project/blob/main/.PNG/atbash_abeceda.png)

## Hardware description of demo application

Insert descriptive text and schematic(s) of your implementation.

## Software description

Put flowchats/state diagrams of your algorithm(s) and direct links to source/testbench files in `src` and `sim` folders. 

### Component(s) simulation

Write descriptive text and put simulation screenshots of your components.

## Instructions

Write an instruction manual for your application, including photos and a link to a short app video.

## References
