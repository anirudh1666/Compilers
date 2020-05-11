main {
	tdef person { name:string, surname:string, age:int};
	tdef family { mother:person, father:person, children:seq<person> };
	return;
};
