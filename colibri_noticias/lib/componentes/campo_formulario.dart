import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CampoFormulario extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final String placeholder;
  final Widget prefixIcon;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool isDateField;
  final bool isPasswordField;

  const CampoFormulario({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.label,
    required this.placeholder,
    required this.prefixIcon,
    required this.validator,
    required this.inputFormatters,
    this.isDateField = false,
    this.isPasswordField = false, // indica se o campo é de senha
  });

  @override
  State<CampoFormulario> createState() => _CampoFormularioState();
}

class _CampoFormularioState extends State<CampoFormulario> {
  bool _isPasswordFieldVisible = false; // Estado local para controlar a visibilidade da senha.

  Future<void> _selectDate(BuildContext context) async {
    widget.focusNode.unfocus(); 
    if (!context.mounted) return;
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      locale: const Locale('pt', 'BR'),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColorDark,
              onPrimary: Colors.white,
              onSurface: Theme.of(context).primaryColorDark,
            ),
            dialogTheme: DialogTheme(
              backgroundColor: Theme.of(context).primaryColorDark,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null && context.mounted) {
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Theme.of(context).primaryColorDark,
                onPrimary: Colors.white,
                onSurface: Theme.of(context).primaryColorDark,
              ),
              dialogTheme: DialogTheme(
                backgroundColor: Theme.of(context).primaryColorDark,
              ),
            ),
            child: child!,
          );
        },
      );

      if (selectedTime != null && context.mounted) {
        final DateTime combinedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        widget.controller.text = '${UtilData.obterDataDDMMAAAA(combinedDateTime)} ${UtilData.obterHoraHHMM(combinedDateTime)}';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        cursorColor: Colors.grey,
        controller: widget.controller,
        focusNode: widget.focusNode,
        validator: widget.validator,
        onTap: widget.isDateField ? () => _selectDate(context) : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.placeholder,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon:
              widget.isPasswordField
                  ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordFieldVisible = !_isPasswordFieldVisible;
                      });
                    },
                    icon: Icon(
                      _isPasswordFieldVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  )
                  : null,
        ),
        obscureText:
            widget.isPasswordField &&
            !_isPasswordFieldVisible, // Exibe ou oculta a senha.
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 16),
        inputFormatters: widget.inputFormatters,
      ),
    );
  }
}
