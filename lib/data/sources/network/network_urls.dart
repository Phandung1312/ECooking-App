class NetworkUrls {
  static const String auth = '/auth';
  static const String refresh = '$auth/refresh';
  static const String login = 'login';
  static const String googleLogin = '$auth/$login/google';
  static const String recipe = '/recipes';
  static const String search = '/search';
  static const String suggestSearch = '$search/suggest';
  static const String suggestRecipe= '$recipe/suggest';
  static const String user = '/users';
  static const String topMember = '$user/top-members';

  static bool requireAuthentication(String url) {
    return ![
      googleLogin,
    ].contains(url);
  }
}
