import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:set_of_recipes/bloc/cart_bloc.dart';
import 'package:set_of_recipes/model/recipes_data.dart';

class CartView extends StatefulWidget {

  final List<String> list;

  const CartView({
    Key key,
    this.list,

  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CartViewState();
  }
}

class _CartViewState extends State<CartView> {

  @override
  void initState() {
    bloc.getRecipes(widget.list.reduce((value, element) => value + ',' + element));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Cart",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: StreamBuilder<List<RecipesData>>(
        stream: bloc.subject,
        builder: (context, AsyncSnapshot<List<RecipesData>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length == 0) {
              return _buildErrorWidget("Error load data");
            }
            return _buildUserWidget(snapshot.data);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else {
            return _buildLoadingWidget();
          }
        },
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Container(
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Error occured: $error", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Loading data from API...",
              style: Theme.of(context).textTheme.subtitle
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),)
        ],
      ),
    );
  }

  Widget _buildUserWidget(List<RecipesData> data) {
    return ListView(
      children: [
        ListView.separated(
          separatorBuilder: (context, index) => Container(
            height: 0.2,
            color: Colors.black26,
          ),
          padding: EdgeInsets.only(
            bottom: 7,
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.list.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.list[index],
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Container(
          color: Colors.blue.withOpacity(0.5),
          padding: const EdgeInsets.all(13.0),
          child: Text(
            "Available Recipes",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        ListView.separated(
          separatorBuilder: (context, index) => Container(
            height: 0.2,
            color: Colors.black26,
          ),
          padding: EdgeInsets.only(
            bottom: 7,
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return Material(
              color: Colors.transparent,
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  backgroundColor: Colors.transparent,
                  title: Text(
                    data[index].title,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  children: <Widget>[
                    ListView.builder(
                      padding: EdgeInsets.only(
                        bottom: 7,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data[index].ingredients.length,
                      itemBuilder: (BuildContext context, int index2) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                margin: EdgeInsets.only(right: 15),
                                alignment: Alignment.topCenter,
                                decoration: new BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Text(
                                data[index].ingredients[index2],
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
