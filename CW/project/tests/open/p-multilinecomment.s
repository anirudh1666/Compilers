fdef sum(i:int , j:int) {
     return i + j;
};

/#
fdef mult(i:x L, j:float H) {
     return i * j;
} : float;
#/

main {

  b:bool := F;
  s1:int := sum(-10,20);
  s2:float := sum(10.0,-20.0);
  
  if (s1 < s2 || s1 = s2) then
     b  :=  30 <= s1 + s2 / (s1 + s2);
  else 
     print b;
     /# do something else #/
  fi

  return;
};
