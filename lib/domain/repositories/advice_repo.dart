import 'package:dartz/dartz.dart';
import 'package:susra_task/domain/entities/advice_entity.dart';
import '../failures/failures.dart';

abstract class AdviceRepo {
  Future<Either<Failure, AdviceEntity>> getAdviceFromDatasource();
}
