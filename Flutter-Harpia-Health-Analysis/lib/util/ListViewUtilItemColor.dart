import 'package:flutter/material.dart';

class ListViewUtilItemColor{
  static Color getBackgroundColor({required int index}) {
    return index % 2 == 0 ? Colors.cyanAccent : Colors.tealAccent;
  }
}