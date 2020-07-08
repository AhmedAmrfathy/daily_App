import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app2/widgets/new_widget.dart';
import './models/Trasaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter App",
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'OpenSans',
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light()
                  .textTheme
                  .copyWith(title: TextStyle(fontFamily: 'OpenSans')))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool x = false;

  List<Transaction> get recenttransactions {
    return _transactions.where((elemnt) {
      return elemnt.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  final List<Transaction> _transactions = [
    Transaction(
      id: "1",
      title: "shoes",
      amount: 3,
      date: DateTime.now(),
    ),
    Transaction(id: "1", title: "shirt", amount: 2, date: DateTime.now())
  ];

  void add_transaction(String title, double amount, DateTime dateTime) {
    setState(() {
      final newob = new Transaction(
          id: DateTime.now().toString(),
          title: title,
          amount: amount,
          date: dateTime);
      _transactions.add(newob);
    });
  }

  void removetransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  void addNewTransaction(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return GestureDetector(
              child: NewWidget(add_transaction),
              onTap: () {},
              behavior: HitTestBehavior.opaque);
        });
  }
  List<Widget>portraitMode(MediaQueryData mediaQuery,AppBar appar,Widget fixedlistinallmode){
    return [Container(
        height: (mediaQuery.size.height -
            appar.preferredSize.height -
            MediaQuery.of(context).padding.top) *
            .3,
        child: Chart(recenttransactions)),
      fixedlistinallmode

    ];

  }
  List<Widget>landScapeMode(MediaQueryData mediaQuery,AppBar appar,Widget fixedlistinallmode){
    return [
      x == true
          ? Container(
          height: (mediaQuery.size.height -
              appar.preferredSize.height -
              mediaQuery.padding.top) *
              .7,
          child: Chart(recenttransactions))
          : fixedlistinallmode

    ];

  }




  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final landscap = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appar =  Platform.isIOS
        ? CupertinoNavigationBar(
      middle: Text('Flutter App'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => addNewTransaction(context),
          )
        ],
      ),
    )
        : AppBar(
      title: Text("Flutter App"),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              addNewTransaction(context);
            })
      ],
    );
    final fixedlistinallmode = Container(
        height: (mediaQuery.size.height -
            appar.preferredSize.height -
            mediaQuery.padding.top) *
            .7,
        child: TransactionList(_transactions, removetransaction));
    final pagebody = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (landscap)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Switch(
                  value: x,
                  onChanged: (z) {
                    setState(() {
                      x = z;
                    });
                  },
                )
              ],
            ),
          if (!landscap)
           ... portraitMode(mediaQuery, appar, fixedlistinallmode),



          if (landscap)
            ... landScapeMode(mediaQuery, appar, fixedlistinallmode)

        ],
      ),
    );


    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pagebody,
            navigationBar: appar,
          )
        : Scaffold(
            appBar: appar,
            body: SafeArea(
                // da 3lshan fe ios momkn ybaa fe mkan fok f design el mobile f ana abda men ba3do
                child: pagebody),
            floatingActionButtonLocation: Platform.isIOS
                ? Container()
                : FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  addNewTransaction(context);
                }),
          );
  }
}
