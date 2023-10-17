import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../color.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  const NewTransaction(this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleInput = TextEditingController();
  final amountInput = TextEditingController();
  DateTime? date;

  void addTrans() {
    if (amountInput.text.isEmpty) {
      return;
    }
    final enteredTitle = titleInput.text;
    final enteredAmount = double.parse(amountInput.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || date == null) {
      return;
    }
    widget.addTransaction(
      enteredTitle,
      enteredAmount,
      date,
    );
    Navigator.of(context).pop();
  }

  void datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          date = pickedDate;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              onSubmitted: (_) => addTrans(),
              controller: titleInput,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => addTrans(),
              controller: amountInput,
            ),
            Container(
              height: 100,
              child: Row(
                children: [
                  Text(
                    date != null
                        ? 'Picked Date: ${DateFormat.MMMMd("en_US").format(date!)}'
                        : 'Date not selected',
                  ),
                  TextButton(
                    onPressed: datePicker,
                    child: Text(
                      'Chosse date',
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                addTrans();
              },
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              child: Text(
                'ADD TRANSACTION',
                style: TextStyle(
                  color: tdBGColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
