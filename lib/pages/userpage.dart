import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stock_app/models/user_model.dart';
import 'package:stock_app/widgets/encryption.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive User List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: Hive.openBox("users"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    } else {
                      var users = Hive.box("users");

                      String defaultPassword =
                          CustomEncryption.enrcyptAES("hugovale").toString();

                      if (users.length == 0) {
                        users.add(
                            User("ale.poetratama@gmail.com", defaultPassword));
                      }

                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: users.length,
                        itemBuilder: ((context, index) {
                          User user = users.getAt(index);
                          return Column(
                            children: [
                              ListTile(
                                title: Text(user.email),
                                subtitle: Text(user.password),
                              ),
                              const Divider()
                            ],
                          );
                        }),
                      );
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
