import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef Validator = String? Function(String?);


class Appformfiled extends StatefulWidget {

  String label ;
  IconData? icon ;
  TextInputType keyboardTybe ;
  bool isPassword  ;
  Validator? validator ;
  TextEditingController? controller ;
  int line ;

  Appformfiled({super.key,this.isPassword=false,this.keyboardTybe=TextInputType.text,
    this.validator,required this.label, this.icon, this.line=1,this.controller});
  @override
  State<Appformfiled> createState() => _AppformfiledState();
}

class _AppformfiledState extends State<Appformfiled> {
  bool secuerText = false;
  @override
  void initState() {
    super.initState();
    secuerText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        maxLines: widget.line,
        controller: widget.controller,
        style: GoogleFonts.inter(
          fontSize: 16,
          color: Theme.of(context).colorScheme.primary
        ),
        validator: widget.validator,
        obscureText: secuerText,
        keyboardType: widget.keyboardTybe,
            decoration: InputDecoration(
              labelText: widget.label,
              prefixIcon:widget.icon != null ? Icon(widget.icon) : null,
              suffixIcon: widget.isPassword ?
              InkWell(
                onTap: (){
                  setState(() {
                    secuerText = !secuerText;
                  });
                },
                child: Icon(
                  secuerText ?
                  Icons.visibility_off : Icons.visibility,
                ),
              ) : null,
            )
        ),
    );
  }
}
