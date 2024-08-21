import 'package:json_annotation/json_annotation.dart';
import 'function_item.dart';
import 'info.dart';

part 'open_workflow.g.dart';

@JsonSerializable()
class OpenWorkflow {
  late String openworkflow;
  late Info info;
  late Map<String, FunctionItem> workflow;

  OpenWorkflow({required this.openworkflow, required this.info, required this.workflow});

  factory OpenWorkflow.fromJson(Map<String, dynamic> json) => _$OpenWorkflowFromJson(json);

  Map<String, dynamic> toJson() => _$OpenWorkflowToJson(this);
}