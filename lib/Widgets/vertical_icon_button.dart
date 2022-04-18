import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerticalIconButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const VerticalIconButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            height: 2.0,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
