import 'dart:io';

import 'package:opentool_dart/opentool_dart.dart';
import '../system_tools/system_driver.dart';
import '../model/function_item.dart';
import '../model/open_workflow.dart';
import 'session.dart';
import 'model.dart';
import 'dispatcher.dart';
import 'extension.dart';

class WorkflowService {
  List<ToolDriver> toolDriverList = [];
  OpenWorkflow openWorkflow;
  late Dispatcher _dispatcher;
  Session session;

  WorkflowService(this.toolDriverList, this.openWorkflow, this.session){
    _dispatcher = Dispatcher(_listen);
  }

  /// for extends classes to override
  void check() {}
  
  Future<SystemDriver> _buildSystemDriver() async {
    String folder = "${Directory.current.path}${Platform.pathSeparator}lib${Platform.pathSeparator}json";
    String jsonFileName = "system_tools.json";
    String jsonPath = "$folder${Platform.pathSeparator}$jsonFileName";
    OpenTool systemTool = await OpenToolLoader().loadFromFile(jsonPath);
    return SystemDriver(systemTool);
  }

  Future<void> run() async {
    check();
    
    SystemDriver systemDriver = await _buildSystemDriver();
    toolDriverList.add(systemDriver);
    
    FunctionItem startFunctionItem = openWorkflow.workflow["start"]!;
    _dispatcher.dispatch(FunctionWrapper(id: "start", functionItem: startFunctionItem));
  }

  void stop() {
    _dispatcher.stop();
  }

  Future<void> _listen(FunctionWrapper functionWrapper) async {
    FunctionCall functionCall = FunctionCall(id: functionWrapper.id, name: functionWrapper.functionItem.function, parameters: functionWrapper.functionItem.arguments);
    FunctionCall parsedFunctionCall = _parse(functionCall);
    OperationMessage operationMessage = OperationMessage(OperationType.FUNCTION_CALL, parsedFunctionCall);
    session.addMessage(operationMessage);
    
    ToolDriver toolDriver = toolDriverList.firstWhere((toolDriver)=> toolDriver.hasFunction(functionCall.name));
    
    ToolReturn toolReturn = await toolDriver.call(parsedFunctionCall);

    if(functionWrapper.functionItem.results.containsStruct(toolReturn.result)) {
      OperationMessage operationMessage = OperationMessage(OperationType.TOOL_RETURN, toolReturn);
      session.addMessage(operationMessage);
      if(openWorkflow.workflow[functionWrapper.functionItem.next] != null) {
        FunctionItem nextFunctionItem = openWorkflow.workflow[functionWrapper.functionItem.next]!;
        _dispatcher.dispatch(FunctionWrapper(id: functionWrapper.functionItem.next, functionItem: nextFunctionItem));
      } else {
        OperationMessage operationMessage = OperationMessage(OperationType.FINISH, OperationType.FINISH.toUpperCase());
        session.addMessage(operationMessage);
      }
    } else {
      OperationMessage operationMessage = OperationMessage(OperationType.EXCEPTION, toolReturn);
      session.addMessage(operationMessage);
    }
  }

  FunctionCall _parse(FunctionCall functionCall) {
    Map<String, dynamic> newParameters = _replaceVariate(functionCall.parameters);
    return FunctionCall(
      id: functionCall.id,
      name: functionCall.name,
      parameters: newParameters
    );
  }

  Map<String, dynamic> _replaceVariate(Map<String, dynamic> map) {
    Map<String, dynamic> newMap = Map<String, dynamic>.from(map);
    newMap.forEach((key, value) {
      if (value is String && value.startsWith('#/')) {
        dynamic realValue = session.variateMap[value];
        newMap[key] = realValue;
      } else if (value is Map<String, dynamic>) {
        _replaceVariate(value);
      }
    });
    return newMap;
  }
}

