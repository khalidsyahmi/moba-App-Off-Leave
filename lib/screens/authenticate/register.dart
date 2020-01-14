import 'package:flutter/material.dart';
// import 'package:offleaveppkt/screens/authenticate/sv_register.dart';
import 'package:offleaveppkt/services/authenticate.dart';
import 'package:offleaveppkt/shared/deConstants.dart';
import 'package:offleaveppkt/shared/loading.dart';

 class Register extends StatefulWidget {

   final Function toggleView;
   Register({ this.toggleView });

   @override
   _RegisterState createState() => _RegisterState();
 }
 
 class _RegisterState extends State<Register> {
 
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); // identify our form
  bool loading = false; 

  // text field state
  String name = '';
  String email = '';
  String password = '';
  String error = ''; //hell yah errors

   @override
   Widget build(BuildContext context) {
         return loading ? Loading() :  SafeArea(
      child: Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Daftar dalam Aplikasi PPKT'),
           actions: <Widget>[

        // admin login did not work   
        //   FlatButton.icon( 
        //   icon: Icon(Icons.person),
        //   label: Text('Sign Up SV'),  // toggle signin page
        //   onPressed: () {
        //     Navigator.push(context, new MaterialPageRoute(
        //       builder: (context)=> SVRegister()
        //     ));
        //   }
        // ),
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Log Masuk'),  // toggle signin page
              onPressed: () {
                widget.toggleView();
              }
            )
        ],
      ),
     
      body: SingleChildScrollView(
          child: Container(
          height: MediaQuery.of(context).size.height, //
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
              key: _formKey, // validation technique
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                  padding: const EdgeInsets.all(15.0),
                    child: Text(
                      ' Sila Masukkan maklumat pendaftaran ',
                      style:
                          TextStyle(color: Colors.white, fontSize: 25.0 ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField( 
                    decoration: textInputDecoration.copyWith(hintText: 'Nama'),
                    validator: (val) => val.isEmpty ? 'Masukkan nama' : null, 
                    onChanged: (val) {
                      setState(() => name = val);  // tracking
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField( 
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val.isEmpty ? 'Masukkan email' : null, //validator
                    onChanged: (val) {
                      setState(() => email = val);  // tracking
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Kata Laluan'), // textbox deco
                    obscureText: true, //to obscure password
                    validator: (val) => val.length < 6 ? 'Masukkan Kata Laluan panjang 6 atau lebih huruf' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Daftar',
                      style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async{
                        if (_formKey.currentState.validate()){
                          setState(() => loading = true);       // set loading
                          dynamic result = await _auth.registerWithEmailAndPassword(name, email, password);
                          if (result == null){
                            setState(() => error = 'Sila Masukkan email yang sah');
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
        ),
      ) 
     ),
         );

   }
 }