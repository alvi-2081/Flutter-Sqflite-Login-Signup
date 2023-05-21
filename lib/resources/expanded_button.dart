import 'package:flutter/material.dart';
import 'package:sqflite_app/utils/colors.dart';

class ExpandedButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  const ExpandedButton({
    Key? key,
    required this.title,
    this.loading = false,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
          onPressed: loading ? null : onPress,
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16), // <-- Radius
              ),
              disabledBackgroundColor: AppColors.green,
              backgroundColor: AppColors.green,
              elevation: 3,
              minimumSize: const Size(double.infinity, 55)),
          child: loading
              ? const SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(title, style: const TextStyle(color: Colors.white))),
    );
  }
}
