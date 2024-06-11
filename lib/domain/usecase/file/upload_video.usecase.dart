import 'dart:io';

import 'package:injectable/injectable.dart';

import '../../../core/bases/usecases/base_use_case.dart';
import '../../repositories/file.repository.dart';

@injectable
class UploadVideoUseCase extends UseCase<String, File> {
  final FileRepository _fileRepository;

  UploadVideoUseCase(this._fileRepository);

  @override
  Future<String> call(File params) {
    return _fileRepository.uploadVideo(params);
  }
}
