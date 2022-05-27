import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class MissingCard extends StatelessWidget {
  final String name;
  final String age;
  final String image;
  final String lastwear;
  final int feet;
  final int inches;
  const MissingCard(
      {Key? key,
      required this.name,
      required this.age,
      required this.image,
      required this.lastwear,
      required this.feet,
      required this.inches})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      child: Card(
          elevation: 3,
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 300,
                    width: 300,
                    child: Column(
                      children: [
                        Container(
                          width: 300,
                          child: ListTile(
                            title: Text(
                              name,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text("Name"),
                          ),
                        ),
                        Container(
                          width: 300,
                          child: ListTile(
                            title: Text(
                              age,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text("Age"),
                          ),
                        ),
                        Container(
                          width: 300,
                          child: ListTile(
                            title: Text(lastwear,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                            subtitle: Text("Last Wearing"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              foregroundImage: NetworkImage(image),
                              minRadius: 10,
                              maxRadius: 100,
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: ListTile(
                            title: Text(
                              "${feet} feet ${inches} inches",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                            subtitle:
                                Text("Height", textAlign: TextAlign.center),
                          ))
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
