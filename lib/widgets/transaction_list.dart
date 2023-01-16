import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;

  const TransactionList(this._userTransactions, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: Row(children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.green,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Text(
                    "\$ ${_userTransactions[index].amount}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.green),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _userTransactions[index].title,
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      DateFormat.yMMMd().format(_userTransactions[index].date),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                )
              ]),
            );
          },
          itemCount: _userTransactions.length,
        ));
  }
}
