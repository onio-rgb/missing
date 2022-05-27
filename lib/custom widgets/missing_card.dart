import 'package:flutter/material.dart';
class MissingCard extends StatelessWidget {
  String name;
  String age;
  String image;
  String lastwear;
  int feet;
  int inches;
  const MissingCard({Key? key,required this.name,required this.age,required this.image,required this.lastwear,required this.feet,required this.inches}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        ListTile(
          
        )
      ]),
    )
  }
}