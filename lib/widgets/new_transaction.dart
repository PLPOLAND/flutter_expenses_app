import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTranstaction extends StatefulWidget {
  final Function addTX;
  NewTranstaction(this.addTX, {Key key}) : super(key: key);

  @override
  State<NewTranstaction> createState() => _NewTranstactionState();
}

class _NewTranstactionState extends State<NewTranstaction> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();

  DateTime _selectedDate;

  void _presentDatePicer() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then((value) {
          if (value == null) {
            return;
          }
          setState(() {
            _selectedDate = value;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(hintText: "Title"),
            onSubmitted: (_) =>
                _submitData(), // "podłoga "sygnalzuje, że nie używam tego co dostaję w argumencie""
          ),
          TextField(
            controller: _valueController,
            decoration: const InputDecoration(hintText: "Value"),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) =>
                _submitData(), // "podłoga "sygnalzuje, że nie używam tego co dostaję w argumencie""
          ),
          Row(
            children: [
              Expanded(child: Text(_selectedDate == null ? "No Date Choosen": "Picked: ${DateFormat.yMMMMd().format(_selectedDate)}")),
              TextButton(
                  onPressed: () {
                    _presentDatePicer();
                  },
                  child: Text("Choose Date"))
            ],
          ),
          ElevatedButton(
              onPressed: _submitData, child: const Text("Add Transaction"))
        ],
      ),
    );
  }

  _submitData() {
    if(_valueController.text.isEmpty) {
      return;
    }
    final enterdTitle = _titleController.text;
    final val = double.parse(_valueController.text);

    if (enterdTitle.isEmpty || val <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTX(enterdTitle, val, _selectedDate);

    Navigator.of(context).pop();
  }
}
