import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_app/core/usecases/usecase.dart';
import 'package:tdd_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_app/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:tdd_app/features/number_trivia/domain/usecases/get_number_trivia_by_id.dart';
import 'package:tdd_app/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

import 'get_number_trivia_test.mocks.dart';

@GenerateMocks([NumberTriviaRepository])
void main() {
  MockNumberTriviaRepository mockNumberTriviaRepository =
      MockNumberTriviaRepository();
  GetNumberTriviaById byIdUsecase =
      GetNumberTriviaById(mockNumberTriviaRepository);
  GetRandomNumberTrivia randomUseCase =
      GetRandomNumberTrivia(mockNumberTriviaRepository);
  const tId = 1;
  const tTrivia = NumberTrivia(trivia: 'Test Trivia', number: tId);

  group('get number trivia ', () {
    test('get number trivia by id search', () async {
      when(mockNumberTriviaRepository.getNumberTriviaById(tId))
          .thenAnswer((_) async => const Right(tTrivia));

      final result = await byIdUsecase(const Params(number: tId));
      expect(result, const Right(tTrivia));
      verify(mockNumberTriviaRepository.getNumberTriviaById(tId));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    });

    test('get number trivia randomly', () async {
      when(mockNumberTriviaRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => const Right(tTrivia));

      final result = await randomUseCase(NoParams());
      expect(result, const Right(tTrivia));
      verify(mockNumberTriviaRepository.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    });
  });
}
