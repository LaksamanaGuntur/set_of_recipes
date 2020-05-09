import 'package:set_of_recipes/model/list_data.dart';
import 'package:set_of_recipes/model/recipes_data.dart';

import '../network/data_api_provider.dart';

class DataRepository{
  DataApiProvider _dataApiProvider = DataApiProvider();

  Future<List<ListData>> getIngredients(){
    return _dataApiProvider.getIngredients();
  }

  Future<List<RecipesData>> getRecipes(String ingredients){
    return _dataApiProvider.getRecipes(ingredients);
  }
}