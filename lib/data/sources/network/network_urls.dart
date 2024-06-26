class NetworkUrls {
  static const String auth = '/auth';
  static const String refresh = '$auth/refresh';
  static const String login = 'login';
  static const String googleLogin = '$auth/$login/google';
  static const String recipe = '/recipes';
  static const String recipeFavorite = '$recipe/favorites';
  static const String savedRecipe = '$recipe/saved-recipes';
  static const String search = '/search';
  static const String comment = '/comments';
  static const String suggestSearch = '$search/suggest';
  static const String suggestRecipe= '$recipe/suggest';
  static const String user = '/users';
  static const String report = '/reports';
  static const String topMember = '$user/top-members';
  static const String upload = '/upload';
  static const String uploadImage = '$upload/image';
  static const String uploadVideo = '$upload/video';
  static const String notification = '/notifications';

  static bool requireAuthentication(String url) {
    return ![
      googleLogin,
    ].contains(url);
  }
}
