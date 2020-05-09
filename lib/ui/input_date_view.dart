import 'dart:math';

import 'package:flutter/material.dart';
import 'package:set_of_recipes/bloc/input_date_bloc.dart';

import 'list_data_view.dart';

class InputDateView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InputDateViewState();
  }
}

class _InputDateViewState extends State<InputDateView> {

  @override
  void initState() {
    super.initState();
    bloc.getDateNow();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: bloc.getDate(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101)
    );

    if (picked != null && picked != bloc.getDate())
      bloc.changeDate(picked);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi,",
                style: TextStyle(
                  fontSize: 50
                ),
              ),
              Text(
                "Are you ready for lunch?",
                style: TextStyle(
                  fontSize: 30
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: StreamBuilder<DateTime>(
                  stream: bloc.subject,
                  builder: (context, AsyncSnapshot<DateTime> snapshot) {
                    return Text(
                      "${snapshot.data.toString()}".split(' ')[0],
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                onPressed: () => _selectDate(context),
                child: Text('Select date'),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 25
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ListDataView(dateTime: bloc.getDate())),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}