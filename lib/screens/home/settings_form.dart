import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mycoffeeshop/models/user.dart';
import 'package:mycoffeeshop/services/database.dart';
import 'package:provider/provider.dart';
import '../../shared/loading.dart';

class SettingsForm extends StatefulWidget {

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  final List<int> strengths = [100, 200, 300, 400, 500, 600, 700, 800, 900];

  // form values
   String? _currentName;
   String? _currentSugars;
   int? _currentStrength;


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
       stream: DatabaseService(uid: user.uid).userData,
        builder: (context, AsyncSnapshot<UserData> snapshot) {
          print(snapshot.error);
         if(snapshot.hasData){

           UserData? userData = snapshot.data;

           return Form(
               key: _formKey,
               child: Column(
                 children: <Widget>[
                   Text(
                     'Update your brew settings.',
                     style: TextStyle(fontSize: 18.0),
                   ),
                   SizedBox(height: 20.0),
                   TextFormField(
                     initialValue: userData?.name,
                     decoration: const InputDecoration(),
                     validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                     onChanged: (val) => setState(() => _currentName = val),
                   ),
                   SizedBox(height: 10.0),
                   DropdownButtonFormField(
                     value: _currentSugars ?? 'userData.sugars',
                     decoration: const InputDecoration(),
                     items: sugars.map((sugar) {
                       return DropdownMenuItem(
                         value: sugar,
                         child: Text('$sugar sugars'),
                       );
                     }).toList(),
                     onChanged: (value){
                       setState(() => _currentSugars = '$value');
                     },
                   ),
                   Slider(
                     value: (_currentStrength ?? userData?.strength)!.toDouble(),
                     activeColor: Colors.brown[_currentStrength ?? userData!.strength],
                     inactiveColor: Colors.brown[_currentStrength ?? userData!.strength],
                     min: 100.0,
                     max: 900.0,
                     divisions: 8,
                     onChanged: (value){
                       setState(() => _currentStrength = value.round());
                     },
                   ),

                   SizedBox(height: 10.0),
                   RaisedButton(
                       color: Colors.pink[400],
                       child: Text(
                         'Update',
                         style: TextStyle(color: Colors.white),
                       ),
                       onPressed: () async {
                         print(_currentName);
                         print(_currentSugars);
                         print(_currentStrength);
                       }
                   ),
                 ],
               ),
             );
         }else{
           return Loading();
         }
       }
     );
  }
}