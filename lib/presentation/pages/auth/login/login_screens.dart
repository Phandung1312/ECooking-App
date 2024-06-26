import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';
import 'package:uq_system_app/helpers/google_auth.helper.dart';
import 'package:uq_system_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:uq_system_app/presentation/blocs/auth/auth_event.dart';
import 'package:uq_system_app/presentation/blocs/auth/auth_state.dart';

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
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<AuthBloc, AuthState>(

        listener: (BuildContext context, AuthState state) async{
          if (state.status == AuthStatus.success) {
            context.router.pop(true);
            return;
          }
          if(state.status == AuthStatus.blocked){
            Fluttertoast.showToast(
                msg: 'Rất tiếc tài khoản của bạn đã khóa. Vui lòng liên hệ với quản trị viên để biết thêm chi tiết.',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: context.colors.background,
                textColor: context.colors.primary,
                fontSize: 16.0);
          }
          if(state.status == AuthStatus.failure){
            Fluttertoast.showToast(
                msg: 'Đã có lỗi xảy ra. Vui lòng thử lại sau.',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: context.colors.background,
                textColor: context.colors.primary,
                fontSize: 16.0);
          }
          await GoogleAuthHelper.signOut();
        },
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Assets.images.imgLoginBg.path),
                        fit: BoxFit.cover)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Chào mừng đến với",
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
                        AssetGenImage(Assets.icons.png.icHello.path)
                            .image(width: 40)
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Ứng dụng nấu ăn và công thức\n nấu ăn dành cho bạn",
                      textAlign: TextAlign.center,
                      style: context.typographies.body.withColor(Colors.white),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                      child: ElevatedButton(
                          onPressed: () {
                            _bloc.add(const AuthLogin(loginType: LoginType.google));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AssetGenImage(Assets.icons.png.icGoogle.path)
                                  .image(width: 30),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Tiếp tục với Google",
                                style: context.typographies.buttonBold,
                              )
                            ],
                          )),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AssetGenImage(Assets.icons.png.icFacebook.path)
                                  .image(width: 30),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Tiếp tục với Facebook",
                                style: context.typographies.buttonBold,
                              )
                            ],
                          )),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {
                    context.router.pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
