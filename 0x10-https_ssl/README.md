# 0x0B. SSH

## Description

This project is part of the ALX System Engineering & DevOps curriculum. It introduces the basics of SSH (Secure Shell) and how to securely connect to a remote server using SSH keys.

## Tasks

### 0. Use a private key
- Write a Bash script that uses SSH to connect to a server using a private key.
- File: `0-use_a_private_key`

### 1. Create an SSH key pair
- Create a 4096-bit RSA key pair named `school`, protected with the passphrase `betty`.
- File: `1-create_ssh_key_pair`

### 2. Client configuration file
- Share an SSH client config file that uses a specific private key and disables password authentication.
- File: `2-ssh_config`

### 3. Let me in!
- Add a given public key to your server's `authorized_keys` to allow access.

## Usage

Make the scripts executable:

```bash
chmod +x 0-use_a_private_key
chmod +x 1-create_ssh_key_pair
