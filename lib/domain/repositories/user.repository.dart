

import 'package:uq_system_app/domain/entities/member.dart';
import 'package:uq_system_app/domain/entities/params/common_paginate.params.dart';

abstract class UserRepository {
  Future<List<Member>> getTopMembers(CommonPaginateParams params);
}