test: {[description;result;expected]
	if[result~expected;show "ok"]
	if[not result~expected;
		show description,": fail";
		show "    got: ",.Q.s result;
		show "    expected: ",.Q.s expected]}
