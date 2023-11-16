import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/app/main/Tabs/UsersScreen.dart';
import 'package:jura_hostic_i_film_app/app/main/tabs/UnaothorizedScreen.dart';
import 'package:provider/provider.dart';
import '../../backend_connection/ApiServiceProvider.dart';
import '../../components/sidebar_navigator/SideBarNavigator.dart';
import '../../models/Role.dart';
import '../../models/SideTab.dart';
import 'Tabs/HistoryScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int tabIndex = 1;

  void changeTab(SideTab sideTab) {
    setState(() {
      tabIndex = tabList.indexOf(sideTab);
    });
  }

  final List<SideTab> tabList = [
    SideTab(screen: const UsersScreen(), name: 'Korisnici', icon: null, enabled: false),
    SideTab(screen: const HistoryScreen(), name: 'Povijest', icon: null, enabled: false),
    SideTab(screen: UnauthorizedScreen(), name: '', icon: null, enabled: false),
  ];

  @override
  Widget build(BuildContext context) {
    ApiServiceProvider apiServiceProvider = Provider.of<ApiServiceProvider>(context, listen: true);
    List<Role> currentRoles = apiServiceProvider.currentUser?.roles ?? [];

    if (currentRoles.contains(Role.admin) || currentRoles.contains(Role.director)) {
      tabList[0].enabled = true;
    }
    if (currentRoles.where((role) => role != Role.admin).isNotEmpty) {
      tabList[1].enabled = true;
    } else {
      tabIndex = 0;
    }
    if (currentRoles.isEmpty) {
      tabList[2].enabled = true;
      tabIndex = 2;
    }

    return Scaffold(
      drawer: SideBarNavigator(
          tabList: tabList,
          callback: changeTab,
          currentUser: apiServiceProvider.currentUser,
          drawerWidth: 240),
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