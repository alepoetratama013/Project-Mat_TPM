import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stock_app/models/user_model.dart';
import 'package:stock_app/pages/loginpage.dart';
import 'package:stock_app/widgets/encryption.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Registration",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    usernameTextField(),
                    const SizedBox(height: 20),
                    passwordTextField(),
                    const SizedBox(height: 20),
                    loginButton(),
                    const SizedBox(height: 20),
                    changeButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget usernameTextField() {
    return TextFormField(
      controller: usernameController,
      decoration: InputDecoration(
        hintText: "Username",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget passwordTextField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
    );
  }

  Widget loginButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          if (Hive.isBoxOpen('users')) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Loginpage(),
              ),
            );
            await addUser(usernameController.text, passwordController.text);
          } else {
            await Hive.openBox('users');

            if (context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Loginpage(),
                ),
              );
            }
            await addUser(usernameController.text, passwordController.text);
          }
        },
        child: const Text(
          'Register',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget changeButton() {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Sudah punya akun?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Loginpage(),
                ),
              );
            },
            child: const Text(
              'Masuk',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> addUser(String email, String password) async {
    var user = Hive.box("users");
    String encryptedPassword = CustomEncryption.enrcyptAES(password).toString();

    user.add(User(email, encryptedPassword));
  }
}
