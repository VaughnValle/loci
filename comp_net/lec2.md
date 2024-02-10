

## Packet Switching
- store and forward
  - has to complete packet before sending it out
- Packet tranmission delay is calculated by the ff. equation
  - $L/R$ with $L$ bits and $R$ bits per second (bps)
## Circuit Switching 
- Link / User bandwidth
  - So if link = 1GBps, if each user bandwidth is 100MBps, then network can have 10 users
  - active time __does not matter__ in circuit switching since bands are pre-allocated
- ISPs are connected via Internate Exchange Points (IXPs)
- Content Provider Networks (CPNs) are used by companies to bring content closer to users

## Performance
- Packet loss happens when buffer to hold packet queues fill up
  - packets are dropped based by protocol priority (HTTP vs DNS)
    - or by first come 
- Propagation delay depends on the length of __physical__ link
  - length of __physical__ link / propagation speed
  - delay through the wire;
- Tranmission delay depends on the __virtually assigned__ tranmission rate
  - L/R
  - delay into the wire
- Nodal processing is the result of forwarding
- TTL (Time to Live) is the number of hops a packet can propagate before packets dissolve
- Packets can be retransmitted
- TCP can retransmit packets, UDP can't
- Throughput and Bandwidth depend on bottlenecks (smallest capable link)
  - bottleneck link


## Protocol Layers
- Layered Internet protocol stack
