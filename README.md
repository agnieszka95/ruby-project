# Distributed Ruby code execution system

This project demonstrates a simple distributed system using DRb (Distributed Ruby) where:

Computer 1 (Client) sends a Ruby program to

Computer 2 (Server), which verifies the syntax, executes it, and returns results along with a similarity report.

# Project structure
```plaintext
project-root/
├── k1.rb               # Client: Sends code and receives results
├── k2.rb               # Server: Receives, executes, and analyzes code
├── program.txt         # The Ruby code to be tested
├── programs/           # Directory where server stores received scripts
└── README.md           # This file
```

# Requirements
- Ruby installed on both machines (preferably version 2.5 or later)

- DRb library (built-in with Ruby)

- Basic knowledge of TCP/IP networking if used across real machines

# How it works

1. Start the server:
```bash
ruby k2.rb
```
- Starts the DRb service on localhost:8888

- Waits for incoming code

- Analyzes the syntax and executes the code

- Stores received scripts in programs/

- Compares existing files for similarity

2. Prepare a Ruby script to test:

- Place the Ruby code you want to send in a file called program.txt.

3. Run the Client:

```bash
ruby k1.rb
```

- Connects to the server via DRb

- Reads the code from program.txt

- Sends it to the server

- Receives syntax check results and output

- Prints a similarity report between stored scripts
