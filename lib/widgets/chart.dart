import 'package:flutter/material.dart';
import '../models/Trasaction.dart';
import 'package:intl/intl.dart';
import '../widgets/Bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recenttransactions;

  Chart(this.recenttransactions);

  List<Map<String, Object>> get groupeTransactionValues {
    return List.generate(7, (index) {
      final dayweek = DateTime.now().subtract(Duration(days: index));
      var totalsum = 0.0;
      for (int i = 0; i < recenttransactions.length; i++) {
        if (recenttransactions[i].date.day == dayweek.day &&
            recenttransactions[i].date.month == dayweek.month &&
            recenttransactions[i].date.year == dayweek.year) {
          totalsum += recenttransactions[i].amount;
        }
      }

      return {'day': DateFormat.E().format(dayweek), 'amount': totalsum};
    }).reversed.toList();
  }

  double get totalspendingsweek {
    return groupeTransactionValues.fold(0.0, (sum, item) {
      return sum += item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupeTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      
      child: Padding(padding: EdgeInsets.all(10),
        child: Row(
          children: groupeTransactionValues.map((item) {
            return Flexible(fit: FlexFit.tight,
              child: Bars(
                  item['day'],
                  item['amount'],
                  totalspendingsweek == 0.0
                      ? 0.0
                      : (item['amount'] as double) / totalspendingsweek),
            );
          }).toList(),
        ),
      ),
    );
  }
}
