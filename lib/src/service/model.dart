class OperationType {
  static String FUNCTION_CALL = "functionCall"; // FunctionCall
  static String TOOL_RETURN = "toolReturn"; // ToolReturn
  static String EXCEPTION = "exception";  // ToolReturn
  static String FINISH = "finish";  // ""
}

class OperationMessage {
  String operationType;
  dynamic message;
  late DateTime createTime;
  OperationMessage(this.operationType, this.message) {
    createTime = DateTime.now();
  }

  Map<String, dynamic> toJson() {
    return {
      'operationType': operationType,
      'message': message,
      'createTime': createTime.toIso8601String()
    };
  }
}