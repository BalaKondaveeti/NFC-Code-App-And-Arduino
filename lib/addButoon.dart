import 'package:college_project/allTheData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddButton extends StatelessWidget {
  AddButton({Key? key}) : super(key: key);
  final TextEditingController textEditingController1 = TextEditingController();
  final TextEditingController textEditingController2 =
      TextEditingController(text: "/");
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AllTheData>(context);
    textEditingController1.text = "Button" + " ${provider.buttons.length + 1}";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add a Button",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            CusTextField(
              label: "Button Name",
              textEditingController: textEditingController1,
            ),
            SizedBox(height: 10),
            CusTextField(
              label: "Url Tail",
              textEditingController: textEditingController2,
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  enableFeedback: true,
                  onTap: () {
                    provider.addNewButton(
                      buttonName: textEditingController1.text,
                      url: textEditingController2.text,
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Add UnSaved",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CusTextField extends StatelessWidget {
  const CusTextField(
      {required this.label, required this.textEditingController, Key? key})
      : super(key: key);
  final String label;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(child: Text(label)),
          SizedBox(width: 5),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(color: Colors.white,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                    border: InputBorder.none, contentPadding: EdgeInsets.zero),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
