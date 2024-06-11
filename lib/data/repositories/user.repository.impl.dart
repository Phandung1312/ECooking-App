import 'package:injectable/injectable.dart';
import 'package:uq_system_app/data/models/account/account.request.dart';
import 'package:uq_system_app/domain/entities/member.dart';
import 'package:uq_system_app/domain/entities/member_details.dart';
import 'package:uq_system_app/domain/entities/params/common_paginate.params.dart';
import 'package:uq_system_app/domain/entities/params/follow.params.dart';

import '../../domain/repositories/user.repository.dart';
import '../sources/network/network.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final NetworkDataSource _networkDataSource;

  UserRepositoryImpl(this._networkDataSource);

  @override
  Future<List<Member>> getTopMembers(CommonPaginateParams params) async {
    var result =
        await _networkDataSource.getTopMembers(params.page, params.perPage);
    return result.data.map((e) => e.mapToEntity()).toList();
  }

  @override
  Future<MemberDetails> getMemberDetails(int id) async {
    var result = await _networkDataSource.getUser(id);
    return result.data.mapToEntity();
  }

  @override
  Future<List<Member>> getFollowers(CommonPaginateParams params) async{
    var result = await _networkDataSource.getFollowers(params.id,params.page, params.perPage);
    return result.data.map((e) => e.mapToEntity()).toList();
  }

  @override
  Future<List<Member>> getFollowings(CommonPaginateParams params) async{
    var result = await _networkDataSource.getFollowings(params.id,params.page, params.perPage);
    return result.data.map((e) => e.mapToEntity()).toList();
  }

  @override
  Future<void> updateFollow(FollowParams params) async{
     await _networkDataSource.updateFollow(params);
  }

  @override
  Future<void> updateProfile(AccountRequest accountRequest) async{
    await _networkDataSource.updateUser(accountRequest.id ?? 0,accountRequest);
  }
}
