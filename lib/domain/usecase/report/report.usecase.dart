

import 'package:injectable/injectable.dart';
import 'package:uq_system_app/core/bases/usecases/base_use_case.dart';
import 'package:uq_system_app/data/models/report/report.request.dart';

import '../../repositories/report.repository.dart';

@injectable
class CreateReportUseCase extends UseCase<void, ReportRequest>{
  final ReportRepository _reportRepository;

  CreateReportUseCase(this._reportRepository);



  @override
  Future<void> call(ReportRequest params) {
    return _reportRepository.createReport(params);
  }
}