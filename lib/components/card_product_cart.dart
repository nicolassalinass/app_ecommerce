import 'package:flutter/material.dart';

class CardProductCart extends StatelessWidget {
  const CardProductCart({super.key});

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0, bottom: 8.0),
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          border: BoxBorder.all(color: Colors.grey.shade500, width: 0.3),
          borderRadius: BorderRadius.circular(10)
        ),
        height: screenHeight * 0.135,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                "assets/redragon3.jpg", 
                height: screenHeight * 0.12, 
                width: screenWidth * 0.25
              )
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Audifono Redragon H510 SK", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                    SizedBox(height: 5,),
                    Text(
                      "Gs. 350.000", 
                      style: TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Spacer(),   
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.remove_circle, size: 30, color: Colors.grey,),
                        ),
                        Text("1", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.add_circle, size: 30, color: Colors.grey,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.delete, color: Colors.grey.shade600,size: 28,))
          ],
        ),
      ),
    );
  }
}