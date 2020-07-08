import 'package:flutter/material.dart';

class Bars extends StatelessWidget {
  final String label;
  final double spendingamount;
  final double percentage;

  Bars(this.label, this.spendingamount, this.percentage);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constrains) {
        return Column(
          children: <Widget>[
            Container(
                height: constrains.maxHeight * .15,
                child: FittedBox(
                    child: Text('\$${spendingamount.toStringAsFixed(0)}'))),
            Column(
              children: <Widget>[
                SizedBox(
                  height: constrains.maxHeight * .05,
                ),
                Container(
                  height: constrains.maxHeight * .6,
                  width: 10,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(220, 220, 220, 1),
                        ),
                      ),
                      FractionallySizedBox(
                        heightFactor: percentage,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: constrains.maxHeight * .05,
                ),
                Container(
                    height: constrains.maxHeight * .15,
                    child: FittedBox(fit: BoxFit.cover, child: Text(label)))
              ],
            )
          ],
        );
      },
    );
  }
}
