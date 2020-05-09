class BaseUrl {
  static String apiBaseUrl = "https://lb7u7svcm5.execute-api.ap-southeast-1.amazonaws.com/dev/";
  static String ingredients = "ingredients";
  static String recipes = "recipes?ingredients=";

  static String assetPath = "assets/";
  static String assetImagePath = assetPath + "images/";
}

class AssetsImages {
  static String imgPlaceholder = BaseUrl.assetImagePath + "img_placeholder.jpg";
}