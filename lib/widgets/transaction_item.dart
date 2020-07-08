import 'package:flutter/material.dart';
import '../models/Trasaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required Transaction transactions,
    @required this.remove,
  })  : _transactions = transactions,
        super(key: key);

  final Transaction _transactions;
  final Function remove;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: FittedBox(
                  child: Text('\$ ${_transactions.amount.toString()}'))),
        ),
        title: Text(
          _transactions.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(DateFormat.yMMMd().format(_transactions.date)),
        trailing: MediaQuery.of(context).size.width > 400
            ? FlatButton.icon(
                onPressed: () {
                  remove(_transactions.id);
                },
                label: Text('delete'),
                icon: Icon(Icons.delete),
                textColor: Colors.red,
              )
            : IconButton(
                onPressed: () {
                  remove(_transactions.id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
      ),
    );
  }
}
