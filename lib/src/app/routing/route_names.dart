enum RouteNames {
  login('/login', 'login'),
  app('/app', 'app'),
  guest('/guest', 'guest');
  final String path;
  final String name;
  const RouteNames(this.path, this.name);
}