import 'dart:math';

import 'package:flutter/material.dart';
import 'package:missing/providers/missing_people.dart';
import 'package:provider/provider.dart';

class FaceAuthentication {
  Future<Map<String, dynamic>> compare(
      List inputTensor, BuildContext context) async {
    await context.read<MissingPeople>().getTensorAll();
    final tensorAll = context.read<MissingPeople>().tensorDb;
    print("${tensorAll.length} number of tensors");
    double minDistance = double.maxFinite;
    Map<String, dynamic> matching_person = {};
    for (var tensor in tensorAll) {
      if (tensor['tensor'] != null) {
        double distance = euclideanDistance(tensor['tensor'], inputTensor);

        if (minDistance > distance && distance <= 0.5) {
          minDistance = distance;
          matching_person = tensor;
        }
      }
    }
    return matching_person;
  }

  double euclideanDistance(List e1, List e2) {
    double sum = 0.0;
    for (int i = 0; i < e1.length; i++) {
      sum += pow((e1[i] - e2[i]), 2);
    }
    return sqrt(sum);
  }
}
