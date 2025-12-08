import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  final IconData icon;
  final Color colorIcon;
  final String data;
  final String descripcion;
  const CardView({
    super.key,
    required this.icon,
    required this.data,
    required this.descripcion,
    required this.colorIcon
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          //border: Border.all(color: Colors.grey.shade100),
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.onPrimaryContainer
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: colorIcon,
              size: 30,
            ),
            SizedBox(height: 24,),
            Text(
              data,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              descripcion,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
