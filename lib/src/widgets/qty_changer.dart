// ignore_for_file: must_be_immutable

part of seven_star_utils;

class SevenStarQtyChanger extends StatefulWidget {
  SevenStarQtyChanger({
    Key? key,
    this.initialValue,
    required this.onChanged,
    this.backgroundColor,
    this.borderRadius,
    this.textStyle,
    this.iconColor,
    this.textPadding,
    this.keypadBackgroundColor,
    this.keypadForegroundColor,
  }) : super(key: key);

  int? initialValue;
  OnValueChanged onChanged;
  double? borderRadius;
  Color? backgroundColor;
  Color? iconColor;
  TextStyle? textStyle;
  EdgeInsets? textPadding;
  Color? keypadBackgroundColor;
  Color? keypadForegroundColor;
  final bool numberOnly = false;

  @override
  State<SevenStarQtyChanger> createState() => _SevenStarQtyChangerState();
}

class _SevenStarQtyChangerState extends State<SevenStarQtyChanger> {
  late int initialValue;

  @override
  void initState() {
    initialValue = widget.initialValue ?? 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 5)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            splashRadius: 20,
            color: widget.iconColor,
            onPressed: () {
              if (initialValue > 1) {
                initialValue--;
                setState(() {});
              }
            },
            icon: const Icon(Icons.remove),
          ),
          InkWell(
              onTap: () async {
                String? value = await showInputKeypad();
                if (value != null) {
                  initialValue = int.parse(value);
                  widget.onChanged(int.parse(value));
                  setState(() {});
                }
              },
              child: Container(
                alignment: Alignment.center,
                padding: widget.textPadding ??
                    const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  '$initialValue',
                  style: widget.textStyle ??
                      Theme.of(context).textTheme.titleLarge,
                ),
              )),
          IconButton(
            color: widget.iconColor,
            splashRadius: 20,
            onPressed: () {
              initialValue++;
              setState(() {});
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Future<String?> showInputKeypad() async {
    return await showDialog<String>(
        context: context,
        builder: (context) {
          return Center(
            child: SevenStarNumberKeyPad(
              background: widget.keypadBackgroundColor,
              primaryColor: widget.keypadForegroundColor,
              isOnlyNumber: true,
            ),
          );
        });
  }
}
