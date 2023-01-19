import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expenses_app/widgets/chart.dart';

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
  final List<Transaction> _userTransactions = [];

  bool showChart = false;

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTX = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date);
    setState(() {
      _userTransactions.add(newTX);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
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

  List<Transaction> get _recentTransactions {
    return _userTransactions
        .where((element) => element.date
            .isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;

    var appBar2 = AppBar(
      title: const Text("Planer wydatków"),
      actions: [
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: const Icon(Icons.add))
      ],
    );

    var txListWidget = Container(
        child: TransactionList(_userTransactions, _deleteTransaction),
        height: (mediaQuery.size.height -
                appBar2.preferredSize.height -
                mediaQuery.padding.top) *
            0.7);

    return Scaffold(
      appBar: appBar2,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Show Chart"),
                  Switch.adaptive( //adaptive for IOS look on IOS
                      value: showChart,
                      onChanged: (val) {
                        setState(() {
                          showChart = val;
                        });
                      }),
                ],
              ),
            if (!isLandScape)
              Container(
                child: Chart(_recentTransactions),
                height: (mediaQuery.size.height -
                        appBar2.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
              ),
            if (!isLandScape) txListWidget,
            showChart && isLandScape
                ? Container(
                    child: Chart(_recentTransactions),
                    height: (mediaQuery.size.height -
                            appBar2.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.7,
                  )
                : txListWidget,
          ],
        ),
      ),
      floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
