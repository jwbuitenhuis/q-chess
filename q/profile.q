.prof.events:flip `id`pid`func`time!"jjsn"$\:()
.prof.pid:.prof.id:0

.prof.time:{[n;f;a]
	s:.z.p;
	id:.prof.id+:1;
	pid:.prof.pid;
	r:f . a;
	.prof.pid: pid;
	`.prof.events upsert (id;pid;n;.z.p-s);
	r
	}

.prof.instr:{[n]
	m: get f:get n;
	system "d .",string first m 3;
	n set (')[.prof.time[n;f];enlist];
	system "d .";
	n
	}

.prof.dirs:{(` sv x,) each key[x] except `q`Q`h`j`o`prof}
.prof.tree:{$[x~k:key x;x;11h=type k;raze (.z.s ` sv x,) each k;()]}
.prof.lambdas:{x where 100h=(type get@) each x}
.prof.instrall:{
	show each l:.prof.lambdas raze .prof.tree each `.,.prof.dirs`;
	.prof.instr each l}

.prof.stats:{[e]
	e:e pj select neg sum time,nc:count i by id:pid from e;
	s:select sum time*1e-6,n:count i,avg nc by func from e;
	s:update timepc:time%n from s;
	s:`pct xdesc update pct:100f*time%sum time from s;
	s
	}