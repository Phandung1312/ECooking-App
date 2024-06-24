import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/presentation/pages/notification_settings/notification_settings_bloc.dart';
import 'package:uq_system_app/presentation/widgets/divider_line.dart';

// TODO: Add the page to the router
@RoutePage()
class NotificationSettingsPage extends StatefulWidget {
  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  final NotificationSettingsBloc _bloc = getIt.get<NotificationSettingsBloc>();

  @override
  void dispose() {
    _bloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: context.colors.primary,
            ),
            onPressed: () {
              context.router.pop();
            },
          ),
          centerTitle: false,
          elevation: 2,
          shadowColor: context.colors.hint.withOpacity(0.5),
          title: Text('Điều chỉnh chức năng thông báo',
              style: context.typographies.bodyBold
                  .copyWith(color: context.colors.primary, fontSize: 20)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nhảy tin thông báo', style: context.typographies.title3),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bình luận', style: context.typographies.bodyBold),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                            'Đây là những thông báo cho tất cả tương tác liên quan đến bình luận, bao gồm các bình luận'
                            'về các món ăn của bạn, phản hồi cho các bình luận, và bình luận trên các món mà bạn có tương tác',
                            style: context.typographies.body.withColor(
                                context.colors.primary.withOpacity(0.8))),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Switch(
                    value: true,
                    onChanged: (value) {},
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const DividerLine(),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ai đó bắt đầu theo dõi bạn', style: context.typographies.bodyBold),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                            'Thông báo khi có người bắt đầu theo dõi bạn',
                            style: context.typographies.body.withColor(
                                context.colors.primary.withOpacity(0.8))),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Switch(
                    value: true,
                    onChanged: (value) {},
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const DividerLine(),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Khi có công thức mới', style: context.typographies.bodyBold),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                            'Thông báo khi có công thức mới được đăng tải bởi những người mà bạn đã theo dõi',
                            style: context.typographies.body.withColor(
                                context.colors.primary.withOpacity(0.8))),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Switch(
                    value: true,
                    onChanged: (value) {},
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const DividerLine(),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tương tác với món của bạn', style: context.typographies.bodyBold),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                            'Thông báo khi có những bình luận, yêu thích, lưu món ăn của bạn',
                            style: context.typographies.body.withColor(
                                context.colors.primary.withOpacity(0.8))),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Switch(
                    value: true,
                    onChanged: (value) {},
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const DividerLine(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
