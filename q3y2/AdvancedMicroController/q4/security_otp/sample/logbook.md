# logbook for security & otp memory
authors: aldoff nyerere, felipe de paula
date: may 30, 2026

## step 1: making the key
i looked at the pico c sdk pdf (page 14ish) and found the command for the private key. need to use openssl with the prime256v1 curve because thats what the rp2350 wants for secure boot.
command i used:
openssl ecparam -name prime256v1 -genkey -noout -out private_key.pem
this made the .pem file in my folder. i should probly not share this key with anyone lol.

## step 2: updating cmakelists
the assignment asked to sign the program. i found the pico_sign_binary function. i added it right after the target_link_libraries part.
i used:
pico_sign_binary(${PROJECT} KEY private_key.pem)

## step 3: checking the build files
after i ran the build i checked the build folder. there was a new file there with the .json extention. i think its called otp_config.json or something like that. this file has the hash of my public key which is what actually goes on the chip.

## step 4: otp loading
final step was finding how to actually put it on the pico 2. the command is picotool otp load. i have to be super careful with this because otp stands for one time programable so if i mess it up i might brick the board.
command:
picotool otp load trusted_program.json

done with the assignment. logic seems solid based on the advmicro-otp.pdf slides.
