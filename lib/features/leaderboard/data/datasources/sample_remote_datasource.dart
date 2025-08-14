// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:lifeintheuk/core/common/models/demo_model.dart';
// import 'package:lifeintheuk/core/network/api_providers.dart';
// import 'package:lifeintheuk/core/network/api_response.dart';
// import 'package:lifeintheuk/core/network/api_service.dart';

// abstract class SampleRemoteDatasource {
//   Future<Either<DioException, ApiResponse<DemoModel>>> demo(String test);
// }

// class TaskRemoteDatasourceImpl implements SampleRemoteDatasource {
//   final ApiService apiService;

//   TaskRemoteDatasourceImpl(this.apiService);

//   @override
//   Future<Either<DioException, ApiResponse<DemoModel>>> demo(String test) async {
//     final result = await apiService.getRequestLatest("/endpoint");
//     return result.map((res) => ApiResponse.mapSingle(res, DemoModel.fromJson));
//   }
// }

// final sampleRemoteDataSourceProvider = Provider<SampleRemoteDatasource>(
//   (ref) => TaskRemoteDatasourceImpl(ref.read(apiServiceProvider)),
// );
