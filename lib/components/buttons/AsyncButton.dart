import 'package:flutter/material.dart';

class AsyncButton extends StatefulWidget {
  final Function onTap;
  final Widget content;
  final Widget? loadingContent;
  const AsyncButton({required this.onTap, required this.content, this.loadingContent, super.key});

  @override
  State<StatefulWidget> createState() => AsyncButtonState();
}

class AsyncButtonState extends State<AsyncButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
        ),
        margin: const EdgeInsets.symmetric(vertical: 20),
        height: 50,
        child: loading ? widget.loadingContent ?? const Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ) : widget.content,
      ),
      onTap: () async {
        if (loading) return;
        setState(() => loading = true);
        await widget.onTap();
        setState(() => loading = false);
      },
    );
  }
}