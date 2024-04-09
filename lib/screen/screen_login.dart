import 'package:flutter/material.dart';
import 'package:scart/widget/widget_customAppBar.dart';
import 'package:provider/provider.dart';
import '../util/kakaoController.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginState();
}
class LoginState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(83.0),
        child: CustomAppBar(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _profile(),
            _nickname(),
            _loginButton(),
          ],
        ),
      ),
    );
  }

  Widget _profile() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Consumer<UserController>(builder: (context, controller, child) {
          final String? src = controller.user?.kakaoAccount?.profile?.thumbnailImageUrl;
          // controller.user?.kakaoAccount?.profile?.thumbnailImageUrl
          if (src != null) {
            return Image.network(src, fit: BoxFit.cover);
          } else {
            return Container(
              color: Colors.black,
            );
          }
        }),
      ),
    ),
  );

  Widget _nickname() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Consumer<UserController>(builder: (context, controller, child) {
      final String? name = controller.user?.kakaoAccount?.profile?.nickname;
      // controller.user?.kakaoAccount?.profile?.nickname;
      if (name != null) {
        return Text(name);
      } else {
        return const Text("로그인이 필요합니다");
      }
    }),
  );

  Widget _loginButton() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Consumer<UserController>(builder: (context, controller, child) {
      if (controller.user != null) {
          return GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
            child: Image.asset("assets/kakao/kakao_login_medium_wide.png"),
          );
      } else {
          return GestureDetector(
          onTap: context.read<UserController>().kakaoLogin,
          child: Image.asset("assets/kakao/kakao_login_medium_wide.png"),
          );
      }
    },)
  );
}