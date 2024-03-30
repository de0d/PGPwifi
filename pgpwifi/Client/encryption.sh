#!/bin/bash

# Function to encrypt a string using RSA public key
encrypt() {
    public_key=$1
    plaintext=$2
    encrypted=$(echo "$plaintext" | openssl rsautl -encrypt -pubin -inkey "$public_key" | openssl base64 -A)
    echo "$encrypted"
}

# Main script

# Provide the path to your RSA public key file
public_key_file="public.pem"

if [ $# -eq 0 ]; then
    echo "Usage: $0 <plaintext_file>"
    exit 1
fi

plaintext_file=$1

# Check if the file exists
if [ ! -f "$plaintext_file" ]; then
    echo "Error: Plaintext file not found."
    exit 1
fi

# Read the plaintext from the file
plaintext=$(cat "$plaintext_file")

# Encrypt the provided string
if [ -n "$public_key_file" ]; then
    encrypted=$(encrypt "$public_key_file" "$plaintext")
    echo "$encrypted" > crypted_string.txt
else
    echo "Error: Public key file not provided."
    exit 1
fi
