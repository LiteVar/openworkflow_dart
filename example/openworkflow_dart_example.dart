import 'dart:convert';
import 'dart:io';
import 'package:opentool_dart/opentool_dart.dart';
import 'package:openworkflow_dart/openworkflow_dart.dart';
import 'custom_driver/mock_driver.dart';

Future<void> main() async {
  ToolDriver mockDriver = await _buildToolDriver();
  OpenWorkflow openWorkflow = await _buildWorkflow();
  Session session = _buildSession();

  WorkflowService workflow = WorkflowService([mockDriver], openWorkflow, session);

  workflow.run();
}

Future<ToolDriver> _buildToolDriver() async {
  String folder = "${Directory.current.path}${Platform.pathSeparator}example";
  String jsonFileName = "mock_tool.json";
  String jsonPath = "$folder${Platform.pathSeparator}custom_driver${Platform.pathSeparator}$jsonFileName";
  OpenTool openTool = await OpenToolLoader().loadFromFile(jsonPath);
  MockDriver mockDriver = MockDriver(openTool);
  return mockDriver;
}

Future<OpenWorkflow> _buildWorkflow() async {
  String folder = "${Directory.current.path}${Platform.pathSeparator}example";
  String workflowJson = "openworkflow-crud-example.json";
  OpenWorkflow openWorkflow = await OpenWorkflowLoader().loadFromFile("$folder${Platform.pathSeparator}json${Platform.pathSeparator}$workflowJson");
  return openWorkflow;
}

Session _buildSession() {
  Session session = Session();
  session.addMessageListener(listen);
  return session;
}

void listen(OperationMessage operationMessage) {
  print(jsonEncode(operationMessage.toJson())
      .replaceAll(OperationType.FUNCTION_CALL, "👉${OperationType.FUNCTION_CALL}")
      .replaceAll(OperationType.TOOL_RETURN, "⬅️${OperationType.TOOL_RETURN}")
      .replaceAll(OperationType.FINISH, "✅${OperationType.FINISH}")
  );
}