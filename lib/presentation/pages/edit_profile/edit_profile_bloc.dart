import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/data/models/account/account.request.dart';
import 'package:uq_system_app/presentation/pages/edit_profile/edit_profile_event.dart';
import 'package:uq_system_app/presentation/pages/edit_profile/edit_profile_state.dart';
import '../../../core/exceptions/exception.dart';
import '../../../domain/usecase/file/upload_image.usecase.dart';
import '../../../domain/usecase/user/update_profile.usecase.dart';
@injectable
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final UploadImageUseCase uploadImageUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  EditProfileBloc(this.uploadImageUseCase, this.updateProfileUseCase) : super(const EditProfileState()) {
    on<EditProfileErrorOccurred>(_onErrorOccurred);
    on<EditProfileUploadImage>(_onUploadImage);
    on<EditProfileLoad>(_onLoad);
    on<EditProfileUpdateProfile>(_onUpdateProfile);
    on<EditProfileSubmit>(_onSubmit);
  }
  FutureOr<void> _onLoad(
    EditProfileLoad event,
    Emitter<EditProfileState> emit,
  ) {
    var account = AccountRequest(
      id : event.profile.id,
      displayName: event.profile.displayName,
      avatarUrl: event.profile.avatarUrl,
      address: event.profile.address,
      story: event.profile.story,
    );
    emit(state.copyWith(
      accountRequest: account,
      status: EditProfileStatus.updated,
      isDataValid: _validateData(account),
    ));
  }
  FutureOr<void> _onUploadImage(
    EditProfileUploadImage event,
    Emitter<EditProfileState> emit,
  ) async{
    emit(state.copyWith(
      status: EditProfileStatus.loading,
    ));
    var result = await uploadImageUseCase(event.file);
    emit(state.copyWith(
      accountRequest: state.accountRequest.copyWith(avatarUrl: result),
      status: EditProfileStatus.updated,
    ));
  }
  FutureOr<void> _onUpdateProfile(
    EditProfileUpdateProfile event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(
      accountRequest: event.accountRequest,
      status: EditProfileStatus.updated,
      isDataValid: _validateData(event.accountRequest),
    ));
  }
  FutureOr<void> _onSubmit(
    EditProfileSubmit event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(
      status: EditProfileStatus.loading,
    ));
    EasyLoading.show();
    await updateProfileUseCase(state.accountRequest);
    EasyLoading.dismiss();
    emit(state.copyWith(
      status: EditProfileStatus.success,
    ));
  }

  bool _validateData(AccountRequest accountRequest) {
    return accountRequest.displayName != null &&
        accountRequest.displayName!.isNotEmpty;
  }
  @override
  void onError(Object error, StackTrace stackTrace) {
    if(EasyLoading.isShow) EasyLoading.dismiss();
    add(EditProfileErrorOccurred(BaseException.from(error)));
    super.onError(error, stackTrace);
  }

  FutureOr<void> _onErrorOccurred(
    EditProfileErrorOccurred event,
    Emitter<EditProfileState> emit,
  ) {
    emit(state.copyWith(
      status: EditProfileStatus.failure,
    ));
  }
}
