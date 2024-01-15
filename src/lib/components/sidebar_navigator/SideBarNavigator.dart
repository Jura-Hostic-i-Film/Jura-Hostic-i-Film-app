import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/backend_connection/ApiServiceProvider.dart';
import 'package:provider/provider.dart';
import '../../models/SideTab.dart';
import '../../models/User.dart';
import '../users/RoleDisplayable.dart';

class SideBarNavigator extends Drawer {
  final List<SideTab> tabList;
  final Function callback;
  final double drawerWidth;
  final User? currentUser;

  const SideBarNavigator({required this.tabList, required this.callback, required this.drawerWidth, required this.currentUser, super.key});

  @override
  Widget build(BuildContext context) {
    ApiServiceProvider apiServiceProvider = Provider.of<ApiServiceProvider>(context, listen: true);

    return SizedBox(
      width: drawerWidth,
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: drawerWidth,
              color: Colors.black,
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(10),
              child: Container(
                padding: const EdgeInsets.only(top: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      currentUser?.username ?? '',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      currentUser?.email ?? '',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: currentUser?.roles.map((role) => RoleDisplayable(role: role)).toList() ?? [],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: tabList.where((sideTab) => sideTab.enabled && sideTab.name != '')
                  .toList()
                  .asMap()
                  .map(
                    (i, sideTab) => MapEntry(i,
                  Material(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.black.withOpacity(0.5),
                      onTap: () => {
                        callback(sideTab),
                        Navigator.of(context).pop()
                      },
                      child: Ink(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: drawerWidth,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                sideTab.name,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                              apiServiceProvider.notifications[sideTab.key] != 0 ? Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(
                                  child: Text(
                                    apiServiceProvider.notifications[sideTab.key].toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ) : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ).values.toList(),
            ),
            Column(
              children: [
                Material(
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.black.withOpacity(0.5),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/auth/logout');
                    },
                    child: Ink(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: drawerWidth,
                        height: 40,
                        child: const Text(
                          'Odjavi se',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}