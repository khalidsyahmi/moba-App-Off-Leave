import 'package:flutter/material.dart';
import 'package:offleaveppkt/services/superviser_auth.dart';
import 'package:offleaveppkt/shared/deConstants.dart';
import 'package:offleaveppkt/shared/loading.dart';

 class SVRegister extends StatefulWidget {

   final Function toggleViewsv;
   SVRegister({ this.toggleViewsv });

   @override
   SVRegisterState createState() => SVRegisterState();
 }
 
 class SVRegisterState extends State<SVRegister> {
 
  final AuthService2 _authsv = AuthService2(); // for sv

  final _formKey = GlobalKey<FormState>(); // identify our form
  bool loading = false; 

  // text field state
  String name = '';
  String email = '';
  String password = '';
  String error = ''; //hell yah errors

   @override
   Widget build(BuildContext context) {
         return SafeArea(
                    child: loading ? Loading() :  Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign up to PPKT app'),
           actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Register as User'),  // toggle signin page
              onPressed: () {
                Navigator.pop(context);
              }
            )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
            key: _formKey, // validation technique
            child: Column(
              children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: 'Nama'),
                validator: (val) => val.isEmpty
                    ? 'Masukkan nama'
                    : null, //validator
                onChanged: (val) {
                  setState(() => name = val); // tracking
                },
              ),
                SizedBox(height: 20.0),
                TextFormField( 
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null, //validator
                  onChanged: (val) {
                    setState(() => email = val);  // tracking
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'), // textbox deco
                  obscureText: true, //to obscure password
                  validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async{
                      if (_formKey.currentState.validate()){
                        setState(() => loading = true);       // set loading
                        dynamic result2 = await _authsv.registerWithEmailAndPassword(name, email, password);
                         if (result2 == null){
                          setState(() => error = 'please supply a valid email and password for sv');
                          loading = false;
                        }
                      }
                    },
                ),
                SizedBox(height: 12.0,),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
        )
      ) 
     ),
         );

   }
 }