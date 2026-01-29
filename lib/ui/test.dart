import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key, required this.title});

  final String title;

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final ValueNotifier<int> _tabIndexBasicToggle = ValueNotifier(1);
  final ValueNotifier<int> _tabIndexTextWithIcon = ValueNotifier(0);
  final ValueNotifier<int> _tabIndexIconButton = ValueNotifier(0);
  final ValueNotifier<int> _tabIndexUpdateProgrammatically = ValueNotifier(0);

  // 1. Labels o'rniga DataTab ro'yxati ishlatiladi
  List<DataTab> get _listTextTabToggle => [
    DataTab(title: "Tab A (10)"),
    DataTab(title: "Tab B (6)"),
    DataTab(title: "Tab C (9)"),
  ];

  List<DataTab> get _listTextSelectedToggle => [
    DataTab(title: "Select A (10)"),
    DataTab(title: "Select B (6)"),
    DataTab(title: "Select C (9)"),
  ];

  // 2. Text va Icon birgalikda bitta DataTab ichida keladi
  List<DataTab> get _listGenderDataTab => [
    DataTab(title: "Male", icon: Icons.person),
    DataTab(title: "Female", icon: Icons.pregnant_woman),
  ];

  // 3. Faqat Icon kerak bo'lsa, title yozmaslik yoki bo'sh qoldirish mumkin (lekin DataTab icon qabul qiladi)
  List<DataTab> get _listIconOnlyDataTab => [
    DataTab(icon: Icons.person),
    DataTab(icon: Icons.pregnant_woman),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Tab Toggle"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 8),
        child: Column(
          children: <Widget>[
            basicTabToggle(),
            ...divider(),
            textWithIcon(),
            ...divider(),
            iconButton(),
            ...divider(),
            updateProgrammatically(),
          ],
        ),
      ),
    );
  }

  List<Widget> divider() => [
    const SizedBox(height: 20),
    const Divider(thickness: 2),
    const SizedBox(height: 20),
  ];

  Widget basicTabToggle() => Column(
    children: [
      /// Basic Toggle Sample
      const SizedBox(height: 20),
      const Text(
        "Basic Tab Toggle",
        style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
      ),
      const SizedBox(height: 20),
      ValueListenableBuilder(
        valueListenable: _tabIndexBasicToggle,
        builder: (context, currentIndex, _) {
          return FlutterToggleTab(
            width: 90,
            borderRadius: 30,
            height: 50,
            selectedIndex: currentIndex,
            selectedBackgroundColors: const [
              Colors.blue,
              Colors.blueAccent,
            ],
            selectedTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            unSelectedTextStyle: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            // ESKI: labels: _listTextTabToggle,
            // YANGI: dataTabs parametri
            dataTabs: _listTextTabToggle,
            selectedLabelIndex: (index) {
              _tabIndexBasicToggle.value = index;
            },
            isScroll: false,
          );
        },
      ),
      TextButton(
        onPressed: () {
          _tabIndexBasicToggle.value = 2;
        },
        child: const Text("Change to Index 2"),
      ),
      const SizedBox(height: 20),
      ValueListenableBuilder(
        valueListenable: _tabIndexBasicToggle,
        builder: (context, currentIndex, _) {
          return Text(
            "Index selected : $currentIndex",
            style: const TextStyle(fontSize: 20),
          );
        },
      ),
    ],
  );

  Widget textWithIcon() => Column(
    children: [
      /// Text with icon sample
      const SizedBox(height: 20),
      const Text(
        "Text With Icon",
        style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
      ),
      Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Select your sex : ",
              style: TextStyle(fontSize: 20),
            ),
            ValueListenableBuilder(
              valueListenable: _tabIndexTextWithIcon,
              builder: (context, currentIndex, _) {
                return FlutterToggleTab(
                  width: 50,
                  borderRadius: 15,
                  selectedTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  unSelectedTextStyle: const TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  // ESKI: labels va icons alohida edi
                  // YANGI: dataTabs orqali birlashtirilgan
                  dataTabs: _listGenderDataTab,
                  selectedIndex: currentIndex,
                  selectedLabelIndex: (index) {
                    _tabIndexTextWithIcon.value = index;
                  },
                );
              },
            ),
          ],
        ),
      ),

      /// Icon with Text Button Sample
      const SizedBox(height: 20),
      ValueListenableBuilder(
        valueListenable: _tabIndexTextWithIcon,
        builder: (context, currentIndex, _) {
          // Title ni DataTab dan olish
          return Text(
            "Selected sex : ${_listGenderDataTab[currentIndex].title} ",
            style: const TextStyle(fontSize: 20),
          );
        },
      ),
    ],
  );

  Widget iconButton() => Column(
    children: [
      /// Icon button sample
      const Text(
        "With Icon Only and Implement margin for selected item",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
      ),
      Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Select your sex : ",
              style: TextStyle(fontSize: 20),
            ),
            ValueListenableBuilder(
              valueListenable: _tabIndexIconButton,
              builder: (context, currentIndex, _) {
                return FlutterToggleTab(
                  width: 40,
                  borderRadius: 15,
                  selectedIndex: currentIndex,
                  selectedTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  unSelectedTextStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  // Faqat iconlar uchun DataTab
                  dataTabs: _listIconOnlyDataTab,
                  // iconSize parametri kerak bo'lsa ishlatishingiz mumkin,
                  // lekin DataTab o'zi iconni boshqaradi.
                  iconSize: 40,
                  selectedLabelIndex: (index) {
                    _tabIndexIconButton.value = index;
                  },
                  marginSelected: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      ValueListenableBuilder(
        valueListenable: _tabIndexIconButton,
        builder: (context, currentIndex, _) {
          return Text(
            "Selected sex index: $currentIndex",
            style: const TextStyle(fontSize: 20),
          );
        },
      ),
    ],
  );

  Widget updateProgrammatically() => Column(
    children: [
      const Text(
        "Update selected programmatically  ",
        style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
      ),
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Select your sex : ",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder(
              valueListenable: _tabIndexUpdateProgrammatically,
              builder: (context, currentIndex, _) {
                return FlutterToggleTab(
                  width: 85,
                  borderRadius: 15,
                  selectedIndex: currentIndex,
                  selectedTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  unSelectedTextStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  dataTabs: _listTextSelectedToggle,
                  selectedLabelIndex: (index) {
                    _tabIndexUpdateProgrammatically.value = index;
                  },
                );
              },
            ),
            TextButton(
              onPressed: () {
                _tabIndexUpdateProgrammatically.value = 2;
              },
              child: const Text("Select C"),
            )
          ],
        ),
      ),
      const SizedBox(height: 20),
      ValueListenableBuilder(
        valueListenable: _tabIndexUpdateProgrammatically,
        builder: (context, currentIndex, _) {
          return Text(
            "Selected sex index: $currentIndex ",
            style: const TextStyle(fontSize: 20),
          );
        },
      ),
    ],
  );
}