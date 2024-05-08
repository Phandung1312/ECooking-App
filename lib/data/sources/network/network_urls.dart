class NetworkUrls {
  static const String auth = '/auth';
  static const String googleLogin = '$auth/login/google';
  static const String recipe = '/recipes';
  static const String user = '/users';
  static const String topMember = '$user/top-members';

  static bool requireAuthentication(String url) {
    return ![
      googleLogin,
    ].contains(url);
  }
}
