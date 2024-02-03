import 'package:conductor/conductor.dart';

class RepositoryResponse<R> {
  final R? data;

  RepositoryResponse({
    this.data,
  });
}

class Repository {
  // Make repository singleton
  static final Repository _instance = Repository._internal();
  factory Repository() {
    return _instance;
  }
  Repository._internal();

  Future<RepositoryResponse<T>> get<T extends BaseDataModel>(String id) async {
    return RepositoryResponse();
  }

  Future<RepositoryResponse<List<T>>> gets<T extends BaseDataModel>() async {
    return RepositoryResponse();
  }
}
