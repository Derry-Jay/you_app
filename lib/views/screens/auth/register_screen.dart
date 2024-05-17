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

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  Widget registerButtonBuilder(BuildContext context, bool flag) {
    final am = context.getAuthBloc(true);
    return Center(
        child: flag
            ? CustomButton(
                type: 'outlined'.buttonType,
                child:
                    const CircularLoader(loaderType: LoaderType.fadingCircle))
            : MyButton(onPressed: am.register, label: context.loc.register));
  }

  Widget passwordBuilder(BuildContext context, bool hideText) {
    final passwordBloc = context.getPasswordBloc(true);
    return CustomTextField(
        controller: pwc,
        isFormField: true,
        obscureText: hideText,
        cursorColor: shades.kWhite,
        style: css.textFieldInputStyle,
        validator: context.validatePassword,
        textInputAction: TextInputAction.next,
        material: InputDecoration(
            hintText: 'Create Password',
            suffixIcon: ShaderMask(
                shaderCallback: getShader,
                blendMode: BlendMode.srcIn,
                child: GestureDetector(
                    onTap: passwordBloc.hideShowPassword,
                    child: (hideText ? Icons.visibility_off : Icons.visibility)
                        .iconBuilder()))));
  }

  Widget confirmPasswordBuilder(BuildContext context, bool hideText) {
    final am = context.getAuthBloc(true),
        passwordBloc = context.getPasswordBloc(true);
    return CustomTextField(
        isFormField: true,
        obscureText: hideText,
        cursorColor: shades.kWhite,
        onSaved: am.onPasswordSaved,
        style: css.textFieldInputStyle,
        validator: am.validateConfirmPassword,
        textInputAction: TextInputAction.done,
        material: InputDecoration(
            hintText: 'Confirm Password',
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
    final am = context.getAuthBloc(true);
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Container(
                    width: context.width,
                    height: context.height,
                    decoration: css.screenBackground1,
                    padding:
                        EdgeInsets.symmetric(horizontal: context.width / 32),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Flexible(child: CustomBackButton()),
                          Flexible(
                              flex: 4,
                              child: Form(
                                  key: registerFormKey,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Flexible(
                                            child: context.loc.register
                                                .textWidget(
                                                    style:
                                                        css.authHeadingStyle)),
                                        Flexible(
                                            child: CustomTextField(
                                                isFormField: true,
                                                onSaved: am.onEmailSaved,
                                                cursorColor: shades.kWhite,
                                                style: css.textFieldInputStyle,
                                                validator:
                                                    context.validateEmail,
                                                textInputAction:
                                                    TextInputAction.next,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                material: const InputDecoration(
                                                    hintText: 'Enter Email'))),
                                        Flexible(
                                            child: CustomTextField(
                                                isFormField: true,
                                                onSaved: am.onNameSaved,
                                                cursorColor: shades.kWhite,
                                                style: css.textFieldInputStyle,
                                                validator: context.validateName,
                                                textInputAction:
                                                    TextInputAction.next,
                                                material: const InputDecoration(
                                                    hintText:
                                                        'Create Username'))),
                                        Flexible(
                                            child:
                                                BlocBuilder<PasswordBloc, bool>(
                                                    builder: passwordBuilder)),
                                        Flexible(
                                            child: BlocBuilder<PasswordBloc,
                                                    bool>(
                                                builder:
                                                    confirmPasswordBuilder)),
                                        Flexible(
                                            child: BlocBuilder<AuthBloc, bool>(
                                                builder:
                                                    registerButtonBuilder)),
                                        Flexible(
                                            child: BottomTextWidget(
                                                onTap: am.gotoLoginScreen,
                                                text1: 'Have an account? ',
                                                text2:
                                                    '${context.loc.login} here'))
                                      ])))
                        ])))));
  }
}
