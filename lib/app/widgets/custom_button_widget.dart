import 'package:flutter/material.dart';

import '../const/KColors.dart';

class CustomButtonWidget extends StatefulWidget {
  const CustomButtonWidget(
      {super.key, required this.text, required this.onTap});
  final String text;
  final Future<void> Function()? onTap;

  @override
  State<CustomButtonWidget> createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends State<CustomButtonWidget> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: isLoading
          ? const CircularProgressIndicator(
              strokeWidth: 3,
            )
          : InkWell(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                await widget.onTap?.call();
                setState(() {
                  isLoading = false;
                });
              },
              child: Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: gradientColor),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(child: Text(widget.text)),
              ),
            ),
    );
  }
}
