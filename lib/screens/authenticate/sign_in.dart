//import 'package:offleaveppkt/screens/authenticate/auth.dart';
import 'package:flutter/material.dart';
import 'package:offleaveppkt/services/authenticate.dart';
import 'package:offleaveppkt/shared/deConstants.dart';
import 'package:offleaveppkt/shared/loading.dart'; //Loading stuff

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); // identify our form
  bool loading = false; // set to true

  //field state values
  String email = '';
  String password = '';
  String error = ''; //hell yah errors

  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : SafeArea(
          child: Scaffold(
              //Loading widget first
              backgroundColor: Colors.brown[100],
              appBar: AppBar(
                backgroundColor: Colors.brown[400],
                elevation: 0.0,
                title: Text('Log Masuk'),
                actions: <Widget>[
                  FlatButton.icon(
                      icon: Icon(Icons.person),
                      label: Text('Daftar Pengguna'), // toggle signup page
                      onPressed: () {
                        widget.toggleView();
                      })
                ],
              ),
              body: SingleChildScrollView( // scroll enabler
                child: Container(
                    height: MediaQuery.of(context).size.height, //
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,  
                        children: <Widget>[
                          // block comment this if the build needs flutter clean everytime
                          Material(
                            child: Image.asset('assets/logo_usm.png',
                            width: 3000, height: 150),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              ' Sistem Aplikasi Borang Kebenaran Keluar PPKT ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 26.0 ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Email'),
                            validator: (val) =>
                                val.isEmpty ? 'Masukkan email' : null, //validator
                            onChanged: (val) {
                              setState(() => email = val); // tracking
                            },
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Kata Laluan'),
                            obscureText: true, //to obscure password
                            validator: (val) => val.length < 6
                                ? 'Masukkan password panjang 6 atau lebih huruf'
                                : null,
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                          ),
                          SizedBox(height: 20.0),
                          RaisedButton(
                            color: Colors.pink[400],
                            child: Text(
                              'Log Masuk',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true); // set loading
                                dynamic result = await _auth
                                    .signInWithEmailAndPassword(email, password);
                                if (result == null) {
                                  setState(() => error =
                                      'Tidak boleh Log masuk. Credential salah');
                                  loading = false; //setback
                                }
                              }
                            },
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          )
                        ],
                      ),
                    )),
              ),
            ),
        );
  }
}
