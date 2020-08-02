String validateNotEmpty(String value) {
  {
    if (value.isEmpty) {
      return 'Это поле не может быть пустым';
    }

    print("$value is a valid entry - going further");
    return null;
  }
}
