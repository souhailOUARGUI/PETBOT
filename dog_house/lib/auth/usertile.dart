import 'package:flutter/material.dart';
import 'user.dart';

class UserTile extends StatelessWidget {
  final Userr user;
  UserTile({required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.brown,
            ),
            title: Text(user.name),
            subtitle: Text('has  ${user.petNum} pets'),
          )),
    );
  }
}
