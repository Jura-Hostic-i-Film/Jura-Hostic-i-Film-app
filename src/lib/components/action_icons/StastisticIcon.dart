import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/models/Statistic.dart';
import 'package:provider/provider.dart';
import '../../backend_connection/ApiServiceProvider.dart';
import '../../models/User.dart';
import '../loading/LoadingModal.dart';

class StatisticIcon extends StatelessWidget {
  final User user;

  const StatisticIcon({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    ApiServiceProvider apiServiceProvider =
        Provider.of<ApiServiceProvider>(context, listen: false);

    return GestureDetector(
      onTap: () async {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return FutureBuilder(
                future: apiServiceProvider.getUserStatistics(user.username),
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  return SimpleDialog(
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white,
                    titlePadding: EdgeInsets.zero,
                    contentPadding: const EdgeInsets.all(12),
                    children: [
                      SizedBox(
                        width: 120,
                        height: 240,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: snapshot.hasData
                              ? [
                                  const Text(
                                    "Statistika",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: snapshot.requireData
                                          .map(
                                            (key, value) => MapEntry(
                                          key,
                                          Text(
                                            "${Statistic.fromString(key).displayName()}: ${value.toString()}",
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      )
                                          .values
                                          .toList(),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: const Text(
                                          "U redu",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]
                              : [
                                  const Center(
                                    child: SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: LoadingModal(),
                                    ),
                                  ),
                                ],
                        ),
                      ),
                    ],
                  );
                },
              );
            });
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: const Icon(
          Icons.bar_chart,
          size: 28,
        ),
      ),
    );
  }
}
