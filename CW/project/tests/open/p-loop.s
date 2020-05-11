s1:string := "Alice in Wonderland";
s2:string := "Gilgamesh";
s3:string := "One Thousand and One Nights";

main {
  books:seq<string> :=[s1,s2,s3];
  key:string := "ic";  
  found:bool := F;
  i:int := 0;
  tmp:string;

  loop
      if (i < len(books)) then
        break;
      fi
      tmp := books[i];
      if (key = tmp) then found := T; fi
      i := i + 1;
  pool
};
