import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/presentation/navigation/navigation.dart';

import '../../../assets.gen.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    check();
  }

  Future<void> check() async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      AutoRouter.of(context).replace(const DashboardRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AssetGenImage(Assets.images.appLogo.path).image(width: 200),
            const SizedBox(),
            Text(
              "ECooking",
              style: context.typographies.title1,
            )
          ],
        ),
      ),
    );
  }
}
