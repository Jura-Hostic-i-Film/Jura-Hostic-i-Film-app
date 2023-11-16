import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/app/main/Tabs/HistoryScreen.dart';
import 'package:jura_hostic_i_film_app/app/main/Tabs/UsersScreen.dart';
import '../../components/sidebar_navigator/SideBarNavigator.dart';
import '../../models/SideTab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  //final GlobalKey<ScaffoldState> _key = GlobalKey();
  int tabIndex = 0;

  List<SideTab> tabList = [
    SideTab(screen: const HistoryScreen(), name: 'Povijest', icon: null),
    SideTab(screen: const UsersScreen(), name: 'Zaposlenici', icon: null),
  ];

  void changeTab(int newTabIndex) {
    setState(() {
      tabIndex = newTabIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final statusBarHeight = MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      drawer: SideBarNavigator(tabList, changeTab, 240),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(tabList[tabIndex].name),
      ),
      body: tabList[tabIndex].screen,
    );
  }
}