# openworkflow_dart

Workflow JSON Specification Parser with Execution Service.

## Features

- Loads OpenWorkflow JSON files and converts them into Dart objects. See [OpenWorkflow Specification](openworkflow-specification-en.md)
- Provides a ready-to-use `WorkflowService` that, once instantiated, can invoke the functions contained in OpenTool in sequence and with input parameters, as configured in the JSON.
- Supports multiple ToolDrivers, meaning the functions in the Workflow JSON file can originate from different OpenTools.

## Usage

- Example JSON file: `/example/openworkflow-crud-example.json`
- The corresponding OpenTool and ToolDriver used in the example can be found at: `/example/custom_driver`
- Example of how to invoke: `/example/openworkflow_dart_example.dart`

```dart
Future<void> main() async {
  ToolDriver mockDriver = await _buildToolDriver();
  OpenWorkflow openWorkflow = await _buildWorkflow();
  Session session = _buildSession();

  WorkflowService workflow = WorkflowService([mockDriver], openWorkflow, session);

  workflow.run();
}
```
