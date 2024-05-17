import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../blocs/pick_media_bloc.dart';
import '../../../extensions/extensions.dart';
import '../../../models/common/field.dart';
import '../../../utils/enums.dart';
import '../../../utils/values.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/empty_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  Widget imageBuilder(BuildContext context, XFile? pic) {
    final pmm = context.getPickMediaBloc();
    return GestureDetector(
        onTap: pmm.pickImage,
        child: Container(
            alignment: Alignment.center,
            decoration: pic == null
                ? css.addPicDecoration
                : css.addPicDecoration.copyWith(
                    image: pic.getDecorationImage(fit: 'fill'.boxFit)),
            padding: EdgeInsets.only(bottom: context.height / 65.536),
            margin: EdgeInsets.symmetric(
                vertical: context.height / 20, horizontal: context.width / 25),
            child: pic == null
                ? Icons.add.gradientIconBuilder(myLinearGradient)
                : null));
  }

  @override
  Widget build(BuildContext context) {
    final pm = context.getProfileBloc();
    final pmm = context.getPickMediaBloc();
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Container(
          width: context.width,
          height: context.height,
          decoration: css.screenBackground3,
          padding: EdgeInsets.symmetric(
              horizontal: context.width / 16, vertical: context.height / 50),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Flexible(
                flex: 4,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: context.loc.about.textWidget(
                              style: css.aboutAndInterestHeadingStyle)),
                      Flexible(
                          child: GestureDetector(
                              onTap: pm.updateProfile,
                              child:
                                  '${context.loc.save} & ${context.loc.close}'
                                      .textWidget(
                                          style: css.saveAndCloseStyle)))
                    ])),
            Flexible(
                flex: 4,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Flexible(
                      child: BlocBuilder<PickMediaBloc, XFile?>(
                          builder: imageBuilder)),
                  Flexible(
                      child: GestureDetector(
                          onTap: pmm.pickImage,
                          child: '${context.loc.add} Image'
                              .textWidget(style: css.saveAndCloseStyle))),
                  const Flexible(child: EmptyWidget()),
                  const Flexible(child: EmptyWidget())
                ])),
            for (Field field in pm.fields)
              Flexible(
                  flex: 2,
                  child: Column(children: [
                    Flexible(
                        flex: field.type == FieldType.dropDown ? 6 : 2,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  child: field.name.textWidget(
                                      style: css.aboutFieldLabelStyle)),
                              Flexible(
                                  child: field.type == FieldType.text
                                      ? CustomTextField(
                                          keyboardType: <String>[
                                            'weight:',
                                            'height:'
                                          ].contains(field.name.lowerCased)
                                              ? TextInputType.number
                                              : null,
                                          readOnly: field.name.lowerCased ==
                                              'birthday:',
                                          onTap: field.name.lowerCased == 'birthday:'
                                              ? pm.pickDate
                                              : null,
                                          textInputAction: field == pm.fields.last
                                              ? TextInputAction.done
                                              : TextInputAction.next,
                                          material: InputDecoration(
                                              hintText: field.hint,
                                              hintTextDirection:
                                                  TextDirection.rtl,
                                              hintStyle:
                                                  css.aboutAndInterestHintStyle,
                                              suffixText:
                                                  field.name.lowerCased == 'weight:'
                                                      ? 'Kg'
                                                      : (field.name.lowerCased == 'height:'
                                                          ? 'Cms/Ft.'
                                                          : null),
                                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: shades.kWhite3), borderRadius: measurements.textFieldRadius.circularRadius.all),
                                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: shades.kWhite3), borderRadius: measurements.textFieldRadius.circularRadius.all),
                                              border: OutlineInputBorder(borderSide: BorderSide(color: shades.kWhite3), borderRadius: measurements.textFieldRadius.circularRadius.all)),
                                          controller: field.name.lowerCased == 'weight:' ? wtc : (field.name.lowerCased == 'height:' ? htc : (field.name.lowerCased == 'horoscope:' ? hrc : (field.name.lowerCased == 'birthday:' ? dac : nmc))))
                                      : (field.type == FieldType.dropDown ? DropdownButtonFormField<Gender>(value: pm.gender, onChanged: pm.onGenderChanged, items: Gender.values.map<DropdownMenuItem<Gender>>((Gender e) => DropdownMenuItem<Gender>(value: e, child: e.name.firstLetterCapitalized.textWidget(style: css.bottomTextStyle1))).toList(), decoration: InputDecoration(hintText: field.hint, hintStyle: css.aboutAndInterestHintStyle, focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: shades.kWhite3), borderRadius: measurements.textFieldRadius.circularRadius.all), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: shades.kWhite3), borderRadius: measurements.textFieldRadius.circularRadius.all), border: OutlineInputBorder(borderSide: BorderSide(color: shades.kWhite3), borderRadius: measurements.textFieldRadius.circularRadius.all))) : const EmptyWidget()))
                            ])),
                    const Flexible(child: EmptyWidget())
                  ]))
          ])),
    )));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.getProfileBloc(false).getProfile();
  }
}
