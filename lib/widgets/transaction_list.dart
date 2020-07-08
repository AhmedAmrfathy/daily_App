import 'package:flutter/material.dart';
import '../models/Trasaction.dart';
import '../widgets/transaction_item.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function remove;

  TransactionList(this._transactions, this.remove);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraint) {
              return Column(
                children: <Widget>[
                  Text(
                    "no transaction yet",
                    style: Theme.of(context).textTheme.title,
                  ),
                  Container(
                    height: constraint.maxHeight * .6,
                    child: Image.asset(
                      'assets/images/ll.jpg',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return TransactionItem(key:ValueKey(index),transactions: _transactions[index], remove: remove);
//                return Card(
//                  child: Row(
//                    children: <Widget>[
//                      Container(
//                        child: Text(
//                            '\$ ${_transactions[index].amount.toString()}',
//                            style: TextStyle(
//                                color: Colors.purple,
//                                fontWeight: FontWeight.bold,
//                                fontSize: 20)),
//                        margin:
//                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                        padding: EdgeInsets.all(10),
//                        decoration: BoxDecoration(
//                            border: Border.all(color: Colors.purple, width: 2)),
//                      ),
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Text(_transactions[index].title,
//                              style: Theme.of(context).textTheme.title),
//                          Text(
//                            DateFormat.yMMMd()
//                                .format(_transactions[index].date),
//                            style: TextStyle(fontSize: 10, color: Colors.grey),
//                          )
//                        ],
//                      )
//                    ],
//                  ),
//                );
              },
              itemCount: _transactions.length,
            ),
    );
  }
}


