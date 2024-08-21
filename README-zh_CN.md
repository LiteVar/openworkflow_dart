# openworkflow_dart

Workflow JSON规范解析器，带有执行service。

## 特性

- 加载OpenWorkflow的JSON文件，并转换成Dart对象。可见[OpenWorkflow规范](openworkflow-specification-cn.md)
- 可直接使用的WorkflowService，创建对象后可按JSON配置，按顺序、带传入参数调用OpenTool所含有的函数。
- 支持多ToolDriver，也即Workflow的JSON文件的function可以来自不同的OpenTool

## 用法

- JSON文件例子可见：`/example/openworkflow-crud-example.json`
- 对应调用的OpenTool和ToolDriver可见：`/example/custom_driver`
- 调用方法例子可见：`/example/openworkflow_dart_example.dart`

```dart
Future<void> main() async {
  ToolDriver mockDriver = await _buildToolDriver();
  OpenWorkflow openWorkflow = await _buildWorkflow();
  Session session = _buildSession();

  WorkflowService workflow = WorkflowService([mockDriver], openWorkflow, session);

  workflow.run();
}
```