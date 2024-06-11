

import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:uq_system_app/data/sources/network/network.dart';
import 'package:uq_system_app/domain/repositories/file.repository.dart';

@LazySingleton(as: FileRepository)
class FileRepositoryImpl extends FileRepository{
  final NetworkDataSource _networkDataSource;
   FileRepositoryImpl(this._networkDataSource);
  @override
  Future<String> uploadImage(File file) async{
    var result =  await  _networkDataSource.uploadImage(file);
    return result.data;
  }

  @override
  Future<String> uploadVideo(File file) async{
    var result = await  _networkDataSource.uploadVideo(file);
    return result.data;
  }

}