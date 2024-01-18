import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../backend_connection/ApiServiceProvider.dart';
import '../../components/sidebar_navigator/SideBarNavigator.dart';
import '../../models/Role.dart';
import '../../models/SideTab.dart';
import '../../util/TabList.dart';

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

  final List<SideTab> tabList = TabList.tabList;
  void goToDocuments() {
    Navigator.pushNamed(context, '/docs/create');
  }

  List<Role> currentRoles = [];

  int? setupFor;

  void setupTabs() {
    for (SideTab tab in tabList) {
      tab.enabled = false;
    }

    if (currentRoles.contains(Role.admin) ||
        currentRoles.contains(Role.director)) {
      tabList[0].enabled = true;
    }
    if (currentRoles.where((role) => role != Role.admin).isNotEmpty) {
      tabList[2].enabled = true;
      tabIndex = 2;
    }
    if (currentRoles.contains(Role.auditor)) {
      tabList[5].enabled = true;
    }
    if (currentRoles.contains(Role.accountant_internal) ||
        currentRoles.contains(Role.accountant_offer) ||
        currentRoles.contains(Role.accountant_receipt)) {
      tabList[6].enabled = true;
    }
    if (currentRoles.contains(Role.director)) {
      tabList[1].enabled = true;
      tabList[7].enabled = true;
    }
    if (currentRoles.isEmpty) {
      tabList[3].enabled = true;
      tabIndex = 3;
    }
    if (kDebugMode) {
      tabList[4].enabled = true;
      tabIndex = 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    ApiServiceProvider apiServiceProvider =
        Provider.of<ApiServiceProvider>(context, listen: true);
    currentRoles = apiServiceProvider.currentUser?.roles ?? [];
    if (apiServiceProvider.currentUser != null && setupFor != apiServiceProvider.currentUser?.id) {
      setupFor = apiServiceProvider.currentUser?.id;
      setupTabs();
    }

    int notificationsCount = apiServiceProvider.notifications.values
        .reduce((value, element) => value + element);

    return Scaffold(
      drawer: SideBarNavigator(
          tabList: tabList,
          callback: changeTab,
          currentUser: apiServiceProvider.currentUser,
          drawerWidth: 240),
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: Builder(
          builder: (context) => GestureDetector(
            key: const Key('navigationIconKey'),
            child: SizedBox(
              width: 50,
              height: 50,
              child: Center(
                child: Stack(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                      child: Icon(Icons.menu),
                    ),
                    notificationsCount != 0 ? Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Center(
                          child: Text(
                            notificationsCount.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 6,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ) : const SizedBox(),
                  ],
                ),
              ),
            ),
            onTap: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(tabList[tabIndex].name),
      ),
      body: tabList[tabIndex].screen,
      floatingActionButton: apiServiceProvider.isUserEmployee() ? FloatingActionButton.extended(
        key: const Key('scanButtonKey'),
        onPressed: () {goToDocuments();},
        foregroundColor: Colors.white,
        focusColor: Colors.lightGreen,
        backgroundColor: Colors.black,
        label: const Text("Skeniraj"),
        icon: const Icon(Icons.add),
      ) : null,
    );
  }
}
