// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_workflow.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenWorkflow _$OpenWorkflowFromJson(Map<String, dynamic> json) => OpenWorkflow(
      openworkflow: json['openworkflow'] as String,
      info: Info.fromJson(json['info'] as Map<String, dynamic>),
      workflow: (json['workflow'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, FunctionItem.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$OpenWorkflowToJson(OpenWorkflow instance) =>
    <String, dynamic>{
      'openworkflow': instance.openworkflow,
      'info': instance.info,
      'workflow': instance.workflow,
    };
