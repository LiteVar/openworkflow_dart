import 'package:opentool_dart/opentool_dart.dart';
import 'system_util.dart';

class SystemDriver extends OpenToolDriver {
  SystemDriver(super.openTool);

  @override
  Future<ToolReturn> call(FunctionCall functionCall) async {
    if(functionCall.name == "sleep") {
      int milliseconds = functionCall.parameters["milliseconds"];
      await sleep(milliseconds: milliseconds);
      return ToolReturn(id: functionCall.id, result: {});
    } else {
      return ToolReturn(id: functionCall.id, result: {"error": "Not Support function"});
    }
  }
}