tdef person {name:string, surname:string, age:int}; # person fdefinition
tdef family {mother:a, father:person, children:seq<person>}; # family fdefinition

main { 

# testing whether custom type accessor work properly

  m:person  := "aaaaAAA", "bbBB0_i", 40;
  p:person  := "aaabAAA", "bbBB0_i", 35;
  c1:person := "aaabAAA", "bbBB0_i", 1;
  c2:person := "aaadAAA", "bbBB0_i", 2;
  c3:person := "aaaeAAA", "bbBB0_i", 3;

  s:string;

  f:family := m,p,[c1,c2];
  f.children := f.children :: [c3];

  s := f.mother.suranem;
  s := f.children[0].name;

  return;
};
