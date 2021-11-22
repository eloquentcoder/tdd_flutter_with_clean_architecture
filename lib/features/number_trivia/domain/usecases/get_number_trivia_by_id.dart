import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_app/core/errors/failures.dart';
import 'package:tdd_app/core/usecases/usecase.dart';
import 'package:tdd_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_app/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetNumberTriviaById implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository numberTriviaRepository;

  GetNumberTriviaById(this.numberTriviaRepository);
  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await numberTriviaRepository.getNumberTriviaById(params.number);
  }
}

class Params extends Equatable {
  final int number;

  const Params({required this.number});

  @override
  List<Object?> get props => [];
}
