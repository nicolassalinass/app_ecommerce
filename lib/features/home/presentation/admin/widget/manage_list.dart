import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ManageList extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;
  const ManageList({super.key, required this.icon, required this.title, required this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          //border: Border.all(color: Colors.grey.shade200),
        color: Theme.of(context).colorScheme.onPrimaryContainer
      ),
      child: ListTile(
        onTap: () {
          context.push(route);
        },
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.blue, size: 25,),
        ),
        title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
        trailing: Icon(Icons.arrow_forward_ios_outlined),
        contentPadding: EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8),
      ),
    );
  }
}
