import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool small;

  const PrimaryButton({required this.text, required this.onPressed, this.small=false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: small ? EdgeInsets.symmetric(vertical:8, horizontal:12) : EdgeInsets.symmetric(vertical:14, horizontal:20),
        textStyle: TextStyle(fontSize: small ? 14 : 16, fontWeight: FontWeight.w600),
        elevation: 2,
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
