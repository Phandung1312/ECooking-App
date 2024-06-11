

import 'package:uq_system_app/data/models/account/account.request.dart';
import 'package:uq_system_app/domain/entities/member.dart';
import 'package:uq_system_app/domain/entities/params/common_paginate.params.dart';
import 'package:uq_system_app/domain/entities/params/follow.params.dart';

import '../entities/member_details.dart';

abstract class UserRepository {
  Future<List<Member>> getTopMembers(CommonPaginateParams params);
  Future<MemberDetails> getMemberDetails(int id);
  Future<List<Member>> getFollowers(CommonPaginateParams params);
  Future<List<Member>> getFollowings(CommonPaginateParams params);
  Future<void> updateFollow(FollowParams params);
  Future<void> updateProfile(AccountRequest accountRequest);
}