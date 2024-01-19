import 'package:jura_hostic_i_film_app/app/main/tabs/FullHistoryScreen.dart';

import '../app/main/tabs/HistoryScreen.dart';
import '../app/main/tabs/UsersScreen.dart';
import '../app/main/tabs/ArchiveScreen.dart';
import '../app/main/tabs/DebugScreen.dart';
import '../app/main/tabs/RevisionScreen.dart';
import '../app/main/tabs/SignatureScreen.dart';
import '../app/main/tabs/UnaothorizedScreen.dart';
import '../models/SideTab.dart';

class TabList {
  static List<SideTab> tabList = [
    SideTab(screen: const UsersScreen(), name: 'Korisnici', key: '/home/users', icon: null, enabled: false),
    SideTab(screen: const FullHistoryScreen(), name: 'Povijest', key: '/home/fullhistory', icon: null, enabled: false),
    SideTab(screen: const HistoryScreen(), name: 'Moja povijest', key: '/home/history', icon: null, enabled: false),
    SideTab(screen: const UnauthorizedScreen(), name: '', key: '/home/unauth', icon: null, enabled: false),
    SideTab(screen: const DebugScreen(), name: 'DEBUG', key: '/home/debug', icon: null, enabled: false),
    SideTab(screen: const RevisionScreen(), name: 'Revizije', key: '/home/revision', icon: null, enabled: false),
    SideTab(screen: const ArchiveScreen(), name: 'Arhiva', key: '/home/archive', icon: null, enabled: false),
    SideTab(screen: const SignatureScreen(), name: 'Potpisi', key: '/home/signature', icon: null, enabled: false),
  ];
}

