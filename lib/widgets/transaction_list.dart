import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function deleteTransaction;

  const TransactionList(this._userTransactions, this.deleteTransaction,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _userTransactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constrains) {
            return Column(
              children: [
                Text("No transtactions yet"),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: constrains.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                elevation: 2,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                          child: Text('\$ ${_userTransactions[index].amount}')),
                    ),
                  ),
                  title: Text(
                    _userTransactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                      DateFormat.yMMMd().format(_userTransactions[index].date)),
                  trailing: MediaQuery.of(context).size.width > 360
                      ? TextButton.icon(
                          onPressed: (() =>
                              deleteTransaction(_userTransactions[index].id)),
                          icon: const Icon(Icons.delete),
                          label: Text("Delete"))
                      : IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: (() =>
                              deleteTransaction(_userTransactions[index].id)),
                        ),
                ),
              );
            },
            itemCount: _userTransactions.length,
          );
  }
}
