#!/bin/bash

# Function to decrypt a string using RSA private key
decrypt() {
    private_key=$1
    encrypted_text=$2
    decrypted=$(echo "$encrypted_text" | openssl base64 -d | openssl rsautl -decrypt -inkey "$private_key")
    echo "$decrypted"
}

# Main script

# Provide the path to your RSA private key file
private_key_file="private.pem"

if [ $# -eq 0 ]; then
    echo "Usage: $0 <encrypted_text_file>"
    exit 1
fi

encrypted_text_file=$1

# Check if the file exists
if [ ! -f "$encrypted_text_file" ]; then
    echo "Error: Encrypted text file not found."
    exit 1
fi

# Read the encrypted string from the file
encrypted_text=$(cat "$encrypted_text_file")

# Decrypt the encrypted string
if [ -n "$private_key_file" ]; then
    decrypted=$(decrypt "$private_key_file" "$encrypted_text")
    echo "Decrypted string: $decrypted"
else
    echo "Error: Private key file not provided."
    exit 1
fi

