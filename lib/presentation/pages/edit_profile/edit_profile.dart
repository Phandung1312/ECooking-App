

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/domain/entities/member_details.dart';
import 'package:uq_system_app/presentation/pages/edit_profile/edit_profile_bloc.dart';
import 'package:uq_system_app/presentation/pages/edit_profile/edit_profile_selector.dart';

import '../../../domain/entities/enum/enum.dart';
import 'edit_profile_event.dart';
import 'edit_profile_state.dart';

@RoutePage()
class EditProfilePage extends StatefulWidget {
  final MemberDetails profile;

  const EditProfilePage({required this.profile});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final EditProfileBloc _bloc = getIt.get<EditProfileBloc>();
  String displayName = '';
  String username = '';

  @override
  void initState() {
    super.initState();
    _bloc.add(EditProfileEvent.load(profile: widget.profile));
    setState(() {
      displayName = widget.profile.displayName;
      username = widget.profile.username;
    });
  }

  @override
  void dispose() {
    _bloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child:  MultiBlocListener(
        listeners: [
          BlocListener<EditProfileBloc, EditProfileState>(
            listener: (context, state) {
              if (state.status == EditProfileStatus.success) {
                Fluttertoast.showToast(
                    msg: 'Cập nhật thành công',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: context.colors.background,
                    textColor: context.colors.primary,
                    fontSize: 16.0);
                context.router.pop(true);
              }
              if (state.status == EditProfileStatus.failure) {
                Fluttertoast.showToast(
                    msg: 'Đã có lỗi xảy ra, vui lòng thử lại sau',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: context.colors.background,
                    textColor: context.colors.primary,
                    fontSize: 16.0);
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon:  Icon(Icons.arrow_back, color: context.colors.primary,),
              onPressed: () {
                context.router.pop();
              },
            ),
            actions: [
              EditProfileSelector(
                selector: (state) => state.isDataValid,
                builder: (data) => ElevatedButton(
                  onPressed: data ? () {
                    _bloc.add(const EditProfileEvent.submit());
                  } : null,
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    backgroundColor: context.colors.secondary.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // maximumSize: Size(100, 50),
                  ),
                  child: Text(
                    'Cập nhật',
                    style:
                        context.typographies.caption1Bold.withColor(Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAvatar(),
                  const SizedBox(
                    height: 30,
                  ),
                  Text('Tên', style: context.typographies.body.withColor(context.colors.hint)),
                  const SizedBox(
                    height: 10,
                  ),
                  EditProfileSelector(
                    selector: (state) => state.accountRequest.displayName,
                    builder: (data) {
                      var controller = TextEditingController();
                      controller.text = data ?? "";
                      controller.selection = TextSelection.fromPosition(
                          TextPosition(offset: controller.text.length));
                      return TextField(
                        controller: controller,
                        onChanged: (value) {
                          _bloc.add(EditProfileEvent.updateProfile(
                            accountRequest: _bloc.state.accountRequest.copyWith(displayName: value),
                          ));
                        },
                        style: context.typographies.body,
                        decoration: InputDecoration(
                          counter: const SizedBox.shrink(),
                          hintText: 'Tên: Nguyễn Văn A',
                          hintStyle: context.typographies.body
                              .copyWith(color: context.colors.hint),
                        ),
                      );
                    }
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Địa chỉ', style: context.typographies.body.withColor(context.colors.hint)),
                  const SizedBox(
                    height: 10,
                  ),
                  EditProfileSelector(
                      selector: (state) => state.accountRequest.address,
                      builder: (data) {
                        var controller = TextEditingController();
                        controller.text = data ?? "";
                        controller.selection = TextSelection.fromPosition(
                            TextPosition(offset: controller.text.length));
                        return TextField(
                          controller: controller,
                          onChanged: (value) {
                            _bloc.add(EditProfileEvent.updateProfile(
                              accountRequest: _bloc.state.accountRequest.copyWith(address: value),
                            ));
                          },
                          style: context.typographies.body,
                          decoration: InputDecoration(
                            counter: const SizedBox.shrink(),
                            hintText: '82 Nguyễn Lương Bằng, Đống Đa, Hà Nội',
                            hintStyle: context.typographies.body
                                .copyWith(color: context.colors.hint),
                          ),
                        );
                      }
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Tiểu sử', style: context.typographies.body.withColor(context.colors.hint)),
                  const SizedBox(
                    height: 10,
                  ),
                  EditProfileSelector(
                      selector: (state) => state.accountRequest.story,
                      builder: (data) {
                        var controller = TextEditingController();
                        controller.text = data ?? "";
                        controller.selection = TextSelection.fromPosition(
                            TextPosition(offset: controller.text.length));
                        return TextField(
                          controller: controller,
                          onChanged: (value) {
                            _bloc.add(EditProfileEvent.updateProfile(
                              accountRequest: _bloc.state.accountRequest.copyWith(story: value),
                            ));
                          },
                          style: context.typographies.body,
                          minLines: 2,
                          maxLines: 5,
                          decoration: InputDecoration(
                            counter: const SizedBox.shrink(),
                            hintText: 'Vài dòng về bản thân bạn và đam mê nấu nướng của bạn',
                            hintStyle: context.typographies.body
                                .copyWith(color: context.colors.hint),
                          ),
                        );
                      }
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Row(
            children: [
              EditProfileSelector(
                selector: (state) => state.accountRequest,
                builder: (data) {
                  return GestureDetector(
                    onTap: () async{
                      final returnedImage = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (returnedImage == null) return;
                      _bloc.add(EditProfileEvent.upLoadImage(File(returnedImage.path)));
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipOval(
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.2),
                              BlendMode.darken,
                            ),
                            child: CircleAvatar(
                              backgroundImage:
                                  data.avatarUrl != null ? NetworkImage(data.avatarUrl!) : null,
                              backgroundColor: context.colors.hint,
                              radius: 40,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white.withOpacity(0.8),
                          size: 35,)
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(
                width: 20
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(displayName, style: context.typographies.bodyBold),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('@$username', style: context.typographies.body.withColor(context.colors.hint)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
