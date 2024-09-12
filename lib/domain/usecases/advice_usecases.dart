import 'package:dartz/dartz.dart';
import 'package:susra_task/domain/entities/advice_entity.dart';
import 'package:susra_task/domain/failures/failures.dart';
import 'package:susra_task/domain/repositories/advice_repo.dart';

class AdviceUseCases {
  AdviceUseCases({required this.adviceRepo});
  final AdviceRepo adviceRepo;

  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    return adviceRepo.getAdviceFromDatasource();
  }
}
