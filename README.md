The Advanced Encryption Standard (AES) is a widely adopted encryption algorithm for securing data in modern  communication systems, including 5G
The objective of this project is to design and implement an AES-based encryption and decryption module for a 5G security protocol on FPGA. The solution should integrate with the 5G protocol stack, ensuring that data transmitted over the network is securely encrypted and decrypted, meeting the high-throughput and low-latency requirements of 5G applications.
parallelism  Achieve high throughput by processing multiple operations concurrently by harnessing FPGA’s parallelism
High-Throughput and Low-Latency  The AES module must handle large data volumes quickly with minimal delay. Parallelism and pipelining ensure fast encryption and decryption, meeting 5G's strict throughput and latency demands.
Integration with 5G Protocol Stack The AES module integrates into the 5G security stack, providing encryption before transmission and decryption upon reception, ensuring secure and efficient data transmission.
pipelining Minimize latency by processing multiple AES stages simultaneously.
The AES process is broken into stages while allowing continuous data flow, where new 	blocks are processed without waiting for previous stages, reducing overall latency
