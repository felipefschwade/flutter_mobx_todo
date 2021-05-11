import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {

  _LoginStore();

  @observable
  String email = "";

  @observable
  bool loading = false;

  @observable
  bool passwordVisible = false;

  @observable
  bool loggedIn = false;

  @observable
  String senha = "";

  @computed
  bool get formValid => senha.isNotEmpty && senha.length > 6 && email.isNotEmpty && email.length > 6;

  @action
  void setEmail(value) => email = value;

  @action
  void setSenha(value) => senha = value;

  @action
  void togglePasswordVisible() => passwordVisible = !passwordVisible;

  @action
  Future<void> login() async {
    loading = true;
    await Future.delayed(Duration(seconds: 2));
    loading = false;
    loggedIn = true;
  }

}