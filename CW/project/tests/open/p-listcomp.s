main {
	print upto( 13 );
};

fdef upto ( lim : int, step : int) {
  return [x for x in range(0, lim, step)];
} : seq<int>;
