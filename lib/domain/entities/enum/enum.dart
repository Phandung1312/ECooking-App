enum LoginType{
  google,
  facebook,
  phone
}
enum ImagePickType{
  recipe,
  instruction
}
enum NotificationType{
  like,
  commentRecipe,
  responseComment,
  recipe,
  save,
  follow
}
enum RecipeSearchType{
  POPULAR,
  NEWEST,
  SEARCH,
  PROFILE,
  SAVED,
  MY_RECIPE,
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

enum FeatureStatus{
  enable,
  disable
}

enum FollowType{
  following,
  follower
}

enum ReportContent{
  one("Nội dung không phù hợp"),
  two("Hình ảnh không lành mạnh"),
  three("Vi phạm bản quyền"),
  four("Lừa đảo"),
  five("Khác");
  final String content;
   const ReportContent(this.content);
}