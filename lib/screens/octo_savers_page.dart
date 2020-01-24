import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octopush/bloc/user_bloc.dart';
import 'package:octopush/model/transaction.dart';
import 'package:octopush/repository/transaction_repository.dart';
import 'package:octopush/styles.dart';
import 'package:octopush/utils/currency_utils.dart';
import 'package:octopush/utils/date_utils.dart';
import 'package:octopush/widgets/primary_container.dart';
import 'package:octopush/widgets/section_label.dart';

class OctoSaversPage extends StatelessWidget {
  final transactionRepo = TransactionRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              _greetings(),
              SizedBox(height: 20.0),
              _balanceInfo(context),
              SizedBox(height: 20.0),
              SectionLabel(
                iconData: Icons.info,
                label: 'Product Info',
              ),
              _productInfo(),
              SizedBox(height: 20.0),
              SectionLabel(
                iconData: Icons.announcement,
                label: 'Key Points',
              ),
              _buildKeyPoints(),
              SizedBox(height: 20.0),
              SectionLabel(
                iconData: Icons.history,
                label: 'Last transactions',
              ),
              _buildTransactionWidget(),
              SizedBox(height: 20.0),
              InkWell(
                onTap: () => _addMockTransaction(context),
                child: SectionLabel(
                  iconData: Icons.add,
                  label: 'Add Mock Transaction',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _greetings() {
    return PrimaryContainer(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Hi!',
                style: subtitleStyleLight,
              ),
              Text(
                'Welcome to OctoSavers!',
                style: subtitleStyleLight,
              ),
            ],
          ),
          Icon(
            Icons.monetization_on,
            size: 50,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  Widget _balanceInfo(BuildContext context) {
    double balance = BlocProvider.of<UserBloc>(context).gameData.balance;

    return PrimaryContainer(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Your current balance:',
            style: subtitleStyleLight,
          ),
          Text(
            CurrencyUtils.formatToIdr(balance),
            style: titleStyleLight,
          ),
        ],
      ),
    );
  }

  Widget _productInfo() {
    return Card(
      elevation: 1.0,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: double.infinity,
        height: 100.0,
        child: Text(
          'Octo Savers is...',
          style: captionStyle,
        ),
      ),
    );
  }

  Widget _buildKeyPoints() {
    return Card(
      elevation: 1.0,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: double.infinity,
        height: 100.0,
        child: Text(
          'FYI:',
          style: captionStyle,
        ),
      ),
    );
  }

  Widget _buildTransactionWidget() {
    return Card(
      elevation: 1.0,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: transactionRepo.getAllTranscation(),
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              return Text('Error has occurred: ${snapshot.error}');
            } else if (snapshot.hasData) {
              List<Transaction> transactionList = snapshot.data;

              return transactionList.isNotEmpty
                  ? _buildTransactionList(transactionList)
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 70.0),
                      child: Text(
                        'Oops! Currently, You have no historical transaction.',
                        style: captionStyle,
                        textAlign: TextAlign.center,
                      ),
                    );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 70.0),
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTransactionList(List<Transaction> transactionList) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: transactionList.length,
      separatorBuilder: (_, index) => Divider(
        color: Colors.redAccent,
      ),
      itemBuilder: (_, index) {
        var transaction = transactionList[index];
        return ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text(transaction.title),
          subtitle: Text(
              'Interval ${transaction.interval + 1} - ${DateUtils.formatDateDDMMYY(transaction.dateCreated)}'),
          trailing: Text(CurrencyUtils.formatToIdr(transaction.amount)),
        );
      },
    );
  }

  void _addMockTransaction(BuildContext context) {
    int interval =
        BlocProvider.of<UserBloc>(context).gameData.currentInterval.index;
    Transaction t =
        Transaction(null, DateTime.now(), interval, 'Mock Transaction', 100000);
    transactionRepo.addTranscation(t);
  }
}
