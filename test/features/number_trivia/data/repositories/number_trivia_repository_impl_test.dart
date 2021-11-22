import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_app/core/errors/exceptions.dart';
import 'package:tdd_app/core/errors/failures.dart';
import 'package:tdd_app/core/platform/network_info.dart';
import 'package:tdd_app/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:tdd_app/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:tdd_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tdd_app/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:tdd_app/features/number_trivia/domain/entities/number_trivia.dart';

import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateMocks(
    [NumberTriviaRemoteDatasource, NumberTriviaLocalDatasource, NetworkInfo])
void main() {
  MockNumberTriviaLocalDatasource mockNumberTriviaLocalDatasource =
      MockNumberTriviaLocalDatasource();
  MockNumberTriviaRemoteDatasource mockNumberTriviaRemoteDatasource =
      MockNumberTriviaRemoteDatasource();
  MockNetworkInfo networkInfo = MockNetworkInfo();

  NumberTriviaRepositoryImpl repository = NumberTriviaRepositoryImpl(
    remoteDatasource: mockNumberTriviaRemoteDatasource,
    localDatasource: mockNumberTriviaLocalDatasource,
    networkInfo: networkInfo,
  );

  group('get number trivia', () {
    const testNumber = 1;
    const NumberTriviaModel testTriviaModel =
        NumberTriviaModel(number: testNumber, trivia: 'Test Trivia');
    const NumberTrivia testNumberTrivia = testTriviaModel;

    // test('is network connected', () async {
    //   when(networkInfo.isConnected).thenAnswer((_) async => true);
    //   // await repository.getNumberTriviaById(testNumber);
    //   verify(networkInfo.isConnected);
    // });

    group('device is offline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('', () => null);
    });

    group('device is online', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data source if connection to remote datasource is successful',
          () async {
        //arrange
        when(mockNumberTriviaRemoteDatasource.getNumberTriviaById(any))
            .thenAnswer((_) async => testTriviaModel);
        // act
        final result = await repository.getNumberTriviaById(testNumber);
        // assert
        verify(
            mockNumberTriviaRemoteDatasource.getNumberTriviaById(testNumber));
        expect(result, const Right(testNumberTrivia));
      });

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockNumberTriviaRemoteDatasource.getNumberTriviaById(testNumber))
              .thenAnswer((_) async => testTriviaModel);
          // act
          await repository.getNumberTriviaById(testNumber);
          // assert
          verify(
              mockNumberTriviaRemoteDatasource.getNumberTriviaById(testNumber));
          verify(mockNumberTriviaLocalDatasource
              .cacheNumberTrivia(testTriviaModel));
        },
      );

      test(
          'should return return server failure if connection to remote datasource is unsuccessful',
          () async {
        //arrange
        when(mockNumberTriviaRemoteDatasource.getNumberTriviaById(any))
            .thenThrow(ServerException());
        // act
        final result = await repository.getNumberTriviaById(testNumber);
        // assert
        verify(
            mockNumberTriviaRemoteDatasource.getNumberTriviaById(testNumber));
        verifyZeroInteractions(mockNumberTriviaLocalDatasource);
        expect(result, Left(ServerFailure()));
      });
    });
  });
}
