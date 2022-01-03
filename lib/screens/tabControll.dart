import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_signup_ui_starter/screens/homePage.dart';
import 'news.dart';
import 'profile.dart';
void main() {
  runApp(const AllTabControll());
}

class AllTabControll extends StatelessWidget {
  const AllTabControll({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     home: DefaultTabController(
          length: 4,
          child: Scaffold(
          
            bottomNavigationBar: menu(),
            body: TabBarView(
              children: [
                HomePage(),
                News(),
                Profile(),
                Container(child: Icon(Icons.directions_bike)),
              ],
            ),
          ),
        ),
    );
    
  }
  
}

     Widget menu() {
return Container(
  color: Color.fromRGBO(255,255,255,0),
  child: TabBar(
    labelColor:  Colors.pink,
    unselectedLabelColor:Colors.black,
    indicatorSize: TabBarIndicatorSize.tab,
    indicatorPadding: EdgeInsets.all(5.0),
    indicatorColor: Colors.blue,
    tabs: [
      Tab(
        text: "HOME",
        icon: Icon(Icons.home)
      ),
      Tab(
        text: "NEWS",
        icon: Icon(Icons.assignment),
      ),
      Tab(
        text: "Balance",
        icon: Icon(Icons.account_balance_wallet),
      ),
      Tab(
        text: "Options",
        icon: Icon(Icons.settings),
      ),
    ],
  ),
);
} 