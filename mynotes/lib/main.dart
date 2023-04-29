import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Homepage(),
    ),
  );
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType:TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
            ),
          ),
          TextField(
            controller: _password,
            obscureText:true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
            ),
          ),
          TextButton(
            onPressed: () async {
              final email=_email.text;
              final password=_password.text;
              await Firebase.initializeApp(
                options:DefaultFirebaseOptions.currentPlatform,
              );
              final userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
              print(userCredential);
            },
            child: const Text("Register"),
          ),
        ],
      ),
    );
  }
}
