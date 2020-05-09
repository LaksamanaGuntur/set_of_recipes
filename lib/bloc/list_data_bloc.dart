import 'package:rxdart/rxdart.dart';
import 'package:set_of_recipes/model/list_data.dart';
import 'package:set_of_recipes/repository/data_repository.dart';

class ListDataBloc {
  final _repository = DataRepository();
  final _subject = BehaviorSubject<List<ListData>>();

  BehaviorSubject<List<ListData>> get subject => _subject.stream;

  getIngredients() async {
    List<ListData> response = await _repository.getIngredients();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }
}

final bloc = ListDataBloc();