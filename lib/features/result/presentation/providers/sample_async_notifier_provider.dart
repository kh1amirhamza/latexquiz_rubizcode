// import 'dart:async';

// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:lifeintheuk/core/common/models/demo_model.dart';
// import 'package:lifeintheuk/core/network/api_response.dart';
// import 'package:lifeintheuk/features/sample/data/repositories_impl/sample_repository_impl.dart';

// class SampleAsyncNotifier extends AsyncNotifier<ApiResponse<DemoModel>?> {
//   @override
//   Future<ApiResponse<DemoModel>?> build() async {
//     return null;
//   }

//   Future<void> demo({required String url}) async {
//     state = const AsyncLoading();

//     state = await AsyncValue.guard(() async {
//       final result = await ref.read(sampleRepositoryProvider).demo('data');
//       return result.fold((error) => throw error, (response) => response);
//     });
//   }
// }

// final decryptDeepLinkNp =
//     AsyncNotifierProvider<SampleAsyncNotifier, ApiResponse<DemoModel>?>(
//       SampleAsyncNotifier.new,
//     );
