fdef foo( pos : int) { 
	if (pos = -1) then
		return 0;
	else 
		return 1;
	fi	
	return add( foo( pos-1 ), foo( pos-2 ) );
} : int ;

main {
	print foo( 13 );
	return;
};

fdef add (x:int, y:int) {
	return x + y;
} : int;
