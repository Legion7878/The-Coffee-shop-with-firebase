import 'package:flutter/material.dart';
import 'package:mycoffeeshop/services/auth.dart';

import '../../shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //  Text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/image3.jpg'), fit: BoxFit.cover)),
    child: loading? Loading() : Scaffold(
    backgroundColor: Colors.transparent,
      appBar: AppBar(
    backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text('Sign up to Coffee shop'),

        actions: [
          FlatButton.icon(
            icon: Icon(Icons.person),
            color: Colors.white70,
            label: Text('Sign in'),
            onPressed: (){
              widget.toggleView();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 60.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                ),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val){
                  setState(() => email = val);

                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Password',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                ),
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'Enter a password longer than 6 chars sexy!' : null,
                onChanged: (val){
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.orange,
                child: Text(
                  'Sign up',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  setState(() => loading = true);
                  if (_formKey.currentState!.validate()){
                  dynamic result = await _auth.registerWithEmailAndPassword(email,password);
                  if (result==null){
                    setState(() {
                      error = 'Could not sign in';
                      loading = false;
                    });
                  }
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
