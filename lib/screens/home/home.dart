import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycoffeeshop/models/brew.dart';
import 'package:mycoffeeshop/screens/home/settings_form.dart';
import 'package:mycoffeeshop/services/auth.dart';
import 'package:mycoffeeshop/services/database.dart';
import 'package:provider/provider.dart';
import 'package:mycoffeeshop/screens/home/brew_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

   void _showSettingsPanel(){
   showModalBottomSheet(context: context, builder: (context){
     return Container(
       padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
       child: SettingsForm(),
     );
   });
 }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: '').brews,
      initialData: const [],
      child: Scaffold(
        backgroundColor: Colors.deepOrange,
        appBar: AppBar(
          title:Text('Coffee Shop'),
          backgroundColor: Colors.deepOrangeAccent,
          elevation: 0.0,
          actions: <Widget> [
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("Logout"),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
