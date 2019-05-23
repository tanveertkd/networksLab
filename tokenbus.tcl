#THEORY:
#Token bus is a LAN protocol operating in the MAC layer. Token bus is standardized as per IEEE 802.4. Token bus can operate at speeds of 5Mbps, 10 Mbps and 20 Mbps. The operation of token bus is as follows: Unlike token ring in token bus the ring topology is virtually created and maintained by the protocol. A node can receivedata even if it is not part of the virtual ring, a node joins the virtual ring only if it has data to transmit. In tokenbus data is transmitted to the destination node only where as other control frames is hop to hop. After each datatransmission there is a solicit_successsor control frame transmitted which reduces the performance of theprotocol.
#ALGORITHM:
#1. Create a simulator object
#2. Define different colors for different data flows
#3. Open a nam trace file and define finish procedure then close the trace file, and execute nam on tracefile.
#4. Create five nodes that forms a network numbered from 0 to 4
#5. Create duplex links between the nodes and add Orientation to the nodes for setting a LAN topology
#6. Setup TCP Connection between n(1) and n(3)
#7. Apply CBR Traffic over TCP.
#8. Schedule events and run the program.

set ns [new Simulator]
set nf [open out.nam w]
$ns namtrace-all $nf
proc finish {} {
global ns nf
$ns flush-trace
close $nf
exec nam out.nam &
exit 0
}
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set lan0 [$ns newLan "$n0 $n1 $n2 $n3 $n4" 0.5Mb 40ms LL Queue/DropTail MAC/Csma/Cd Channel]
set tcp0 [new Agent/TCP]
$tcp0 set class_ 1
$ns attach-agent $n1 $tcp0
set sink0 [new Agent/TCPSink]
$ns attach-agent $n3 $sink0
$ns connect $tcp0 $sink0
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.01
$cbr0 attach-agent $tcp0
$ns at 0.5 "$cbr0 start"
$ns at 4.5 "$cbr0 stop"
$ns at 5.0 "finish"
$ns run
