import 'package:chat_app/core/shared_widgets/default_formfield.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/utils/shared_functions.dart';
import 'package:chat_app/features/messaging/presentation/view/widgets/attachment_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SendField extends StatefulWidget {
  final TextEditingController sendController;
  const SendField({super.key, required this.sendController});

  @override
  State<SendField> createState() => _SendFieldState();
}

class _SendFieldState extends State<SendField> {
  final ScrollController scrollController = ScrollController();
  bool isRTL = false;
  @override
  initState() {
    super.initState();
    widget.sendController.addListener(checkFirst);
  }

  checkFirst() {
    if (checkIsRTL(widget.sendController.text[0])) {
      if (!isRTL) {
        setState(() {
          isRTL = true;
        });
      }
    } else {
      if (isRTL) {
        setState(() {
          isRTL = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext blocContext) {
    return Container(
      alignment: Alignment.bottomLeft,
      child: defaultFormField(
          textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
          scrollController: scrollController,
          maxLines: 5,
          controller: widget.sendController,
          type: TextInputType.multiline,
          validate: (value) {},
          decoration: InputDecoration(
              suffixIcon: Transform.rotate(
                angle: 45,
                child: IconButton(
                  alignment: Alignment.bottomRight,
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: blocContext,
                      builder: (_) => AttachmentItems(),
                      routeSettings: RouteSettings(arguments: blocContext),
                    );
                  },
                  icon: Icon(Icons.attachment),
                  iconSize: 30,
                  color: Colors.grey,
                ),
              ),
              fillColor: ColorApp.appBackgroundColor,
              filled: true,
              hintText: 'send your message',
              floatingLabelStyle: const TextStyle(color: ColorApp.primaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ))),
    );
  }
}
