import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/user_model.dart';
import 'package:weather/provider/user_provider.dart';
import 'package:weather/ui/mobile_home_page.dart';
import 'package:weather/utils/custom_button.dart';
import 'package:weather/utils/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Icon(Icons.cloud,size: 50, color: Colors.amberAccent,),
          const Text(
            'Weather Forecast',
            style: kTextStyletitle,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomButton(
              borderRadius: 8,
              textSize: 16,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              text: 'Login with Github',
              onPressed: () {
                signInWithGitHub(context);
              },
            ),
          )
        ],
      ),
    ));
  }

  Future<void> signInWithGitHub(BuildContext context) async {
    UserModel newUser;
    try {
      GithubAuthProvider githubProvider = GithubAuthProvider();
      final result =
          await FirebaseAuth.instance.signInWithProvider(githubProvider);

      if (result.credential!.accessToken != null) {
        newUser = UserModel(result.credential!.token.toString(),
            result.user!.displayName ?? '', result.user!.photoURL ?? '');
        // ignore: use_build_context_synchronously
        final userProvider = context.read<UserProvider>();
        userProvider.setUser(newUser);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MobileHomePage()),
        );
      }
    } catch (e) {
      debugPrint('something went wrong ${e.toString()}');
    }
  }
}
