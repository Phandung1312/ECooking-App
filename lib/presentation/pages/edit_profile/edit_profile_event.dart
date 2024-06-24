import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/data/models/account/account.request.dart';
import 'package:uq_system_app/domain/entities/member_details.dart';

part 'edit_profile_event.freezed.dart';

@freezed
class EditProfileEvent with _$EditProfileEvent {
  const factory EditProfileEvent.errorOccurred([BaseException? error]) = EditProfileErrorOccurred;
  const factory EditProfileEvent.upLoadImage(File file) = EditProfileUploadImage;
  const factory EditProfileEvent.load({required MemberDetails profile}) = EditProfileLoad;
  const factory EditProfileEvent.updateProfile({required AccountRequest accountRequest}) = EditProfileUpdateProfile;
  const factory EditProfileEvent.submit() = EditProfileSubmit;
}
