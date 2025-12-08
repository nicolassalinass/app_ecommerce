import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OptionUserList extends StatelessWidget {
  final String title;
  final IconData icon;
  final String pathRoute;
  const OptionUserList({super.key, required this.icon, required this.title, required this.pathRoute});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(pathRoute),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          borderRadius: BorderRadius.circular(15),
          // border: BoxBorder.fromBorderSide(BorderSide(
          //   //width: 0.1,
          //   color: Colors.grey.shade50
          // ))
        ),
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 20,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.shade100
                  ),
                  child: Icon(
                    icon,
                    size: 30,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(title, style: TextStyle(fontSize: 20),)
              ],
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
