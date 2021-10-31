import 'package:shared_preferences/shared_preferences.dart';

class SingleTon {
  factory SingleTon() => singleTon;

  static SingleTon singleTon = SingleTon.edited();

  late SharedPreferences sharedPreferences;

  SingleTon.edited();

  initialise() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}
