import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier{
  final String title;
  final String body;
  HomeProvider({required this.title, required this.body});
}