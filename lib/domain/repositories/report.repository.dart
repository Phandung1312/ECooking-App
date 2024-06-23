
import 'package:uq_system_app/data/models/report/report.request.dart';

abstract class ReportRepository{
  Future<void> createReport(ReportRequest reportRequest);
}
