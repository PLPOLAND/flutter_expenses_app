import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';
import 'package:intl/intl.dart';

import 'models/transaction.dart';

void main() {
  runApp(const MyAPP());
}

class MyAPP extends StatelessWidget {
  const MyAPP({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          fontFamily: "QuickSand",
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          ),
      title: 'Personal Expenses',
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: "t1", title: "New Shoes", amount: 69.99, date: DateTime.now()),
    Transaction(
        id: "t2", title: "New Phone", amount: 169.99, date: DateTime.now()),
    Transaction(
        id: "t3", title: "New Shoes", amount: 69.99, date: DateTime.now()),
    Transaction(
        id: "t6", title: "New Phone", amount: 169.99, date: DateTime.now()),
    Transaction(
        id: "t4", title: "New Shoes", amount: 69.99, date: DateTime.now()),
    Transaction(
        id: "t5", title: "New Phone", amount: 169.99, date: DateTime.now()),
    Transaction(
        id: "t8", title: "New Shoes", amount: 69.99, date: DateTime.now()),
    Transaction(
        id: "t7", title: "New Phone", amount: 169.99, date: DateTime.now()),
  ];

  void _addNewTransaction(String title, double amount) {
    final newTX = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now());
    setState(() {
      _userTransactions.add(newTX);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTranstaction(_addNewTransaction),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Planer wydatków"),
        actions: [
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Card(
              child: Text("Chart"),
            ),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
