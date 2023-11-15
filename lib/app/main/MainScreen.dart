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
    return Scaffold(
      drawer: SideBarNavigator(tabList, changeTab, 240),
      appBar: AppBar(),
      body: tabList[tabIndex].screen,
    );
  }
}