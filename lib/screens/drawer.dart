import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:missing/globals.dart';
import 'package:missing/loginpage.dart';
import 'package:missing/providers/log_out.dart';
import 'package:missing/providers/switch_screen.dart';
import 'package:missing/providers/user_details.dart';
import 'package:provider/provider.dart';

class DrawerMain extends StatefulWidget {
  const DrawerMain({Key? key}) : super(key: key);

  @override
  State<DrawerMain> createState() => _DrawerMainState();
}

class _DrawerMainState extends State<DrawerMain> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 400,
            child: ListView(children: [
              Container(
                height: 230,
                child: FutureBuilder(
                    future: context.read<UserDetails>().getUser(currentUid),
                    builder: ((context,
                        AsyncSnapshot<Map<String, dynamic>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.person),
                              title: Text(
                                "${snapshot.data!['name']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 15),
                              ),
                              subtitle: Text("Name"),
                            ),
                            ListTile(
                              leading: Icon(Icons.phone),
                              title: Text(
                                "${snapshot.data!['phone']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 15),
                              ),
                              subtitle: Text("Phone Number"),
                            ),
                            ListTile(
                              leading: Icon(Icons.email),
                              title: Text(
                                "${snapshot.data!['email']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 15),
                              ),
                              subtitle: Text("Email"),
                            ),
                          ],
                        );
                      } else
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                    })),
              ),
              TextButton(
                  onPressed: () {
                    context.read<SwitchScreen>().toMe();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    child: Text("Reported by me"),
                  )),
              TextButton(
                  onPressed: () {
                    context.read<SwitchScreen>().toAll();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    child: Text("All Missing"),
                  )),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                    onPressed: () async {
                      await context.read<LogOut>().logout();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "LOG OUT",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.logout,
                          color: Colors.white,
                        )
                      ],
                    )),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
