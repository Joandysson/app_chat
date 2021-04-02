import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nome',
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Senha',
                    ),
                  ),
                  SizedBox(height: 12),
                  RaisedButton(
                    onPressed: () {},
                    child: Text('Entrar'),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {},
                    child: Text('Criar uma conta?'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
