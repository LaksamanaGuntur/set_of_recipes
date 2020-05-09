import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:set_of_recipes/model/cart_data.dart';
import 'package:set_of_recipes/utils/util.dart';
import '../bloc/list_data_bloc.dart';
import '../model/list_data.dart';
import 'cart_view.dart';

class ListDataView extends StatefulWidget {

  final DateTime dateTime;

  const ListDataView({
    Key key,
    this.dateTime,

  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ListDataViewState();
  }
}

class _ListDataViewState extends State<ListDataView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> _cartList = [];

  @override
  void initState() {
    super.initState();
    bloc.getIngredients();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Ingredients",
          style: TextStyle(
            color: Colors.black
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              if (_cartList.length > 0)
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartView(list: _cartList)),
                );
              else
                showSnackBar("Plase select min 1 item");
            },
          ),
        ],
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: StreamBuilder<List<ListData>>(
            stream: bloc.subject,
            builder: (context, AsyncSnapshot<List<ListData>> snapshot) {
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

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Error occured: $error", style: Theme.of(context).textTheme.subtitle),
        ],
      ),
    );
  }

  Widget _buildUserWidget(List<ListData> data) {
    return ListView.separated(
      separatorBuilder: (context, index) => Container(
        height: 0.2,
        color: Colors.black26,
      ),
      padding: EdgeInsets.only(
        bottom: 7,
      ),
      physics: BouncingScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        DateTime strToDate = Util.convertDateFromString(data[index].useBy);

        return Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data[index].title,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              FlatButton(
                onPressed: strToDate.isBefore(widget.dateTime) ? null : data[index].isAdd ? null : () {
                  setState(() {
                    data[index].isAdd = true;
                  });
                  _cartList.add(data[index].title);
                },
                splashColor: Theme.of(context).primaryColor,
                child: strToDate.isBefore(widget.dateTime) ? Icon(
                  Icons.close,
                  color: Colors.red,
                  semanticLabel: 'CANNOT ADDED',
                ) :
                data[index].isAdd ? Icon(
                  Icons.check,
                  color: Colors.green,
                  semanticLabel: 'ADDED',
                ) : Text('ADD'),
              ),
            ],
          ),
        );
      },
    );
  }

  void showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(
      new SnackBar(content: Text(message)),
    );
  }
}
