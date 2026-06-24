// ignore_for_file: unused_file, non_constant_identifier_names, deprecated_member_use, unused_field, curly_braces_in_flow_control_structures, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:spu_linux_app/Images/images_and_icons.dart';
import 'package:spu_linux_app/Providers/machine_provider.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/machine_card_data.dart';
import 'package:spu_linux_app/widgets/custom_snake_bar.dart';

class AddCardPage extends StatefulWidget {
  final VoidCallback page_after_finish;
  const AddCardPage({super.key, required this.page_after_finish});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final healthController = TextEditingController();

  final txt1Name = TextEditingController();
  final txt1Value = TextEditingController();
  final txt1Unit = TextEditingController();

  final txt2Name = TextEditingController();
  final txt2Value = TextEditingController();
  final txt2Unit = TextEditingController();

  final txt3Name = TextEditingController();
  final txt3Value = TextEditingController();
  final txt3Unit = TextEditingController();

  final daysController = TextEditingController();
  String selectedStatus = "normal";

  final List<String> availableImages = [
    AppImages.motor_Image,
    AppImages.motor_belt_Image,
    AppImages.motor_pump_Image,
    AppImages.SPU_Logo_Image,
    AppImages.choose_Image_1,
    AppImages.choose_Image_2,
    AppImages.choose_Image_3,
    AppImages.choose_Image_4,
    AppImages.choose_Image_5,
    AppImages.choose_Image_6,
    AppImages.choose_Image_7,
    AppImages.choose_Image_8,
    AppImages.choose_Image_9,
    AppImages.choose_Image_10,
    AppImages.choose_Image_11,
    AppImages.choose_Image_12,
    AppImages.choose_Image_13,
    AppImages.choose_Image_14,
    AppImages.choose_Image_15,
    AppImages.choose_Image_16,
  ];

  final List<String> availableIcons = [
    AppIcons.motor_Icon,
    AppIcons.motor_pump_Icon,
    AppIcons.motor_belt_Icon,
    AppIcons.choose_Icon_1,
    AppIcons.choose_Icon_2,
    AppIcons.choose_Icon_3,
    // AppIcons.choose_Icon_4,
    AppIcons.choose_Icon_5,
    AppIcons.choose_Icon_6,
    AppIcons.choose_Icon_7,
    AppIcons.choose_Icon_8,
    AppIcons.choose_Icon_9,
    AppIcons.choose_Icon_10,
    AppIcons.choose_Icon_11,
    AppIcons.choose_Icon_12,
    AppIcons.choose_Icon_13,
    AppIcons.choose_Icon_14,
    AppIcons.choose_Icon_15,
    AppIcons.choose_Icon_16,
    AppIcons.choose_Icon_17,
    AppIcons.choose_Icon_18,
    AppIcons.choose_Icon_19,
    AppIcons.choose_Icon_20,
  ];

  late String selectedMachineImage;
  late String selectedMachineIcon;

  @override
  void initState() {
    super.initState();
    selectedMachineImage = availableImages.isNotEmpty ? availableImages[0] : '';
    selectedMachineIcon = availableIcons.isNotEmpty ? availableIcons[0] : '';
  }

  void _showError(String msg) {
    custom_snake_bar(context, msg, Colors.white);

  }

  bool _validate() {
    if (nameController.text.trim().isEmpty)
      return _err("Machine name required");
    if (healthController.text.trim().isEmpty) return _err("Health required");

    final health = int.tryParse(healthController.text) ?? -1;
    if (health < 0 || health > 100)
      return _err("Health must be between 0 and 100");

    return true;
  }

  bool _err(String msg) {
    _showError(msg);
    return false;
  }

  Widget sectionCard({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xff1e222b),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          Gap(16),
          child,
        ],
      ),
    );
  }

  Widget input({
    required TextEditingController controller,
    required String initialValue,
    required String label,
    IconData? icon,
    int? maxLength,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    bool clearButton = true,
  }) {
    if (initialValue.isNotEmpty && controller.text.isEmpty) {
      controller.text = initialValue;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        maxLength: maxLength,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          counterText: "",
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white60, fontSize: 13),

          prefixIcon: icon != null
              ? Icon(icon, color: Colors.greenAccent, size: 18)
              : null,

          suffixIcon: clearButton
              ? IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.redAccent,
                    size: 18,
                  ),
                  onPressed: () => controller.clear(),
                )
              : null,

          filled: true,
          fillColor: const Color(0xff12141c),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.greenAccent, width: 1),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f1115),
      appBar: AppBar(
        title: const Text(
          "Configure New Machine",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            /// Machine image and icon
            sectionCard(
              title: "Select Machine Image Identity",
              child: SizedBox(
                height: 110,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: availableImages.length,
                  itemBuilder: (context, index) {
                    final imgPath = availableImages[index];
                    final isSelected = selectedMachineImage == imgPath;
                    return GestureDetector(
                      onTap: () =>
                          setState(() => selectedMachineImage = imgPath),
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? Colors.greenAccent
                                : Colors.white10,
                            width: isSelected ? 2 : 1,
                          ),
                          image: DecorationImage(
                            image: AssetImage(imgPath),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: isSelected
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Icon(
                                  Icons.check_circle,
                                  color: Colors.greenAccent,
                                ),
                              )
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
            sectionCard(
              title: "Select Machine Icon",
              child: SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: availableIcons.length,
                  itemBuilder: (context, index) {
                    final iconPath = availableIcons[index];
                    final isSelected = selectedMachineIcon == iconPath;
                    return GestureDetector(
                      onTap: () =>
                          setState(() => selectedMachineIcon = iconPath),
                      child: Container(
                        margin: const EdgeInsets.only(right: 14),

                        width: 80,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 41, 41, 41),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? Colors.greenAccent
                                : Colors.white10,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Image.asset(
                                iconPath,
                                fit: BoxFit.contain,
                                color: isSelected
                                    ? Colors.greenAccent
                                    : Colors.red,
                              ),
                            ),
                            if (isSelected)
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.greenAccent,
                                  size: 18,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            /// INFO
            sectionCard(
              title: "Core Specifications",
              child: Column(
                children: [
                  input(
                    icon: Icons.precision_manufacturing,
                    maxLength: 10,
                    controller: nameController,
                    initialValue: 'Machine',
                    label: "Machine Name (Max 10 Chars)",
                  ),
                  Gap(4),
                  DropdownButtonFormField<String>(
                    value: selectedStatus,
                    dropdownColor: const Color(0xff1e222b),
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    decoration: InputDecoration(
                      labelText: "Operational Status",
                      labelStyle: const TextStyle(
                        color: Colors.white60,
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: const Color(0xff12141c),
                      prefixIcon: const Icon(
                        Icons.gpp_good,
                        color: Colors.greenAccent,
                        size: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "normal",
                        child: Text("🟢 Normal"),
                      ),
                      DropdownMenuItem(
                        value: "warning",
                        child: Text("🟡 Warning"),
                      ),
                      DropdownMenuItem(value: "alert", child: Text("🔴 Alert")),
                    ],
                    onChanged: (value) =>
                        setState(() => selectedStatus = value!),
                  ),
                  Gap(16),
                  input(
                    icon: Icons.bolt,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                    controller: healthController,
                    initialValue: '100',
                    label: "Health Percentage (0-100)",
                  ),
                ],
              ),
            ),

            /// SENSORS TELEMETRY
            sectionCard(
              title: "Telemetry & Sensors Data",
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: input(
                          maxLength: 6,
                          controller: txt1Name,
                          initialValue: 'Sen 1',
                          label: 'Name',
                        ),
                      ),
                      Gap(8),
                      Expanded(
                        flex: 3,
                        child: input(
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                            signed: true,
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6),
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^-?[0-9.]*'),
                            ),
                          ],
                          controller: txt1Value,
                          initialValue: '0',
                          label: 'Value',
                        ),
                      ),
                      Gap(8),
                      Expanded(
                        flex: 2,
                        child: input(
                          maxLength: 4,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Zء-ي ]'),
                            ),
                          ],
                          controller: txt1Unit,
                          initialValue: 'U',
                          label: 'Unit',
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: input(
                          maxLength: 6,
                          controller: txt2Name,
                          initialValue: 'Sen 2',
                          label: 'Name',
                        ),
                      ),
                      Gap(8),
                      Expanded(
                        flex: 3,
                        child: input(
                          controller: txt2Value,
                          initialValue: '0',
                          label: 'Value',
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                            signed: true,
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6),
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^-?[0-9.]*'),
                            ),
                          ],
                        ),
                      ),
                      Gap(8),
                      Expanded(
                        flex: 2,
                        child: input(
                          controller: txt2Unit,
                          initialValue: 'U',
                          label: 'Unit',
                          maxLength: 4,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Zء-ي ]'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: input(
                          maxLength: 6,
                          controller: txt3Name,
                          initialValue: 'Sen 3',
                          label: 'Name',
                        ),
                      ),
                      Gap(8),
                      Expanded(
                        flex: 3,
                        child: input(
                          controller: txt3Value,
                          initialValue: '0',
                          label: 'Value',
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                            signed: true,
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6),
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^-?[0-9.]*'),
                            ),
                          ],
                        ),
                      ),
                      Gap(8),
                      Expanded(
                        flex: 2,
                        child: input(
                          controller: txt3Unit,
                          initialValue: 'U',
                          label: 'Unit',
                          maxLength: 4,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Zء-ي ]'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  input(
                    icon: Icons.shutter_speed,
                    keyboardType: TextInputType.number,
                    controller: daysController,
                    initialValue: '~',
                    label: "Predictive Fault Horizon (Days)",
                  ),
                ],
              ),
            ),
            Gap(15),

            /// SAVE BUTTON
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.greenAccent.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    if (!_validate()) return;

                    final newCard = MachineCardData(
                      value: (int.tryParse(healthController.text) ?? 0)
                          .toDouble(),
                      name: nameController.text.trim(),
                      imgIcon: selectedMachineIcon,
                      img: selectedMachineImage,
                      statusName: selectedStatus,
                      sensor_1_name: txt1Name.text.trim(),
                      sensor_1_value:
                          "${txt1Value.text.trim()} ${txt1Unit.text.trim()}",
                      sensor_2_name: txt2Name.text.trim(),
                      sensor_2_value:
                          "${txt2Value.text.trim()} ${txt2Unit.text.trim()}",
                      sensor_3_name: txt3Name.text.trim(),
                      sensor_3_value:
                          "${txt3Value.text.trim()} ${txt3Unit.text.trim()}",
                      days: daysController.text.trim(),
                    );

                    context.read<MachineProvider>().addCard(newCard);
                    widget.page_after_finish();
                  },
                  child: const Text(
                    "SAVE MACHINE CONFIG",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
