final class GetProjectsQueryParams {
  String? user;
  GetProjectsQueryParams([this.user]);

  Map<String, String> toQuery() {
    var map = <String, String>{};

    if (user != null) {
      map["user"] = user!;
    }

    return map;
  }
}
