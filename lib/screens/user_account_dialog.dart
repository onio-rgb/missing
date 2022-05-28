import 'package:flutter/material.dart';
import 'package:missing/globals.dart';
import 'package:missing/loginpage.dart';
import 'package:missing/providers/log_out.dart';
import 'package:missing/providers/user_details.dart';
import 'package:provider/provider.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({Key? key}) : super(key: key);

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 350,
        child: Column(children: [
          Expanded(
            flex: 3,
            child: Container(
              height: 300,
              child: FutureBuilder(
                  future: context.read<UserDetails>().getUser(currentUid),
                  builder:
                      ((context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text(
                              "${snapshot.data!['name']}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                            ),
                            subtitle: Text("Name"),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text(
                              "${snapshot.data!['phone']}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                            ),
                            subtitle: Text("Phone Number"),
                          ),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text(
                              "${snapshot.data!['email']}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20),
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
          ),
          Expanded(
            child: Padding(
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
            ),
          )
        ]),
      ),
    );
  }
}
