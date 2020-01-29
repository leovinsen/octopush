import 'package:flutter/material.dart';
import 'package:octopush/model/challenge.dart';
import 'package:octopush/styles.dart';
import 'package:octopush/widgets/safe_scaffold.dart';

class NotificationListPage extends StatelessWidget {
  final List<Challenge> challenges;

  const NotificationListPage({Key key, this.challenges})
      : assert(challenges != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Theme.of(context).accentColor,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Challenges',
                  style: titleStyleLight,
                ),
                SizedBox(
                  height: 10.0,
                ),
                challenges.isNotEmpty
                    ? ListView.builder(
                        reverse: true,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: challenges.length,
                        itemBuilder: (_, index) {
                          var challenge = challenges[index];
                          return Card(
                            child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 5.0),
                                title: Text(challenge.title),
                                subtitle: Text(
                                  challenge.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: challenge.done
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.lightGreen,
                                      )
                                    : Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                      )),
                          );
                        },
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 70.0),
                        child: Text(
                          'No challenges yet',
                          style: largeTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
