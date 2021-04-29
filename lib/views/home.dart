import 'package:driverapp/components/constants.dart';
import 'package:driverapp/tabs/earningsTab.dart';
import 'package:driverapp/tabs/homeTab.dart';
import 'package:driverapp/tabs/profileTab.dart';
import 'package:driverapp/tabs/ratingsTab.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  TabController tabController;

  int selectedIndex=0;
  void onItemClicked(int index){
    setState(() {
      selectedIndex=index;
      tabController.index=selectedIndex;
    });
  }

  @override
  void initState(){
    super.initState();
    tabController=TabController(length: 4, vsync: this);

  }

//  @override
//  void dispose() {
//    // TODO: implement dispose
//    tabController.dispose();
//    super.dispose();
//  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          HomeTab(),
          EarningsTab(),
          RatingsTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card), title: Text('Earnings')),
          BottomNavigationBarItem(icon: Icon(Icons.star), title: Text('Ratings')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Account')),
        ],
        currentIndex: selectedIndex,
        unselectedItemColor: unselectedColorTabBar,
        selectedItemColor: Colors.deepOrange,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: onItemClicked,
      ),
    );
  }
}
