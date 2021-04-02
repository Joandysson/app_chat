import 'package:app_chat/models/auth_data.dart';
import 'package:app_chat/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isLoading = false;

  Future _handleSubmit(AuthData authData) async {
    setState(() {
      _isLoading = true;
    });

    AuthResult authResult;

    try {
      if (authData.isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: authData.email.trim(),
          password: authData.password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: authData.email.trim(),
          password: authData.password,
        );

        final userData = {
          'name': authData.name,
          'email': authData.email,
        };

        await Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData(userData);
      }
    } on PlatformException catch (err) {
      final msg = err.message ?? 'Ocorreu um erro!';
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } catch (err) {
      print(err);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      // body: AuthForm(_handleSubmit),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                AuthForm(_handleSubmit),
                if (_isLoading)
                  Positioned.fill(
                      child: Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
