import 'package:opentool_dart/opentool_dart.dart';
import 'model.dart';

class Session {
  final List<void Function(OperationMessage)> _listenList = [];
  List<OperationMessage> operationMessageList = [];
  Map<String, dynamic> variateMap = {};

  String functionCallString = "arguments";
  String toolReturnString = "results";

  addMessage(OperationMessage operationMessage) {
    operationMessageList.add(operationMessage);
    String variateMapKey = "#";
    if(operationMessage.operationType == OperationType.FUNCTION_CALL) {
      FunctionCall functionCall = operationMessage.message as FunctionCall;
      variateMapKey = "$variateMapKey/${functionCall.id}/$functionCallString";
      functionCall.parameters.forEach((key, value) {
        String currVariateMapKey = "$variateMapKey/$key";
        variateMap[currVariateMapKey] = value;
      });
    } else if (operationMessage.operationType == OperationType.TOOL_RETURN) {
      ToolReturn toolReturn = operationMessage.message as ToolReturn;
      variateMapKey = "$variateMapKey/${toolReturn.id}/$toolReturnString";
      toolReturn.result.forEach((key, value) {
        String currVariateMapKey = "$variateMapKey/$key";
        variateMap[currVariateMapKey] = value;
      });
    }
    _broadcast(operationMessage);
  }

  addMessageListener(void Function(OperationMessage) listen) {
    _listenList.add(listen);
  }

  void _broadcast(OperationMessage operationMessage) {
    for(void Function(OperationMessage) listen in _listenList) {
      listen(operationMessage);
    }
  }
}