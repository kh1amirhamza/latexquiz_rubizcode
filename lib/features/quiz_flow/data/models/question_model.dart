import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_model.freezed.dart';
part 'question_model.g.dart';

@freezed
abstract class QuestionModel with _$QuestionModel {
  factory QuestionModel({
    required String question,
    required List<String> options,
     @JsonKey(name: 'answer_index') 
    required int answerIndex,
  }) = _QuestionModel;

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);
}
