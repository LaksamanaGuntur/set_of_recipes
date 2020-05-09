class RecipesData {
  final String title;
  final List<dynamic> ingredients;

  RecipesData(this.title, this.ingredients);

  RecipesData.fromJson(Map<String, dynamic> json) :
        title = json["title"],
        ingredients = (json["ingredients"] as List);

  RecipesData.withError(String errorValue) :
        title = "",
        ingredients = List();
}
