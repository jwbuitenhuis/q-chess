\l knight.q
\d .chess

show `knight
knight[64#0;0]~10 17
knight[64#0;1]~11 16 18
knight[64#0;2]~8 12 17 19
knight[64#0;56]~41 50
knight[64#0;35]~18 20 25 29 41 45 50 52

/ friends
knight[3,(9#0),1,(53#0);0]~1#17

/ black
knight[-3,(9#0),-1,(53#0);0]~1#17
