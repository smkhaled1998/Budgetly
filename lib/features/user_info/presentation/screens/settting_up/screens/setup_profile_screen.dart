import 'package:budget_buddy/features/category/presentation/cubit/category_cubit.dart';
import 'package:budget_buddy/features/user_info/presentation/cubit/setting_up_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/constances.dart';
import '../../../../../../core/themes/app_color.dart';
import '../../../../../category/presentation/screens/category_slicing/screens/category_slicing_screen.dart';
import '../../../../data/models/user_info_model.dart';
import '../../../../domain/entities/user_info_entity.dart';
import '../../../cubit/setting_up_cubit.dart';
import '../widgets/currency_modal_bottom_sheet.dart';


class SetupProfileScreen extends StatelessWidget {
  SetupProfileScreen({super.key});

  @override
  TextEditingController salaryController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    SettingCubit settingCubit=SettingCubit.get(context);
    if (!currencies.containsKey(settingCubit.selectedCurrency)) {
      settingCubit.selectedCurrency = currencies.keys.first;
    }

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
              const Gap(20),
              BlocBuilder<SettingCubit,SettingStates>(
                builder: (context,state) {
                  SettingCubit settingCubit=SettingCubit.get(context);
                  return Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColor.lightGray),
                    ),
                    child: GestureDetector(
                      onTap: () => _showCurrencyBottomSheet(context, settingCubit),
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
                            "${currencies[settingCubit.selectedCurrency]!['currencyName']} (${currencies[settingCubit.selectedCurrency]!['currencySymbol']})",
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

                  );
                }
              ),
              const Gap(20),
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
                    double monthlySalary=double.tryParse(salaryController.text)!;
                    // SettingCubit settingCubit =SettingCubit.get(context);

                    // settingCubit.monthlySalary=double.tryParse(salaryController.text)!;
                    // CategoryCubit.get(context).monthlySalary=double.tryParse(salaryController.text)!;
                    // UserInfoEntity user = UserInfoModel(
                    //   monthlySalary: salaryController.text,
                    //   currency: settingCubit.selectedCurrency!,
                    // );
                    // settingCubit.insertUserInfo(user);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        BlocProvider<CategoryCubit>(
                            create: (context)=>CategoryCubit(),
                            child: CategorySlicingScreen(monthlySalary: monthlySalary))));

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
  }

   _showCurrencyBottomSheet(context, SettingCubit settingCubit) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CurrencyBottomSheet(settingCubit: settingCubit);
      },
    );
  }
}
