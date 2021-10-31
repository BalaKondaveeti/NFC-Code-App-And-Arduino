import 'package:college_project/SIngleTon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class AllTheData with ChangeNotifier {
  String? ipAddress;
  String? errorMessage;

  List<List<String>> buttons = [];
  bool showRequestSuccess = false;
  bool showError = false;
  bool showSaved = false;

  AllTheData() {
    var title = SingleTon().sharedPreferences.getStringList("title");
    var url = SingleTon().sharedPreferences.getStringList("url");
    int length = title?.length ?? 0;
    for (int i = 0; i < length; ++i) {
      buttons.add([title![i], url![i]]);
    }
  }

  saveData() async {
     clear();
    List<String> title = [];
    List<String> url = [];
    for (int i = 0; i < buttons.length; ++i) {
      title.add(buttons[i][0]);
      url.add(buttons[i][1]);
    }
    await SingleTon().sharedPreferences.setStringList("title", title);
    await SingleTon().sharedPreferences.setStringList("url", url);
    showSaved = true;
    notifyListeners();
  }

  addNewButton({
    required buttonName,
    required url,
  }) {
    clear();
    buttons.add([buttonName, url]);
    showSaved = false;
    notifyListeners();
  }

  removeButton(value) {
    clear();
    buttons.remove(value);
    showSaved = false;
    notifyListeners();
  }

  clear() {
    showRequestSuccess = false;
    showError = false;
    showSaved = false;
    notifyListeners();
  }

  sendRequest(value) async {
    clear();
    try {
      print("Sending Request");
      await get(Uri.parse("http://192.168.4.1" + value));
      print("Request sent");
      showRequestSuccess = true;
      showError = false;
      notifyListeners();
    } catch (e) {
      print(e);
      errorMessage = e.toString();
      showError = true;
      notifyListeners();
    }
  }
}
