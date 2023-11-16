import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/backend_connection/ApiServiceProvider.dart';
import 'package:provider/provider.dart';
import '../../models/SideTab.dart';

class SideBarNavigator extends Drawer {
  final List<SideTab> tabList;
  final Function callback;
  final double drawerWidth;

  const SideBarNavigator(this.tabList, this.callback, this.drawerWidth, {super.key});

  @override
  Widget build(BuildContext context) {
    ApiServiceProvider apiServiceProvider = Provider.of<ApiServiceProvider>(context, listen: true);
    final currentUser = apiServiceProvider.currentUser;

    return SizedBox(
      width: drawerWidth,
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: drawerWidth,
              height: 200,
              color: Colors.black,
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
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
                ],
              ),
            ),
            Column(
              children: tabList.asMap().map(
                    (i, sideTab) => MapEntry(i,
                  Material(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.black.withOpacity(0.5),
                      onTap: () => {
                        callback(i),
                        Navigator.of(context).pop()
                      },
                      child: Ink(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: drawerWidth,
                          height: 40,
                          child: Text(
                            sideTab.name,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 24,
                            ),
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
                    onTap: () async => {
                      await apiServiceProvider.logoutUser(),
                      Navigator.pushReplacementNamed(context, '/auth/login')
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