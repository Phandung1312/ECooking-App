import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:uq_system_app/core/bases/usecases/base_use_case.dart';

import '../../repositories/file.repository.dart';

@injectable
class UploadImageUseCase extends UseCase<String, File> {
  final FileRepository _fileRepository;

  UploadImageUseCase(this._fileRepository);

  @override
  Future<String> call(File params) {
    return _fileRepository.uploadImage(params);
  }
}
