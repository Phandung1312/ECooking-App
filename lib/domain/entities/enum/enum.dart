enum LoginType{
  google,
  facebook,
  phone
}

enum RecipeSearchType{
  POPULAR,
  NEWEST,
  SEARCH
}
enum SearchType{
  all,
  recipe,
  account,
  instruction
}
enum RecipeStatus{
  draft,
  public,
  block,
}

enum ApiErrorType{
  refreshTokenExpired,
  accessTokenExpired,
  unknown
}