import 'package:rxdart/rxdart.dart';
import 'package:set_of_recipes/model/list_data.dart';
import 'package:set_of_recipes/model/recipes_data.dart';
import 'package:set_of_recipes/repository/data_repository.dart';

class CartBloc {
  final _repository = DataRepository();
  final _subject = BehaviorSubject<List<RecipesData>>();

  BehaviorSubject<List<RecipesData>> get subject => _subject.stream;

  getRecipes(String ingredients) async {
    List<RecipesData> response = await _repository.getRecipes(ingredients);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }
}

final bloc = CartBloc();