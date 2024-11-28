import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constances.dart';
import '../../../../../core/themes/app_color.dart';
import '../../../data/models/user_info_model.dart';
import '../../../domain/entities/user_info_entity.dart';
import '../../cubit/setting_up_cubit.dart';
import '../../cubit/setting_up_states.dart';

class SetupProfileScreen extends StatefulWidget {
  const SetupProfileScreen({super.key});

  @override
  _SetupProfileScreenState createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends State<SetupProfileScreen> {
  String selectedCurrency = "";
  TextEditingController salaryController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (!currencies.containsKey(selectedCurrency)) {
      selectedCurrency = currencies.keys.first;
    }

    return BlocProvider<SettingCubit>(
      create: (context) => SettingCubit(),
      child: BlocBuilder<SettingCubit, SettingUpStates>(
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Scaffold(
              backgroundColor: AppColor.accentColor,
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: SizedBox()),
                    Text(
                      "We just need a few details to set things up",
                      style: GoogleFonts.abel(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColor.backgroundColor,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColor.lightGray),
                      ),
                      child: GestureDetector(
                        onTap: _showCurrencyBottomSheet,
                        child: Row(
                          children: [
                            Text(
                              "Currency: ",
                              style: GoogleFonts.abel(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: AppColor.backgroundColor,
                                ),
                              ),
                            ),
                            const Gap(10),
                            Text(
                              "${currencies[selectedCurrency]!['currencyName']} (${currencies[selectedCurrency]!['currencySymbol']})",
                              style: const TextStyle(
                                color: AppColor.backgroundColor,
                              ),
                            ),
                            Expanded(child: Container()),
                            const Icon(
                              CupertinoIcons.arrowtriangle_down_fill,
                              color: Colors.white,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: salaryController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixText: "Salary: ",
                        prefixStyle: GoogleFonts.abel(
                          textStyle: const TextStyle(
                            color: AppColor.backgroundColor,
                            fontSize: 20,
                          ),
                        ),
                        labelText: "Monthly Salary",
                        labelStyle: GoogleFonts.abel(
                          textStyle: const TextStyle(
                            color: AppColor.backgroundColor,
                            fontSize: 20,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColor.primaryColor,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColor.secondaryColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: AppColor.accentColor.withOpacity(0.1),
                        errorStyle: const TextStyle(color: Colors.white),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your salary';
                        }
                        final salary = int.tryParse(value);
                        if (salary == null || salary <= 0) {
                          return 'Please enter a valid salary';
                        }
                        return null;
                      },
                    ),
                    const Expanded(child: SizedBox()),
                    GestureDetector(
                      onTap: () {
                        if (formKey.currentState?.validate() ?? false) {
                          final cubit = BlocProvider.of<SettingCubit>(context);

                          UserInfoEntity user = UserInfoModel(
                            monthlyBudget: salaryController.text,
                            currency: selectedCurrency,
                          );

                          cubit.insertUserInfo(user);
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColor.lightGray,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            "Next",
                            style: GoogleFonts.abel(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showCurrencyBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Currency',
                style: GoogleFonts.abel(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  itemCount: currencies.length,
                  itemBuilder: (context, index) {
                    String key = currencies.keys.elementAt(index);
                    Map<String, String> currency = currencies[key]!;
                    return ListTile(
                      leading: Text(currency['flag']!),
                      title: Text(currency['currencyName']!),
                      subtitle: Text(currency['currencySymbol']!),
                      onTap: () {
                        setState(() {
                          selectedCurrency = key;
                        });
                        Navigator.of(context).pop();
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
