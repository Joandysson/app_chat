import 'package:app_chat/widgets/messages.dart';
import 'package:app_chat/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  void initState() {
    super.initState();

    final fbm = FirebaseMessaging();
    fbm.configure(
      onMessage: (msg) {
        print('onMessage...');
        print(msg);
        return;
      },
      onResume: (msg) {
        print('onResume...');
        print(msg);
        return;
      },
      onLaunch: (msg) {
        print('onResume...');
        print(msg);
        return;
      },
    );
    fbm.subscribeToTopic('chat');
    fbm.requestNotificationPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: <Widget>[
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.exit_to_app),
                        SizedBox(width: 8),
                        Text('Sair'),
                      ],
                    ),
                  ),
                )
              ],
              onChanged: (item) {
                if (item == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(child: Messages()),
              NewMessage(),
            ],
          ),
        ),
      ),
    );
  }
}
