import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class MissingCard extends StatelessWidget {
  final String name;
  final String age;
  final String image;
  final String lastwear;
  final int feet;
  final int inches;
  final bool missing;
  final String lastloc;
  const MissingCard(
      {Key? key,
      required this.name,
      required this.age,
      required this.image,
      required this.lastwear,
      required this.feet,
      required this.inches,
      required this.missing,
      required this.lastloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
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
                    height: 400,
                    width: 250,
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
                        ),
                        Container(
                          width: 300,
                          child: ListTile(
                            title: Text(lastloc,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                            subtitle: Text("Last Seen location"),
                          ),
                        ),
                        ((missing == true)
                            ? (Container(
                                width: 300,
                                child: ListTile(
                                  title: Text("missing",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.orange)),
                                ),
                              ))
                            : (Container(
                                width: 300,
                                child: ListTile(
                                  title: Text("found",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.green)),
                                ),
                              )))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(image),
                                radius: 100,
                                backgroundColor: Colors.transparent,
                              ),
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
