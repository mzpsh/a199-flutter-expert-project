class Arepository {
  Future<String> aCall() async {
    return 'hehe';
  }
}

class AUsecase {
  final Arepository repository;
  AUsecase(this.repository);

  Future<String> execute() {
    return repository.aCall();
  }
}

// class MockArepository extends Mock
void main() async {
  final repository = Arepository();
  final usecase = AUsecase(repository);
  print(await usecase.execute());
}
