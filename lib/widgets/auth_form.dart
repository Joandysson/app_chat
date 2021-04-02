import 'package:app_chat/models/auth_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthData authData) onSubmit;

  AuthForm(this.onSubmit);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthData _authData = AuthData();

  _submit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      widget.onSubmit(_authData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (_authData.isSignup)
                    TextFormField(
                      key: ValueKey('name'),
                      decoration: InputDecoration(
                        labelText: 'Nome',
                      ),
                      initialValue: _authData.name,
                      onChanged: (value) => _authData.name = value,
                      validator: (value) {
                        if (value == null || value.trim().length < 4) {
                          return 'Nome deve ter no minimo 4 caracteres';
                        }
                        return null;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('email'),
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                    ),
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'Forneça um e-mail válido';
                      }
                      return null;
                    },
                    onChanged: (value) => _authData.email = value,
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    decoration: InputDecoration(
                      labelText: 'Senha',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().length < 7) {
                        return 'Senha deve ter no minimo 7 caracteres';
                      }
                      return null;
                    },
                    onChanged: (value) => _authData.password = value,
                  ),
                  SizedBox(height: 12),
                  RaisedButton(
                    child: Text(_authData.isLogin ? 'Entrar' : 'Cadastrar'),
                    onPressed: _submit,
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      _authData.isLogin
                          ? 'Criar uma conta?'
                          : 'Já possui uma conta?',
                    ),
                    onPressed: () {
                      setState(() {
                        _authData.toggleMode();
                      });
                    },
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
