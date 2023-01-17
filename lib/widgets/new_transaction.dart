import 'package:flutter/material.dart';

class NewTranstaction extends StatefulWidget {
  final Function addTX;
  NewTranstaction(this.addTX, {Key key}) : super(key: key);

  @override
  State<NewTranstaction> createState() => _NewTranstactionState();
}

class _NewTranstactionState extends State<NewTranstaction> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          controller: titleController,
          decoration: const InputDecoration(hintText: "Title"),
          onSubmitted: (_) => submitData(), // "podłoga "sygnalzuje, że nie używam tego co dostaję w argumencie""
        ),
        TextField(
          controller: valueController,
          decoration: const InputDecoration(hintText: "Value"),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          onSubmitted: (_) => submitData(), // "podłoga "sygnalzuje, że nie używam tego co dostaję w argumencie""
        ),
        TextButton(
            onPressed: submitData,
            child: const Text("Add Transaction"))
      ],
    );
  }

  submitData() {
    final enterdTitle = titleController.text;
    final val = double.parse(valueController.text);

    if (enterdTitle.isEmpty || val <= 0) {
      return;
    }

    widget.addTX(enterdTitle, val);
    
    Navigator.of(context).pop();

  }
}
