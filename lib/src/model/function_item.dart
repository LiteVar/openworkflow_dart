import 'package:json_annotation/json_annotation.dart';

part 'function_item.g.dart';

@JsonSerializable()
class FunctionItem {
  String function;
  String? description;
  Map<String, dynamic> arguments;
  Map<String, dynamic> results;
  String next;

  FunctionItem({required this.function, this.description, required this.arguments, required this.results, required this.next});

  factory FunctionItem.fromJson(Map<String, dynamic> json) => _$FunctionItemFromJson(json);

  Map<String, dynamic> toJson() => _$FunctionItemToJson(this);
}