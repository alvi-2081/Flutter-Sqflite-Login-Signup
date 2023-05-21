import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String? headerName;

  Header(this.headerName);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20.0),
        Text(
          headerName!,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 40.0),
        ),
        const SizedBox(height: 10.0),
        Image.asset(
          "assets/images/logo.jpeg",
          height: 150.0,
          width: 150.0,
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Sample Code',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black38,
              fontSize: 25.0),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
