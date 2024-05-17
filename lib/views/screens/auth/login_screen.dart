import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/auth_bloc.dart';
import '../../../blocs/password_bloc.dart';
import '../../../extensions/extensions.dart';
import '../../../utils/enums.dart';
import '../../../utils/keys.dart';
import '../../../utils/methods.dart';
import '../../../utils/values.dart';
import '../../widgets/common/bottom_text_widget.dart';
import '../../widgets/common/circular_loader.dart';
import '../../widgets/common/custom_back_button.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/my_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Widget loginButtonBuilder(BuildContext context, bool flag) {
    final am = context.getAuthBloc(true);
    return Center(
        child: flag
            ? CustomButton(
                type: 'outlined'.buttonType,
                child:
                    const CircularLoader(loaderType: LoaderType.fadingCircle))
            : MyButton(onPressed: am.login, label: context.loc.login));
  }

  Widget bottomTextBuilder(BuildContext context, bool flag) {
    final am = context.getAuthBloc(true);
    return BottomTextWidget(
        text1: 'No account? ',
        onTap: am.gotoRegisterScreen,
        text2: '${context.loc.register} here');
  }

  Widget userNameEmailBuilder(BuildContext context, bool flag) {
    final am = context.getAuthBloc(true);
    return CustomTextField(
        isFormField: true,
        cursorColor: shades.kWhite,
        onSaved: am.onNameOrEmailSaved,
        style: css.textFieldInputStyle,
        validator: context.validateNameOrEmail,
        material: const InputDecoration(hintText: 'Enter Username/Email'));
  }

  Widget passwordBuilder(BuildContext context, bool hideText) {
    final passwordBloc = context.getPasswordBloc(true),
        authBloc = context.getAuthBloc(true);
    return CustomTextField(
        isFormField: true,
        obscureText: hideText,
        cursorColor: shades.kWhite,
        style: css.textFieldInputStyle,
        onSaved: authBloc.onPasswordSaved,
        validator: context.validatePassword,
        material: InputDecoration(
            hintText: 'Enter Password',
            suffixIcon: ShaderMask(
                shaderCallback: getShader,
                blendMode: BlendMode.srcIn,
                child: GestureDetector(
                    onTap: passwordBloc.hideShowPassword,
                    child: (hideText ? Icons.visibility_off : Icons.visibility)
                        .iconBuilder()))));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    const bb = CustomBackButton();
    return SafeArea(
      child: Scaffold(
          body: Container(
              width: context.width,
              decoration: css.screenBackground1,
              height: context.height * (context.isKeyBoardOpen ? 2 : 1),
              padding: EdgeInsets.symmetric(horizontal: context.width / 32),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    context.isKeyBoardOpen
                        ? const Expanded(child: bb)
                        : const Flexible(child: bb),
                    Expanded(
                        flex: context.isKeyBoardOpen ? 4 : 2,
                        child: Form(
                            key: loginFormKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Flexible(
                                      flex: context.isKeyBoardOpen ? 2 : 1,
                                      child: context.loc.login.textWidget(
                                          style: css.authHeadingStyle)),
                                  Flexible(
                                      flex: context.isKeyBoardOpen ? 4 : 1,
                                      child: BlocBuilder<AuthBloc, bool>(
                                          builder: userNameEmailBuilder)),
                                  Flexible(
                                      flex: context.isKeyBoardOpen ? 4 : 1,
                                      child: BlocBuilder<PasswordBloc, bool>(
                                          builder: passwordBuilder)),
                                  Flexible(
                                      flex: context.isKeyBoardOpen ? 3 : 1,
                                      child: BlocBuilder<AuthBloc, bool>(
                                          builder: loginButtonBuilder)),
                                  Flexible(
                                      flex: context.isKeyBoardOpen ? 2 : 1,
                                      child: BlocBuilder<AuthBloc, bool>(
                                          builder: bottomTextBuilder))
                                ])))
                  ]))),
    );
  }
}
