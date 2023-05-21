RegExp emailRegex = RegExp(r"^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$");
RegExp passwordRegex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~])');

RegExp nameRegex = RegExp(r"^[_A-z]*((-|\s)*[_A-z])+[ ]*$");
RegExp numberRegex = RegExp(r"^[0-9]*$");

String? requiredValidator(String value) {
  if (value.isEmpty) {
    return "*Required";
  } else {
    return null;
  }
}

String? nameValidator(String value) {
  if (value.isEmpty) {
    return "*Required";
  } else if (!nameRegex.hasMatch(value)) {
    return '*Must not contain number and special character';
  } else {
    return null;
  }
}

String? nameOptionalValidator(String value) {
  if (value.isEmpty) {
    return null;
  } else if (!nameRegex.hasMatch(value)) {
    return '*Must not contain number and special character';
  } else {
    return null;
  }
}

String? emailValidator(String value) {
  if (value.isEmpty) {
    return "*Required";
  } else if (!emailRegex.hasMatch(value)) {
    return "*Email not Valid";
  } else {
    return null;
  }
}

String? passwordValidator(String value) {
  if (value.isEmpty) {
    return "*Required";
  } else if (value.length <= 7) {
    return '*Minimum 8 character required';
  } else {
    if (!passwordRegex.hasMatch(value)) {
      return '*Password Format not Correct';
    } else {
      return null;
    }
  }
}
