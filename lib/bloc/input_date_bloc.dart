import 'package:rxdart/rxdart.dart';

class ListDataBloc {

  DateTime _dateTime;
  final _subject = BehaviorSubject<DateTime>();

  BehaviorSubject<DateTime> get subject => _subject.stream;

  getDateNow() async {
    _dateTime = DateTime.now();
    _subject.sink.add(_dateTime);
  }

  DateTime getDate() {
    return _dateTime;
  }

  changeDate(DateTime dateTime) async {
    _dateTime = dateTime;
    _subject.sink.add(dateTime);
  }

  dispose() {
    _subject.close();
  }
}

final bloc = ListDataBloc();