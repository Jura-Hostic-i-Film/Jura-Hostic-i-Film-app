import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/app/main/Tabs/UsersScreen.dart';
import 'package:jura_hostic_i_film_app/app/main/tabs/ArchiveScreen.dart';
import 'package:jura_hostic_i_film_app/app/main/tabs/DebugScreen.dart';
import 'package:jura_hostic_i_film_app/app/main/tabs/RevisionScreen.dart';
import 'package:jura_hostic_i_film_app/app/main/tabs/SignatureScreen.dart';
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
  int tabIndex = 0;

  void changeTab(SideTab sideTab) {
    setState(() {
      tabIndex = tabList.indexOf(sideTab);
    });
  }

  final List<SideTab> tabList = [
    SideTab(screen: const UsersScreen(), name: 'Korisnici', icon: null, enabled: false),
    SideTab(screen: const HistoryScreen(), name: 'Povijest', icon: null, enabled: false),
    SideTab(screen: const UnauthorizedScreen(), name: '', icon: null, enabled: false),
    SideTab(screen: const DebugScreen(), name: 'DEBUG', icon: null, enabled: false),
    SideTab(screen: const RevisionScreen(), name: 'Revizije', icon: null, enabled: false),
    SideTab(screen: const ArchiveScreen(), name: 'Arhiva', icon: null, enabled: false),
    SideTab(screen: const SignatureScreen(), name: 'Potpisi', icon: null, enabled: false),
  ];

  bool setupTabList = true;

  @override
  Widget build(BuildContext context) {
    ApiServiceProvider apiServiceProvider = Provider.of<ApiServiceProvider>(context, listen: true);
    List<Role> currentRoles = apiServiceProvider.currentUser?.roles ?? [];

    if (setupTabList) {
      if (currentRoles.contains(Role.admin) || currentRoles.contains(Role.director)) {
        tabList[0].enabled = true;
      }
      if (currentRoles.where((role) => role != Role.admin).isNotEmpty) {
        tabList[1].enabled = true;
        tabIndex = 1;
      }
      if (currentRoles.contains(Role.auditor)) {
        tabList[4].enabled = true;
      }
      if (currentRoles.contains(Role.accountant_internal) ||
          currentRoles.contains(Role.accountant_offer) ||
          currentRoles.contains(Role.accountant_receipt)) {
        tabList[5].enabled = true;
      }
      if (currentRoles.contains(Role.director)) {
        tabList[6].enabled = true;
      }
      if (currentRoles.isEmpty) {
        tabList[2].enabled = true;
        tabIndex = 2;
      }
      if (kDebugMode) {
        tabList[3].enabled = true;
        tabIndex = 3;
      }
      setupTabList = false;
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