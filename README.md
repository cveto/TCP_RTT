## Script for measuring Rround Trip Time with TCP. 

Instead of ICMP, TCP is used, as it can also debug handshake establishment when the two are compared.


Prerequisities:
- 


Example:
sudo bash script.sh 1000 192.168.10.4 80
500 packages already sent
1000 packages already sent
Processing...
 
SYN packets sent: 1000
SYN_ACK packets received: 1000
 
Results in seconds
avg 0.000324419  | max 0.001000  | min 0.000152450
[e130098@TESTOL8 ~]$ vi tcp.sh
[e130098@TESTOL8 ~]$ sudo bash tcp.sh 10000 172.24.193.168 1792
500 packages already sent
1000 packages already sent
1500 packages already sent
2000 packages already sent
2500 packages already sent
3000 packages already sent
3500 packages already sent
4000 packages already sent
4500 packages already sent
5000 packages already sent
5500 packages already sent
6000 packages already sent
6500 packages already sent
7000 packages already sent
7500 packages already sent
8000 packages already sent
8500 packages already sent
9000 packages already sent
9500 packages already sent
10000 packages already sent
Processing...
 
SYN packets sent: 10000
SYN_ACK packets received: 10000
 
Results in seconds
avg 0.000328899  | max 0.010000  | min 0.000149648
[e130098@TESTOL8 ~]$ sudo bash tcp.sh 10000 172.24.193.168 1792
