import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';
import 'package:uq_system_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:uq_system_app/presentation/blocs/auth/auth_event.dart';

import '../../../../assets.gen.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthBloc _bloc = getIt.get<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.images.imgLoginBg.path),
                fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to",
                style: context.typographies.title1.withColor(Colors.white)),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("ECooking",
                    style: context.typographies.title1
                        .withColor(context.colors.secondary)),
                const SizedBox(
                  width: 10,
                ),
                AssetGenImage(Assets.icons.png.icHello.path).image(width: 40)
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text("The cooking and food recipes\n app for century",
                textAlign: TextAlign.center,
                style: context.typographies.body.withColor(Colors.white),),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              child: ElevatedButton(onPressed: (){
                _bloc.add(const AuthLogin(loginType: LoginType.google));
              }, child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AssetGenImage(Assets.icons.png.icGoogle.path).image(width: 30),
                  const SizedBox(
                    width: 15,
                  ),
                  Text("Continue with Google", style: context.typographies.buttonBold,)
                ],
              )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              child: ElevatedButton(onPressed: (){

              }, child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AssetGenImage(Assets.icons.png.icFacebook.path).image(width: 30),
                  const SizedBox(
                    width: 15,
                  ),
                  Text("Continue with Facebook", style: context.typographies.buttonBold,)
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
