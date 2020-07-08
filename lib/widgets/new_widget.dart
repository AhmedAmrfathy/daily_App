import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewWidget extends StatefulWidget {
  final Function fn;

  NewWidget(this.fn);

  @override
  _NewWidgetState createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  DateTime date;
  void submitDate(BuildContext context) {
    if (titel.text.isEmpty || double.parse(amount.text) <= 0||date==null) {
      return;
    }
    widget.fn(titel.text, double.parse(amount.text),date);
   Navigator.of(context)
       .pop(); // 3lshan lma a5ls ktaba f keybord w ados tm ykfl el key bord , w ynfz amr elsubmit men 4er ma ad3d ala elzorar
  }

  void _selectdate() {
    showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()).then((pickeddate){
          if(pickeddate==null){
            return null;
          }
          setState(() {
            date=pickeddate;
          });
    });
  }

  final titel = TextEditingController();

  final amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
            padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: MediaQuery.of(context).viewInsets.bottom),//alshan lma aft7 elkeyboard mttl3sh fok el containner
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    // this is first way to access an input text from test field
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: titel,
                    onSubmitted: (_) {
                      submitDate(context);
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    // this is second  way to access an input text from test field
                    controller: amount,
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) {
                      submitDate(context);
                    },
                  ),
                  Container(
                    height: 70,
                    child: Row(
                      children: <Widget>[
                        Text(date==null?'no date chosen':"picked date: ${DateFormat.yMMMd().format(date)}"),
                        FlatButton(
                          child: Text(
                            'choose date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed:_selectdate ,
                          textColor: Theme
                              .of(context)
                              .primaryColor,
                        )
                      ],
                    ),
                  ),
                  RaisedButton(
                    child: Text('Add Transaction'),
                    color: Theme
                        .of(context)
                        .textTheme
                        .button
                        .color,
                    onPressed: () {
                      submitDate(context);
                    },
                    textColor: Theme
                        .of(context)
                        .primaryColor,
                  )
                ],
              ),
            )),
      ),
    );
  }
}
