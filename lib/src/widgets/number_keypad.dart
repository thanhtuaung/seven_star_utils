// ignore_for_file: must_be_immutable

part of seven_star_utils;

class SevenStarNumberKeyPad extends StatefulWidget {
  SevenStarNumberKeyPad({
    Key? key,
    bool? isOnlyNumber,
    this.background,
    this.primaryColor,
  })  : isOnlyNumber = isOnlyNumber ?? false,
        super(key: key);

  final bool isOnlyNumber;
  Color? background;
  Color? primaryColor;

  @override
  State<SevenStarNumberKeyPad> createState() => _SevenStarNumberKeyPadState();
}

class _SevenStarNumberKeyPadState extends State<SevenStarNumberKeyPad> {
  late double numPadWidth;
  late double buttonWidth;
  String value = '0';
  bool onTap = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    numPadWidth = MediaQuery.of(context).size.width * 0.75;
    buttonWidth = (numPadWidth - 56) / 4;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Card(
        color: widget.background ?? Colors.cyan,
        child: SizedBox(
          width: numPadWidth,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(right: 8),
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border:
                        Border.all(color: widget.primaryColor ?? Colors.white),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FittedBox(
                      child: Text(
                        value,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: widget.primaryColor ?? Colors.white),
                      ),
                    ),
                  ),
                ),
                ConstantWidgets.sizedBoxHeightL,
                _createRow(
                  context,
                  buttonWidth,
                  numbers: ['1', '2', '3', '0'],
                ),
                ConstantWidgets.sizedBoxHeight,
                _createRow(
                  context,
                  buttonWidth,
                  numbers: ['4', '5', '6', '.'],
                ),
                ConstantWidgets.sizedBoxHeight,
                _createRow(
                  context,
                  buttonWidth,
                  numbers: ['7', '8', '9'],
                  icon: const Icon(
                    Icons.backspace_outlined,
                    color: Colors.red,
                  ),
                ),
                ConstantWidgets.sizedBoxHeightL,
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            minimumSize: const Size(100, 45),
                            maximumSize: const Size(double.infinity, 45)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      // ConstantWidgets.sizedBoxHeightL,
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            // padding: const EdgeInsets.symmetric(horizontal: 16),
                            primary: Colors.green,
                            minimumSize: const Size(100, 45),
                            maximumSize: const Size(double.infinity, 45)),
                        onPressed: () {
                          Navigator.pop(context, value);
                        },
                        child: const Text('Ok'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createRow(BuildContext context, double buttonWidth,
      {required List<String> numbers, Icon? icon}) {
    return Row(
      children: [
        for (final key in numbers) createNumButton(key),
        if (icon != null) createNumButton('', icon: icon),
      ],
    );
  }

  createNumButton(String number, {Icon? icon}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        splashColor: Colors.redAccent,
        borderRadius: BorderRadius.circular(5),
        onLongPress: () {
          if (icon != null) {
            onTap = true;
            removeLast();
          }
        },
        onTapCancel: () {
          onTap = false;
          setState(() {});
        },
        onTap: () {
          if (value.startsWith('0') && value.length < 2) {
            value = value.replaceFirst('0', '');
          }

          if (number == '.') {
            if (widget.isOnlyNumber) {
              return;
            }
            if (value == '') value = '0';
            if (!value.contains('.')) {
              value += number;
              setState(() {});
              return;
            }
            return;
          }

          if (icon != null) {
            if (value.length > 1) {
              value = value.substring(0, value.length - 1);
            } else {
              value = '0';
            }
          } else {
            value += number;
          }
          setState(() {});
        },
        child: Container(
          alignment: Alignment.center,
          width: buttonWidth,
          height: buttonWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: widget.primaryColor ?? Colors.white),
          ),
          child: icon ??
              Text(
                number,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: widget.primaryColor ?? Colors.white,
                    fontWeight: FontWeight.bold),
              ),
        ),
      ),
    );
  }

  removeLast() {
    if (value.length == 1) {
      value = '0';
      setState(() {});
      return;
    }
    value = value.substring(0, value.length - 1);
    setState(() {});
    if (onTap) removeLast();
  }
}
