enum MyState {
  noCookie,
  withCookie,
  waiting
}


class WebState {
  MyState state;
  String cookie;
  WebState({
    required this.state,
    required this.cookie
  });
}