import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/helpers/user_info.helper.dart';
import 'package:uq_system_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:uq_system_app/presentation/blocs/auth/auth_event.dart';
import 'package:uq_system_app/presentation/blocs/auth/auth_state.dart';
import 'package:uq_system_app/presentation/navigation/navigation.dart';
import 'package:uq_system_app/presentation/pages/settings/settings_bloc.dart';

import '../../../helpers/google_auth.helper.dart';

@RoutePage()
class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsBloc _bloc = getIt.get<SettingsBloc>();

  @override
  void dispose() {
    _bloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                current.status == AuthStatus.loggedOut,
            listener: (context, state) {
              context.router.replace(const LoginRoute());
            },
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            elevation: 2,
            shadowColor: context.colors.hint.withOpacity(0.5),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: context.colors.primary,
              ),
              color: context.colors.secondary,
              onPressed: () {
                context.router.pop();
              },
            ),
            centerTitle: false,
            title: Text('Cài đặt',
                style: context.typographies.bodyBold
                    .copyWith(color: context.colors.primary, fontSize: 20)),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
              ),
              InkWell(
                onTap: () {
                  context.router.push(const NotificationSettingsRoute());
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Text("Cài đặt thông báo",
                        style: context.typographies.title3),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Text("Điều chỉnh Bảo Mật",
                      style: context.typographies.title3),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Text("Điều khoản dịch vụ",
                      style: context.typographies.title3),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Text("Ngôn ngữ", style: context.typographies.title3),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Text("Trợ giúp", style: context.typographies.title3),
                ),
              ),
              InkWell(
                onTap: () async {
                  getIt.get<AuthBloc>().add(const AuthLoggedOut());
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child:
                        Text("Đăng xuất", style: context.typographies.title3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
