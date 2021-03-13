import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 0,
        itemBuilder: (ctx, i) => Container(
          padding: EdgeInsets.all(10),
          child: Text('Funcionou!'),
        ),
      ),
    );
  }
}
