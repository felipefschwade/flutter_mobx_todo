import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {

  _LoginStore();

  @observable
  String email = "";

  @action
  void setEmail(value) => email = value;

  @observable
  String senha = "";

  @action
  void setSenha(value) => senha = value;

  @computed
  bool get formValid => senha.isNotEmpty && senha.length > 6 && email.isNotEmpty && email.length > 6;

}