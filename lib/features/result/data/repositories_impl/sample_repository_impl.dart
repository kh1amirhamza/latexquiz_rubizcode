// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:lifeintheuk/core/common/models/demo_model.dart';
// import 'package:lifeintheuk/core/network/api_response.dart';
// import 'package:lifeintheuk/features/sample/data/datasources/sample_remote_datasource.dart';
// import 'package:lifeintheuk/features/sample/domain/repositories/sample_repository.dart';

// class SampleRepositoryImpl implements SampleRepository {
//   final SampleRemoteDatasource remoteDataSource;

//   SampleRepositoryImpl(this.remoteDataSource);

//   @override
//   Future<Either<DioException, ApiResponse<DemoModel>>> demo(String test) async {
//     return remoteDataSource.demo(test);
//   }

// }

// final sampleRepositoryProvider = Provider<SampleRepository>(
//   (ref) => SampleRepositoryImpl(ref.read(sampleRemoteDataSourceProvider)),
// );
