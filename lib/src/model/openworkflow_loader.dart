import 'dart:convert';
import 'dart:io';
import '../../openworkflow_dart.dart';

class OpenWorkflowLoader {

  Future<OpenWorkflow> load(String jsonString) async {
    // Map<String, dynamic> openAPIMap = jsonDecode(jsonString);
    // componentsJson = openAPIMap["components"];
    // if (componentsJson != null) {
    //   schemasJson = componentsJson!["schemas"];
    //   if (schemasJson != null) {
    //     SchemasSingleton.initInstance(schemasJson!);
    //   }
    //   ComponentsSingleton.initInstance(componentsJson!);
    // }
    // OpenAPI openAPI = OpenAPI.fromJson(openAPIMap);
    Map<String, dynamic> openWorkflowMap = jsonDecode(jsonString);
    OpenWorkflow openWorkflow = OpenWorkflow.fromJson(openWorkflowMap);
    return openWorkflow;
  }

  Future<OpenWorkflow> loadFromFile(String jsonPath) async {
    File file = File(jsonPath);
    String jsonString = await file.readAsString();
    return load(jsonString);
  }
}