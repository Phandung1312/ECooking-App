

import 'package:injectable/injectable.dart';
import 'package:uq_system_app/domain/entities/member.dart';
import 'package:uq_system_app/domain/entities/params/common_paginate.params.dart';

import '../../domain/repositories/user.repository.dart';
import '../sources/network/network.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository{
  final NetworkDataSource _networkDataSource;
  UserRepositoryImpl(this._networkDataSource);
  @override
  Future<List<Member>> getTopMembers(CommonPaginateParams params) async {
    var result = await _networkDataSource.getTopMembers(params.page, params.perPage);
    return result.data.map((e) => e.mapToEntity()).toList();
  }

}