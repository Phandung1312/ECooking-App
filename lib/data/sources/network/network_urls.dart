class NetworkUrls {
  static const String users = '/users';
  static const String login = '$users/login';
  static const String logout = '$users/logout';
  static const String signUp = '$users/sign-up';
  static const String account = '$users/account';
  static const String getCategories = '/api/categories';
  static const String getCollections = '/api/collections';
  static const String getQuizzes = '/api/quizzes';
  static const String getQuizById = '/api/quizzes/{quiz_id}';
  static const String getTags = '/api/tags';

  static bool requireAuthentication(String url) {
    return ![
      login,
      signUp,
    ].contains(url);
  }
}
