import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mobx_todo/store/login_store.dart';
import 'package:flutter_mobx_todo/widgets/custom_icon_button.dart';
import 'package:flutter_mobx_todo/widgets/custom_text_field.dart';
import 'package:mobx/mobx.dart';

import 'list_screen.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  LoginStore loginStore = LoginStore();
  late ReactionDisposer disposer;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    disposer = reaction((_) => loginStore.loggedIn, (bool loggedIn) {
      if (loggedIn) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ListScreen()));
      }
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(32),
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 16,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Observer(builder: (_) {
                      return CustomTextField(
                        hint: 'E-mail',
                        prefix: Icon(Icons.account_circle),
                        textInputType: TextInputType.emailAddress,
                        onChanged: loginStore.setEmail,
                        enabled: !loginStore.loading,
                      );
                    }),
                    const SizedBox(height: 16,),
                    Observer(builder: (_) {
                      return CustomTextField(
                        hint: 'Senha',
                        prefix: Icon(Icons.lock),
                        obscure: !loginStore.passwordVisible,
                        onChanged: loginStore.setSenha,
                        enabled: !loginStore.loading,
                        suffix: CustomIconButton(
                          radius: 32,
                          iconData: !loginStore.passwordVisible ? Icons.visibility : Icons.visibility_off,
                          onTap: loginStore.togglePasswordVisible,
                        ),
                      );
                    }),
                    const SizedBox(height: 16,),
                    Observer(builder: (_) {
                      return SizedBox(
                        height: 44,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: loginStore.loading ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ) : Text('Login'),
                          color: Theme.of(context).primaryColor,
                          disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                          textColor: Colors.white,
                          onPressed: !loginStore.formValid || loginStore.loading ? null : (){
                            loginStore.login();
                            //
                          },
                        ),
                      );
                    })
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }
}
