import 'package:expense_tracker/widget/charts_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

class Charts extends StatelessWidget {
  final List<Transaction> recentTrans;
  const Charts(this.recentTrans);

  List<Map<String, Object>> get TransValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < recentTrans.length; i++) {
        if (recentTrans[i].date.day == weekDay.day &&
            recentTrans[i].date.month == weekDay.month &&
            recentTrans[i].date.year == weekDay.year) {
          totalSum += recentTrans[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get total {
    return TransValues.fold(0.0, (previousValue, element) {
      return previousValue + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: TransValues.map((values) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  values['day'].toString(),
                  (values['amount'] as double),
                  total == 0.0 ? 0.0 : (values['amount'] as double) / total),
            );
          }).toList(),
        ),
      ),
    );
  }
}
