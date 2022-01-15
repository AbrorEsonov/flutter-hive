import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_example/entity/custom_response.dart';
import 'package:hive_example/entity/users.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'entity/utils/dio_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final applicationDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(applicationDocumentDir.path);
  Hive.registerAdapter(UsersAdapter());
  await Hive.openBox("users");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DioClient _client = DioClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<CustomResponse?>(
          future: _client.getUsers(),
          builder: (context, snapshot) {
            return ValueListenableBuilder<Box>(
              valueListenable: Hive.box("users").listenable(),
              builder: (context, data, _) {
                return data.isNotEmpty
                    ? RefreshIndicator(
                  onRefresh: _client.updateData,
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (ctx, index) {
                            final item = data.getAt(index) as Users;
                            return ListTile(
                              title: Text("${item.first_name} ${item.last_name}"),
                              subtitle: Text("${item.email}"),
                            );
                          }),
                    )
                    : Container();
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
