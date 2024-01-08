import 'package:flutter/material.dart';
import 'package:jura_hostic_i_film_app/components/loading/LoadingModal.dart';
import 'package:provider/provider.dart';

import '../../../backend_connection/ApiServiceProvider.dart';

class DebugScreen extends StatefulWidget {
  const DebugScreen({super.key});

  @override
  State<DebugScreen> createState() => DebugScreenState();
}

class DebugScreenState extends State<DebugScreen> {
  @override
  Widget build(BuildContext context) {
    ApiServiceProvider apiServiceProvider = Provider.of<ApiServiceProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
              child: GestureDetector(
                child: const SizedBox(
                  width: 40,
                  height: 40,
                  child: Icon(
                    Icons.refresh,
                    color: Colors.black,
                    size: 28,
                  ),
                ),
                onTap: () => setState(() {}),
              ),
          ),
          Center(
            child: false ? FutureBuilder(
                future: apiServiceProvider.apiDocumentsTest(),
                builder: (BuildContext context, AsyncSnapshot<Image?> snapshot) {
                  return snapshot.hasData ? Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 5),
                      color: Colors.red,
                    ),
                    child: snapshot.requireData ?? const SizedBox(),
                  ) : const LoadingModal();
                }
            ) : const Text("disabled"),
          ),
        ],
      ),
    );
  }
}