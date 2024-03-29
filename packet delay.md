- can occur from 4 main sources

1. transmission delay
	1. $d_{trans} = \frac L R$
		1. $L$, packet length
		2. $R$, link rate
2. propagation delay
	1. $d_{prop} =\frac d s$
		1. $d$, length of physical link or distance
		2. $s$, propagation speed 
3. nodal processing
	1. processing bit errors
	2. checksum
	3. typically just microsecs
4. [[queueing]] and [[packet queueing]]
	1. $\frac {L\cdot a}{R}$ [[Traffic Intensity]]
		1. $L$, packet length
		2. $a$, average packet arrival rate
		3. $R$, link bandwidth
	2. If $\frac {L\cdot a}{R} < 0$, small
	3. If $\frac {L\cdot a}{R} = 0$, average
	4. If $\frac {L\cdot a}{R} > 0$, packets are queueing
Delay can be determined via [[traceroute]]