import 'package:flutter/material.dart';

Color? getChipColor (String status) {
  switch (status) {
    case 'New' : return const Color.fromARGB(255, 20, 20, 147);
    case 'Completed' : return Color.fromARGB(255, 9, 117, 112);
    case 'Cancelled' : return const Color.fromARGB(255, 255, 13, 13);
    case 'Progress' : return Color.fromARGB(250, 172, 17, 232);
    defalut : return Colors.grey;
  }
}