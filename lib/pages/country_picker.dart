
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smallservices/pages/provider_controller.dart';

class CountryPicker extends StatelessWidget {
  const CountryPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height / 17,
      width: size.width / 4,
      child: CountryCodePicker(
        onChanged: (country) {
          Provider.of<ProviderController>(context, listen: false)
              .dialCodeDigits = country.toString();
        },
        initialSelection: 'SY',
        showCountryOnly: true,
        showOnlyCountryWhenClosed: false,
        favorite: const ['+963', 'SY'],
        enabled: true,
        hideMainText: false,
        showFlagMain: true,
        showFlag: true,
        textStyle: GoogleFonts.lobster(
            textStyle: const TextStyle(color: Color(0xff3D1766))),
      ),
    );
  }
}
