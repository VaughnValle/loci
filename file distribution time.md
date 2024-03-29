legend:
- $N$ file copies
- $u_s$ server upload capacity
- $d_i$ peer $i$ download capacity
- $u_i$ peer $i$ upload capacity

for [[client-server]]
$$
D_{c-s}\geq max(\cdot \frac {N\cdot F} {u_s}, \frac F {d_{min}})
$$
for [[P2P]]
$$
D_{p2p} \geq max(\frac F {u_s}, \frac F {d_{min}}, \frac {N\cdot F}{u_s + \sum u_i})
$$

