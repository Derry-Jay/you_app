import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/profile_bloc.dart';
import '../../../events/profile_error_state.dart';
import '../../../events/profile_loaded_state.dart';
import '../../../events/profile_loading_state.dart';
import '../../../events/profile_state.dart';
import '../../../extensions/extensions.dart';
import '../../../utils/enums.dart';
import '../../../utils/values.dart';
import '../../widgets/common/circular_loader.dart';
import '../../widgets/common/custom_back_button.dart';
import '../../widgets/common/empty_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  Widget screenBuilder(BuildContext context, ProfileState state) {
    final am = context.getAuthBloc();
    if (state is ProfileLoadingState) {
      return const CircularLoader(loaderType: LoaderType.fadingCircle);
    } else if (state is ProfileLoadedState) {
      final prf = state.pb.profile, unm = '@${prf.name}';
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Flexible(flex: 2, child: CustomBackButton(onTap: am.logout)),
                  Flexible(
                      flex: 2,
                      child: unm.textWidget(style: css.profileHeaderStyle)),
                  const Flexible(child: EmptyWidget()),
                  const Flexible(child: EmptyWidget()),
                  Flexible(
                      child: Icons.edit_square
                          .iconBuilder(color: shades.kWhite)
                          .iconButtonBuilder())
                ])),
            Flexible(
                child: Container(
                    alignment: Alignment.bottomLeft,
                    decoration: css.profileNameDecoration.copyWith(),
                    padding: EdgeInsets.only(
                        bottom: context.height / 80, left: context.width / 50),
                    child: unm.textWidget(style: css.profileNameStyle))),
            Flexible(
                child: Container(
                    decoration: css.aboutAndInterestDecoration,
                    padding:
                        EdgeInsets.symmetric(horizontal: context.width / 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                Flexible(
                                    child: context.loc.about.textWidget(
                                        style:
                                            css.aboutAndInterestHeadingStyle)),
                                Flexible(
                                    child: Icons.edit_square
                                        .iconBuilder(color: shades.kWhite)
                                        .iconButtonBuilder())
                              ])),
                          Flexible(
                              child:
                                  'Add about you to help others know you better'
                                      .textWidget(
                                          style:
                                              css.aboutAndInterestInputStyle))
                        ]))),
            Flexible(
                child: Container(
                    decoration: css.aboutAndInterestDecoration,
                    padding:
                        EdgeInsets.symmetric(horizontal: context.width / 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                Flexible(
                                    child: 'Interest'.textWidget(
                                        style:
                                            css.aboutAndInterestHeadingStyle)),
                                Flexible(
                                    child: Icons.edit_square
                                        .iconBuilder(color: shades.kWhite)
                                        .iconButtonBuilder())
                              ])),
                          Flexible(
                              child: (prf.interests.isEmpty
                                      ? 'Add in your interest to find a better match'
                                      : prf.interests.join(', '))
                                  .textWidget(
                                      style: css.aboutAndInterestInputStyle))
                        ])))
          ]);
    } else if (state is ProfileErrorState) {
      return Center(
          child: state.rp.message.textWidget(
              style: 'Inter'.getStyleFromFont(color: shades.kWhite)));
    } else {
      return const EmptyWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
              child: Container(
                  width: context.width,
                  height: context.height,
                  decoration: css.screenBackground2,
                  padding: EdgeInsets.symmetric(
                      horizontal: context.width / 40,
                      vertical: context.height / 50),
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                      builder: screenBuilder)))),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.getProfileBloc(false).getProfile();
  }

  @override
  void didUpdateWidget(covariant ProfileScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    context.getProfileBloc(false).getProfile();
  }
}
