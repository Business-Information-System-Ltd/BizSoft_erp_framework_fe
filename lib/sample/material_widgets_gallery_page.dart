/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : material_widgets_gallery_page.dart
 Purpose      : Material widget examples mapped to common ERP UI usage.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'package:flutter/material.dart';

import '../shared/layout/bs_page.dart';
import '../shared/layout/bs_section_card.dart';

class MaterialWidgetsGalleryPage extends StatefulWidget {
  const MaterialWidgetsGalleryPage({super.key});

  @override
  State<MaterialWidgetsGalleryPage> createState() =>
      _MaterialWidgetsGalleryPageState();
}

class _MaterialWidgetsGalleryPageState
    extends State<MaterialWidgetsGalleryPage> {
  final _textController = TextEditingController(text: 'BIS-YGN');
  final _formController = TextEditingController(text: 'Supplier Name');
  final _menuController = MenuController();

  int _railIndex = 0;
  int _navIndex = 0;
  int _bottomNavIndex = 0;
  int _stepperIndex = 1;
  String? _dropdownValue = 'supplier';
  bool _checkboxValue = true;
  String _radioValue = 'active';
  bool _switchValue = true;
  double _sliderValue = 30;
  String _segment = 'list';
  bool _filterSelected = true;
  String _choiceValue = 'local';
  String _dropdownMenuValue = 'MMK';
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  DateTimeRange? _selectedRange;
  List<int> _reorderableItems = [1, 2, 3, 4, 5];

  @override
  void dispose() {
    _textController.dispose();
    _formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BsPage(
      title: 'Material Widgets Gallery',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _intro(context),
          _appStructure(context),
          _layoutContainers(context),
          _inputFields(context),
          _buttons(context),
          _selection(context),
          _tabs(context),
          _tablesAndLists(context),
          _feedback(context),
          _dateAndTime(context),
          _menus(context),
          _visualDisplay(context),
          _materialSurfaces(context),
          _stepper(context),
          _gestures(context),
          _reorderableList(context),
          _bottomSheetSection(context),
          _dialogVariations(context),
        ],
      ),
    );
  }

  Widget _intro(BuildContext context) {
    return const BsSectionCard(
      title: 'ERP Material Widget Map',
      child: Text(
        'This page demonstrates common Flutter Material widgets and where they fit in BizSoft ERP screens.',
      ),
    );
  }

  Widget _appStructure(BuildContext context) {
    return BsSectionCard(
      title: 'App Structure',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _usageText('ERP shell, menu, and navigation'),
          const SizedBox(height: 8),
          SizedBox(
            height: 220,
            child: DecoratedBox(
              decoration: _demoBorder(context),
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('AppBar'),
                  actions: [
                    IconButton(
                      tooltip: 'Help',
                      onPressed: () {},
                      icon: const Icon(Icons.help_outline),
                    ),
                  ],
                ),
                drawer: const Drawer(
                  child: SafeArea(
                    child: ListTile(
                      leading: Icon(Icons.menu),
                      title: Text('Drawer menu'),
                    ),
                  ),
                ),
                body: Row(
                  children: [
                    NavigationRail(
                      selectedIndex: _railIndex,
                      onDestinationSelected: (value) =>
                          setState(() => _railIndex = value),
                      labelType: NavigationRailLabelType.all,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.dashboard_outlined),
                          label: Text('Home'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.settings_outlined),
                          label: Text('Setup'),
                        ),
                      ],
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(
                      child: Column(
                        children: [
                          const Expanded(
                            child: Center(
                              child: Text('Scaffold + AppBar + Drawer'),
                            ),
                          ),
                          NavigationBar(
                            selectedIndex: _navIndex,
                            onDestinationSelected: (value) =>
                                setState(() => _navIndex = value),
                            destinations: const [
                              NavigationDestination(
                                icon: Icon(Icons.list_alt_outlined),
                                label: 'List',
                              ),
                              NavigationDestination(
                                icon: Icon(Icons.edit_note_outlined),
                                label: 'Entry',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _WidgetChip(label: 'MaterialApp'),
              _WidgetChip(label: 'Scaffold'),
              _WidgetChip(label: 'AppBar'),
              _WidgetChip(label: 'Drawer'),
              _WidgetChip(label: 'NavigationBar'),
              _WidgetChip(label: 'NavigationRail'),
            ],
          ),
          const SizedBox(height: 8),
          const Text('BottomNavigationBar:'),
          const SizedBox(height: 4),
          BottomNavigationBar(
            currentIndex: _bottomNavIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            onTap: (index) => setState(() => _bottomNavIndex = index),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              OutlinedButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                child: const Text('Open Drawer'),
              ),
              OutlinedButton(
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                child: const Text('Open End Drawer'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _layoutContainers(BuildContext context) {
    return BsSectionCard(
      title: 'Layout Containers',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _usageText('Form sections, panels, popup forms'),
          const SizedBox(height: 8),
          const Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.inventory_2_outlined),
                  title: Text('Card + ListTile'),
                  subtitle: Text('Asset, partner, or document summary row'),
                ),
                Divider(height: 1),
                ExpansionTile(
                  title: Text('ExpansionTile'),
                  subtitle: Text('Less-used information'),
                  children: [
                    ListTile(
                      dense: true,
                      title: Text('Collapsed section content'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text('ExpansionPanelList (Radio style):'),
          const SizedBox(height: 4),
          // FIXED: Use ExpansionPanelList.radio which handles layout properly
          ExpansionPanelList.radio(
            initialOpenPanelValue: 0,
            children: [
              ExpansionPanelRadio(
                value: 0,
                headerBuilder: (context, isExpanded) =>
                    const ListTile(title: Text('Payment Terms')),
                body: const ListTile(dense: true, title: Text('Net 30 days')),
              ),
              ExpansionPanelRadio(
                value: 1,
                headerBuilder: (context, isExpanded) =>
                    const ListTile(title: Text('Delivery Terms')),
                body: const ListTile(
                  dense: true,
                  title: Text('FOB Destination'),
                ),
              ),
              ExpansionPanelRadio(
                value: 2,
                headerBuilder: (context, isExpanded) =>
                    const ListTile(title: Text('Payment Method')),
                body: const ListTile(dense: true, title: Text('Bank Transfer')),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              FilledButton(
                onPressed: _showBottomSheet,
                child: const Text('BottomSheet'),
              ),
              OutlinedButton(
                onPressed: _showDialog,
                child: const Text('Dialog'),
              ),
            ],
          ),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _WidgetChip(label: 'Card'),
              _WidgetChip(label: 'ListTile'),
              _WidgetChip(label: 'ExpansionTile'),
              _WidgetChip(label: 'ExpansionPanelList'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _inputFields(BuildContext context) {
    return BsSectionCard(
      title: 'Input Fields',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _usageText('Data entry'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: [
              SizedBox(
                width: 260,
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(labelText: 'TextField'),
                ),
              ),
              SizedBox(
                width: 260,
                child: TextFormField(
                  controller: _formController,
                  decoration: const InputDecoration(
                    labelText: 'TextFormField *',
                  ),
                ),
              ),
              SizedBox(
                width: 260,
                child: DropdownButtonFormField<String>(
                  initialValue: _dropdownValue,
                  decoration: const InputDecoration(
                    labelText: 'DropdownButtonFormField',
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'supplier',
                      child: Text('Supplier'),
                    ),
                    DropdownMenuItem(
                      value: 'customer',
                      child: Text('Customer'),
                    ),
                  ],
                  onChanged: (value) => setState(() => _dropdownValue = value),
                ),
              ),
              SizedBox(
                width: 180,
                child: CheckboxListTile(
                  dense: true,
                  value: _checkboxValue,
                  title: const Text('Checkbox'),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) =>
                      setState(() => _checkboxValue = value ?? false),
                ),
              ),
              SizedBox(
                width: 240,
                child: Row(
                  children: [
                    const Text('Radio'),
                    const SizedBox(width: 8),
                    Radio<String>(
                      value: 'active',
                      groupValue: _radioValue,
                      onChanged: (value) =>
                          setState(() => _radioValue = value ?? 'active'),
                    ),
                    const Text('Active'),
                  ],
                ),
              ),
              SizedBox(
                width: 180,
                child: SwitchListTile(
                  dense: true,
                  value: _switchValue,
                  title: const Text('Switch'),
                  onChanged: (value) => setState(() => _switchValue = value),
                ),
              ),
              SizedBox(
                width: 260,
                child: Row(
                  children: [
                    const Text('Slider'),
                    Expanded(
                      child: Slider(
                        value: _sliderValue,
                        min: 0,
                        max: 100,
                        divisions: 10,
                        label: _sliderValue.round().toString(),
                        onChanged: (value) =>
                            setState(() => _sliderValue = value),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _WidgetChip(label: 'TextField'),
              _WidgetChip(label: 'TextFormField'),
              _WidgetChip(label: 'DropdownButtonFormField'),
              _WidgetChip(label: 'Checkbox'),
              _WidgetChip(label: 'Radio'),
              _WidgetChip(label: 'Switch'),
              _WidgetChip(label: 'Slider'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buttons(BuildContext context) {
    return BsSectionCard(
      title: 'Buttons',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _usageText('Save, Cancel, Submit, and page actions'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text('Elevated')),
              FilledButton(onPressed: () {}, child: const Text('Filled')),
              OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
              TextButton(onPressed: () {}, child: const Text('Text')),
              IconButton(
                tooltip: 'IconButton',
                onPressed: () {},
                icon: const Icon(Icons.refresh),
              ),
              FloatingActionButton.small(
                tooltip: 'FloatingActionButton',
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'list', label: Text('List')),
                  ButtonSegment(value: 'grid', label: Text('Grid')),
                ],
                selected: {_segment},
                onSelectionChanged: (values) =>
                    setState(() => _segment = values.first),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('FloatingActionButton variations:'),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
              FloatingActionButton.small(
                onPressed: () {},
                tooltip: 'FloatingActionButton.small',
                child: const Icon(Icons.edit),
              ),
              FloatingActionButton.extended(
                onPressed: () {},
                tooltip: 'FloatingActionButton.extended',
                icon: const Icon(Icons.save),
                label: const Text('Save'),
              ),
              FloatingActionButton.large(
                onPressed: () {},
                tooltip: 'FloatingActionButton.large',
                child: const Icon(Icons.upload),
              ),
            ],
          ),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _WidgetChip(label: 'ElevatedButton'),
              _WidgetChip(label: 'FilledButton'),
              _WidgetChip(label: 'OutlinedButton'),
              _WidgetChip(label: 'TextButton'),
              _WidgetChip(label: 'IconButton'),
              _WidgetChip(label: 'FloatingActionButton'),
              _WidgetChip(label: 'SegmentedButton'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _selection(BuildContext context) {
    return BsSectionCard(
      title: 'Selection',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _usageText('Status filters and role choices'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: const Text('Local'),
                selected: _choiceValue == 'local',
                onSelected: (_) => setState(() => _choiceValue = 'local'),
              ),
              ChoiceChip(
                label: const Text('Foreign'),
                selected: _choiceValue == 'foreign',
                onSelected: (_) => setState(() => _choiceValue = 'foreign'),
              ),
              FilterChip(
                label: const Text('Active only'),
                selected: _filterSelected,
                onSelected: (value) => setState(() => _filterSelected = value),
              ),
              InputChip(
                label: const Text('Role: Supplier'),
                avatar: const Icon(Icons.local_shipping_outlined, size: 18),
                onDeleted: () {},
              ),
              ActionChip(
                label: const Text('ActionChip'),
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ActionChip pressed')),
                ),
              ),
              DropdownMenu<String>(
                initialSelection: _dropdownMenuValue,
                label: const Text('DropdownMenu'),
                width: 180,
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: 'MMK', label: 'MMK'),
                  DropdownMenuEntry(value: 'USD', label: 'USD'),
                ],
                onSelected: (value) =>
                    setState(() => _dropdownMenuValue = value ?? 'MMK'),
              ),
              MenuAnchor(
                menuChildren: [
                  MenuItemButton(
                    onPressed: () {},
                    child: const Text('MenuAnchor item'),
                  ),
                ],
                builder: (context, controller, child) => OutlinedButton(
                  onPressed: () => controller.isOpen
                      ? controller.close()
                      : controller.open(),
                  child: const Text('MenuAnchor'),
                ),
              ),
            ],
          ),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _WidgetChip(label: 'ChoiceChip'),
              _WidgetChip(label: 'FilterChip'),
              _WidgetChip(label: 'InputChip'),
              _WidgetChip(label: 'ActionChip'),
              _WidgetChip(label: 'DropdownMenu'),
              _WidgetChip(label: 'MenuAnchor'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tabs(BuildContext context) {
    return BsSectionCard(
      title: 'Tabs',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _usageText('Partner tabs and supplier tabs'),
          const SizedBox(height: 8),
          const SizedBox(
            height: 150,
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: 'Basic'),
                      Tab(text: 'Payment'),
                      Tab(text: 'Tax'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Center(child: Text('Basic tab content')),
                        Center(child: Text('Payment tab content')),
                        Center(child: Text('Tax tab content')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _WidgetChip(label: 'TabBar'),
              _WidgetChip(label: 'TabBarView'),
              _WidgetChip(label: 'DefaultTabController'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tablesAndLists(BuildContext context) {
    return BsSectionCard(
      title: 'Tables And Lists',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _usageText('Lists and small tables'),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Code')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Status')),
              ],
              rows: const [
                DataRow(
                  cells: [
                    DataCell(Text('BR-001')),
                    DataCell(Text('Yangon')),
                    DataCell(Text('Active')),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('BR-002')),
                    DataCell(Text('Mandalay')),
                    DataCell(Text('Draft')),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 120,
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 4,
              children: const [
                Card(child: Center(child: Text('ListView'))),
                Card(child: Center(child: Text('GridView'))),
                Card(child: Center(child: Text('PaginatedDataTable'))),
              ],
            ),
          ),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _WidgetChip(label: 'DataTable'),
              _WidgetChip(label: 'GridView'),
              _WidgetChip(label: 'ListView'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _feedback(BuildContext context) {
    return BsSectionCard(
      title: 'Feedback',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _usageText('Error, confirmation, and loading'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              FilledButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Document saved successfully'),
                    action: SnackBarAction(label: 'Undo', onPressed: () {}),
                    duration: const Duration(seconds: 3),
                  ),
                ),
                child: const Text('SnackBar'),
              ),
              OutlinedButton(
                onPressed: _showDialog,
                child: const Text('AlertDialog'),
              ),
              OutlinedButton(
                onPressed: _showSimpleDialog,
                child: const Text('SimpleDialog'),
              ),
              const Tooltip(
                message: 'Tooltip for extra help',
                child: Icon(Icons.info_outline),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Progress Indicators:'),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const SizedBox(
                width: 26,
                height: 26,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
              const SizedBox(
                width: 26,
                height: 26,
                child: CircularProgressIndicator.adaptive(strokeWidth: 3),
              ),
              SizedBox(
                width: 150,
                child: const LinearProgressIndicator(value: 0.6),
              ),
              SizedBox(width: 150, child: const LinearProgressIndicator()),
            ],
          ),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _WidgetChip(label: 'SnackBar'),
              _WidgetChip(label: 'AlertDialog'),
              _WidgetChip(label: 'SimpleDialog'),
              _WidgetChip(label: 'Tooltip'),
              _WidgetChip(label: 'CircularProgressIndicator'),
              _WidgetChip(label: 'LinearProgressIndicator'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dateAndTime(BuildContext context) {
    return BsSectionCard(
      title: 'Date And Time',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _usageText('DOB, invoice date, and reporting period'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              OutlinedButton(
                onPressed: _pickDate,
                child: Text(
                  _selectedDate == null
                      ? 'showDatePicker'
                      : _selectedDate!.toIso8601String().substring(0, 10),
                ),
              ),
              OutlinedButton(
                onPressed: _pickTime,
                child: Text(
                  _selectedTime == null
                      ? 'showTimePicker'
                      : _selectedTime!.format(context),
                ),
              ),
              OutlinedButton(
                onPressed: _pickRange,
                child: Text(
                  _selectedRange == null
                      ? 'DateRangePickerDialog'
                      : '${_selectedRange!.start.toIso8601String().substring(0, 10)} to ${_selectedRange!.end.toIso8601String().substring(0, 10)}',
                ),
              ),
              SizedBox(
                width: 260,
                height: 250,
                child: CalendarDatePicker(
                  initialDate: _GalleryConstants.calendarDate,
                  firstDate: _GalleryConstants.firstDate,
                  lastDate: _GalleryConstants.lastDate,
                  onDateChanged: _GalleryConstants.noopDate,
                ),
              ),
            ],
          ),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _WidgetChip(label: 'showDatePicker'),
              _WidgetChip(label: 'showTimePicker'),
              _WidgetChip(label: 'DateRangePickerDialog'),
              _WidgetChip(label: 'CalendarDatePicker'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _menus(BuildContext context) {
    return BsSectionCard(
      title: 'Menus',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _usageText('Row actions and application menu'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              PopupMenuButton<String>(
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'edit', child: Text('Edit')),
                  PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
                child: const OutlinedButton(
                  onPressed: null,
                  child: Text('PopupMenuButton'),
                ),
              ),
              const DropdownMenu<String>(
                label: Text('DropdownMenu'),
                width: 180,
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: 'print', label: 'Print'),
                  DropdownMenuEntry(value: 'export', label: 'Export'),
                ],
              ),
              MenuAnchor(
                controller: _menuController,
                menuChildren: [
                  MenuItemButton(
                    onPressed: () => _menuController.close(),
                    child: const Text('Approve'),
                  ),
                  MenuItemButton(
                    onPressed: () => _menuController.close(),
                    child: const Text('Reject'),
                  ),
                ],
                builder: (context, controller, child) => FilledButton.tonal(
                  onPressed: () => controller.isOpen
                      ? controller.close()
                      : controller.open(),
                  child: const Text('MenuAnchor'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          MenuBar(
            children: [
              SubmenuButton(
                menuChildren: [
                  MenuItemButton(onPressed: () {}, child: const Text('New')),
                  MenuItemButton(onPressed: () {}, child: const Text('Open')),
                ],
                child: const Text('MenuBar'),
              ),
            ],
          ),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _WidgetChip(label: 'PopupMenuButton'),
              _WidgetChip(label: 'DropdownMenu'),
              _WidgetChip(label: 'MenuAnchor'),
              _WidgetChip(label: 'MenuBar'),
              _WidgetChip(label: 'SubmenuButton'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _visualDisplay(BuildContext context) {
    return BsSectionCard(
      title: 'Visual Display',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _usageText('Status chip, user avatar, and indicators'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text('Text'),
              const Icon(Icons.verified_outlined),
              const Chip(label: Text('Chip')),
              const Badge(label: Text('3'), child: Icon(Icons.mail_outline)),
              const CircleAvatar(child: Text('YY')),
              SizedBox(
                width: 64,
                height: 42,
                child: Image.network(
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 92, height: 42, child: Placeholder()),
            ],
          ),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _WidgetChip(label: 'Text'),
              _WidgetChip(label: 'Icon'),
              _WidgetChip(label: 'Chip'),
              _WidgetChip(label: 'Badge'),
              _WidgetChip(label: 'CircleAvatar'),
              _WidgetChip(label: 'Image'),
              _WidgetChip(label: 'Placeholder'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _materialSurfaces(BuildContext context) {
    return BsSectionCard(
      title: 'Material Surfaces',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _usageText('Screens and context panels'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              SizedBox(
                width: 180,
                height: 84,
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(8),
                  child: const Center(child: Text('Material')),
                ),
              ),
              const SizedBox(
                width: 180,
                height: 84,
                child: Card(child: Center(child: Text('Card'))),
              ),
              SizedBox(
                width: 180,
                height: 84,
                child: Drawer(
                  child: ListTile(
                    dense: true,
                    leading: const Icon(Icons.menu),
                    title: const Text('Drawer'),
                    onTap: () {},
                  ),
                ),
              ),
              SizedBox(
                width: 260,
                height: 84,
                child: Scaffold(
                  bottomNavigationBar: BottomAppBar(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.home_outlined),
                        ),
                        const Text('BottomAppBar'),
                      ],
                    ),
                  ),
                  body: const Center(child: Text('Surface preview')),
                ),
              ),
              const SizedBox(
                width: 260,
                height: 150,
                child: NavigationDrawer(
                  selectedIndex: 0,
                  children: [
                    NavigationDrawerDestination(
                      icon: Icon(Icons.dashboard_outlined),
                      label: Text('NavigationDrawer'),
                    ),
                    NavigationDrawerDestination(
                      icon: Icon(Icons.settings_outlined),
                      label: Text('Settings'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _WidgetChip(label: 'Material'),
              _WidgetChip(label: 'Card'),
              _WidgetChip(label: 'Drawer'),
              _WidgetChip(label: 'BottomAppBar'),
              _WidgetChip(label: 'NavigationDrawer'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stepper(BuildContext context) {
    return BsSectionCard(
      title: 'Stepper',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _usageText('Multi-step forms and wizards'),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: Stepper(
              currentStep: _stepperIndex,
              steps: const [
                Step(
                  title: Text('Basic Info'),
                  content: Text('Supplier/Partner details'),
                  isActive: true,
                ),
                Step(
                  title: Text('Address'),
                  content: Text('Location information'),
                  isActive: true,
                ),
                Step(
                  title: Text('Review'),
                  content: Text('Confirm all entries'),
                  isActive: false,
                ),
              ],
              onStepContinue: () {
                if (_stepperIndex < 2) {
                  setState(() => _stepperIndex++);
                }
              },
              onStepCancel: () {
                if (_stepperIndex > 0) {
                  setState(() => _stepperIndex--);
                }
              },
              onStepTapped: (index) => setState(() => _stepperIndex = index),
            ),
          ),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [_WidgetChip(label: 'Stepper')],
          ),
        ],
      ),
    );
  }

  Widget _gestures(BuildContext context) {
    return BsSectionCard(
      title: 'Gesture & Ink',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _usageText('Interactive containers and ripple effects'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              InkWell(
                onTap: () => ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('InkWell tapped'))),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('InkWell (Ripple)'),
                ),
              ),
              InkResponse(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('InkResponse tapped')),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('InkResponse'),
                ),
              ),
              GestureDetector(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('GestureDetector tapped')),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('GestureDetector'),
                ),
              ),
            ],
          ),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _WidgetChip(label: 'InkWell'),
              _WidgetChip(label: 'InkResponse'),
              _WidgetChip(label: 'GestureDetector'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _reorderableList(BuildContext context) {
    return BsSectionCard(
      title: 'Reorderable List',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _usageText('Sortable lists and drag-and-drop'),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: ReorderableListView(
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final item = _reorderableItems.removeAt(oldIndex);
                  _reorderableItems.insert(newIndex, item);
                });
              },
              children: _reorderableItems.map((item) {
                return ListTile(
                  key: ValueKey(item),
                  title: Text('Item $item'),
                  leading: const Icon(Icons.drag_handle),
                  trailing: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          _reorderableItems.remove(item);
                        });
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [_WidgetChip(label: 'ReorderableListView')],
          ),
        ],
      ),
    );
  }

  Widget _bottomSheetSection(BuildContext context) {
    return BsSectionCard(
      title: 'Bottom Sheets',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _usageText('Modal and persistent bottom sheets'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton(
                onPressed: _showBottomSheet,
                child: const Text('Modal BottomSheet'),
              ),
              FilledButton.tonal(
                onPressed: () {
                  Scaffold.of(context).showBottomSheet(
                    (context) => Container(
                      padding: const EdgeInsets.all(16),
                      height: 100,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Persistent BottomSheet',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text('Use for filters or quick actions'),
                        ],
                      ),
                    ),
                  );
                },
                child: const Text('Persistent BottomSheet'),
              ),
            ],
          ),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _WidgetChip(label: 'showModalBottomSheet'),
              _WidgetChip(label: 'showBottomSheet'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dialogVariations(BuildContext context) {
    return BsSectionCard(
      title: 'Dialog Variations',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _usageText('Different dialog types for various scenarios'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton(
                onPressed: _showDialog,
                child: const Text('AlertDialog'),
              ),
              OutlinedButton(
                onPressed: _showSimpleDialog,
                child: const Text('SimpleDialog'),
              ),
              OutlinedButton(
                onPressed: _showAboutDialog,
                child: const Text('AboutDialog'),
              ),
              OutlinedButton(
                onPressed: _showCustomDialog,
                child: const Text('Custom Dialog'),
              ),
            ],
          ),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _WidgetChip(label: 'AlertDialog'),
              _WidgetChip(label: 'SimpleDialog'),
              _WidgetChip(label: 'AboutDialog'),
              _WidgetChip(label: 'Dialog'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _usageText(String text) {
    return Builder(
      builder: (context) => Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  BoxDecoration _demoBorder(BuildContext context) {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      borderRadius: BorderRadius.circular(8),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Modal BottomSheet',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Use for quick popup entry or filters.'),
              SizedBox(height: 16),
              FilledButton(onPressed: null, child: Text('Apply Filter')),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('AlertDialog'),
        content: const Text('Use this for confirmation and important errors.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _showSimpleDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('SimpleDialog'),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Option A'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Option B'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Option C'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'BizSoft ERP',
      applicationVersion: '2.0.0',
      children: const [
        Text('Built with Flutter and Material Design'),
        SizedBox(height: 8),
        Text('© 2024 BizSoft Systems'),
      ],
    );
  }

  void _showCustomDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.warning, size: 48, color: Colors.orange),
              const SizedBox(height: 16),
              const Text(
                'Custom Dialog',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('This is a fully customizable dialog.'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? today,
      firstDate: DateTime(today.year - 10),
      lastDate: DateTime(today.year + 10),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  Future<void> _pickRange() async {
    final today = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(today.year - 10),
      lastDate: DateTime(today.year + 10),
      initialDateRange:
          _selectedRange ??
          DateTimeRange(start: today, end: today.add(const Duration(days: 7))),
    );
    if (picked != null) {
      setState(() => _selectedRange = picked);
    }
  }
}

class _WidgetChip extends StatelessWidget {
  const _WidgetChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(label), visualDensity: VisualDensity.compact);
  }
}

class _GalleryConstants {
  const _GalleryConstants._();

  static final calendarDate = DateTime(2026, 6, 11);
  static final firstDate = DateTime(2020);
  static final lastDate = DateTime(2030);

  static void noopDate(DateTime value) {}
}
