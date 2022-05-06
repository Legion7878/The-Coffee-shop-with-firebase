import 'package:flutter/material.dart';
import 'package:mycoffeeshop/models/user.dart';
import 'package:mycoffeeshop/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:mycoffeeshop/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    // At Wrapper
    final user = Provider.of<MyUser?>(context);
    print(user);

    // return either home or authenticate widget
    if (user == null ) {
      return  Authenticate();
    }else{
      return Home();
    }
  }
}
