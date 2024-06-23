

import 'package:injectable/injectable.dart';
import 'package:uq_system_app/data/models/report/report.request.dart';
import 'package:uq_system_app/data/sources/network/network.dart';
import 'package:uq_system_app/domain/repositories/report.repository.dart';

@LazySingleton(as: ReportRepository)
class ReportRepositoryImpl extends ReportRepository{
  final NetworkDataSource _networkDataSource;
   ReportRepositoryImpl(this._networkDataSource);
  @override
  Future<void> createReport(ReportRequest reportRequest) async{
    await _networkDataSource.createReport(reportRequest);
  }

}