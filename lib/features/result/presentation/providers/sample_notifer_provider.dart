import 'package:flutter_riverpod/flutter_riverpod.dart';

class SampleNotifier extends StateNotifier<int?> {
  SampleNotifier() : super(null);

  void update(int id) {
    state = id;
  }

  void resetSubCategoryId() {
    state = null;
  }
}

final sampleNotifierProvider = StateNotifierProvider<SampleNotifier, int?>(
  (ref) => SampleNotifier(),
);
