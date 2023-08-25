import 'dart:convert';

import '../pkg/logger/logger.dart';
import '../pkg/user/user.dart';
import 'expenses.dart';
import 'model.dart';
import 'package:http/http.dart' as http;

abstract class IExpenseRepository {
  Future<List<CostProject>> getCostProjectsByUser(UserId user);
  Future<CostProject?> getCostProjectById(String id);
  Future addCostToProject(String projectId, Transaction element);
  Future<CostProject> addnewProject(CostProject project);
}

final class Config {
  String baseUrl;

  Config(this.baseUrl);
}

class ExpenseRepository implements IExpenseRepository {
  final Config config;

  ExpenseRepository(this.config);

  @override
  Future<List<CostProject>> getCostProjectsByUser(UserId user) async {
    var path = Uri.http(config.baseUrl, 'api/v1.0/projects',
        GetProjectsQueryParams(user).toQuery());

    var response = await http.get(path);
    List<dynamic> decodedResponse = jsonDecode(response.body);

    var costProjectList = decodedResponse.map((p) => CostProject.fromJson(p));

    return costProjectList.toList();
  }

  @override
  Future<CostProject?> getCostProjectById(String id) async {
    log.info("get Project $id");
    var path = Uri.http(config.baseUrl, 'api/v1.0/projects/$id');

    var response = await http.get(path);
    var decodedResponse = jsonDecode(response.body);
    var costProject = CostProject.fromJson(decodedResponse);

    return costProject;
  }

  @override
  Future addCostToProject(String projectId, Transaction element) async {
    var path =
        Uri.http(config.baseUrl, 'api/v1.0/projects/$projectId/transactions');

    final _ = await http.post(path, body: jsonEncode(element));

    return;
  }

  @override
  Future<CostProject> addnewProject(CostProject project) async {
    var path = Uri.https(config.baseUrl, 'api/v1.0/projects');

    final response = await http.post(path, body: jsonEncode(project));

    var decodedResponse = jsonDecode(response.body);
    var costProject = CostProject.fromJson(decodedResponse);
    return costProject;
  }
}
