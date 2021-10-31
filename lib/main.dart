import 'package:college_project/DetailsPage.dart';
import 'package:college_project/SIngleTon.dart';
import 'package:college_project/addButoon.dart';
import 'package:college_project/allTheData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SingleTon.singleTon.initialise();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  Widget build(BuildContext buildContext) {
    return ChangeNotifierProvider(
      create: (context) => AllTheData(),
      child: MaterialApp(
        theme: ThemeData(
            textTheme:
                const TextTheme(bodyText2: const TextStyle(fontSize: 18)),
            appBarTheme: const AppBarTheme(
                centerTitle: true,
                elevation: 0,
                color: Colors.transparent,
                iconTheme: const IconThemeData(color: Colors.black)),
            scaffoldBackgroundColor: const Color(0xFFECF0F3)),
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AllTheData>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: provider.clear,
              icon: Container(
                  decoration: BoxDecoration(
                      border: Border.all(), shape: BoxShape.circle),
                  padding: const EdgeInsets.all(1),
                  child: const Icon(Icons.clear_rounded))),
          IconButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DetailsPage())),
              icon: Container(
                  decoration: BoxDecoration(
                      border: Border.all(), shape: BoxShape.circle),
                  padding: const EdgeInsets.all(1),
                  child: const Icon(Icons.menu))),
          IconButton(
              onPressed: provider.saveData,
              icon: Container(
                  decoration: BoxDecoration(
                      border: Border.all(), shape: BoxShape.circle),
                  padding: const EdgeInsets.all(1),
                  child: const Icon(Icons.save)))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (provider.showRequestSuccess)
                const Text(
                  "Request Sent",
                  style: const TextStyle(color: Colors.green),
                ),
              if (provider.showSaved)
                const Text(
                  "Data Saved",
                  style: const TextStyle(color: Colors.green),
                ),
              if (provider.showError)
                Column(
                  children: [
                    const Text(
                      "Found Error",
                      style: const TextStyle(color: Colors.red),
                    ),
                    Text(
                      "message : " + provider.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              const SizedBox(height: 10),
              AddButtonWidget(),
              ...provider.buttons
                  .map<Widget>((e) => InkWell(
                        onTap: () => provider.sendRequest(e[1]),
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.power_settings_new,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                e[0],
                                style: const TextStyle(color: Colors.white),
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: () => provider.removeButton(e),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                        ),
                      ))
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}

class AddButtonWidget extends StatelessWidget {
  const AddButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Add Buttons "),
        Expanded(
            child: Container(
          decoration: BoxDecoration(border: Border.all()),
        )),
        const SizedBox(width: 4),
        CircleAvatar(
            maxRadius: 16,
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            child: InkWell(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AddButton())),
                child: const Icon(Icons.add))),
      ],
    );
  }
}
