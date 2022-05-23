import 'package:provider/provider.dart';
import 'package:flutter/material.dart';



class CurrentUser with ChangeNotifier {
  
  String uid;
  CurrentUser({required this.uid});

}
