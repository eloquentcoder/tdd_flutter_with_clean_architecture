import 'package:tdd_app/core/errors/exceptions.dart';
import 'package:tdd_app/core/platform/network_info.dart';
import 'package:tdd_app/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:tdd_app/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:tdd_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd_app/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl extends NumberTriviaRepository {
  final NetworkInfo networkInfo;
  final NumberTriviaRemoteDatasource remoteDatasource;
  final NumberTriviaLocalDatasource localDatasource;

  NumberTriviaRepositoryImpl(
      {required this.networkInfo,
      required this.remoteDatasource,
      required this.localDatasource});

  @override
  Future<Either<Failure, NumberTrivia>> getNumberTriviaById(int number) async {
    networkInfo.isConnected;
    try {
      final remoteTrivia = await remoteDatasource.getNumberTriviaById(number);
      localDatasource.cacheNumberTrivia(remoteTrivia);
      return Right(remoteTrivia);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    networkInfo.isConnected;
    final remoteTrivia = await remoteDatasource.getRandomNumberTrivia();
    localDatasource.cacheNumberTrivia(remoteTrivia);
    return Right(remoteTrivia);
  }
}
