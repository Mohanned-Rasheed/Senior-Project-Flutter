class Water {
  Water(int amount, String date) {
    this._amount = amount;
    this._date = date;
  }
  late int _amount;
  late String _date;

  get getAmount => this._amount;
  set setAmount(value) => this._amount = value;

  get getDate => this._date;
  set setDate(value) => this._date = value;
}
