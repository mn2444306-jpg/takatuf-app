import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/di/injector.dart';
import '../../../residence_places/domain/repositories/residence_places_repository.dart';
import '../../../villages/domain/repositories/villages_repository.dart';

class VillageDropdownField extends StatelessWidget {
  const VillageDropdownField({
    super.key,
    required this.selectedId,
    required this.onChanged,
  });

  final int? selectedId;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Village>>(
      stream: injector<VillagesRepository>().watchAll(),
      builder: (context, snapshot) {
        final villages = snapshot.data ?? const [];
        return DropdownMenu<int>(
          // مفتاح يتغيّر عند اكتمال تحميل القائمة، حتى يعيد DropdownMenu بناء
          // حالته الداخلية ويعرض initialSelection الصحيح بدل تجاهله لأنه
          // طُبِّق أول مرة بينما كانت القائمة لا تزال فارغة (Stream غير متزامن).
          key: ValueKey('village-${villages.length}-$selectedId'),
          initialSelection: selectedId,
          expandedInsets: EdgeInsets.zero,
          enableFilter: true,
          requestFocusOnTap: true,
          label: const Text('القرية'),
          helperText: villages.isEmpty ? 'أضف قرية أولاً من الإعدادات' : null,
          dropdownMenuEntries: [
            for (final village in villages)
              DropdownMenuEntry(value: village.id, label: village.name),
          ],
          onSelected: onChanged,
        );
      },
    );
  }
}

class ResidencePlaceDropdownField extends StatelessWidget {
  const ResidencePlaceDropdownField({
    super.key,
    required this.selectedId,
    required this.onChanged,
  });

  final int? selectedId;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ResidencePlace>>(
      stream: injector<ResidencePlacesRepository>().watchAll(),
      builder: (context, snapshot) {
        final places = snapshot.data ?? const [];
        return DropdownMenu<int>(
          key: ValueKey('place-${places.length}-$selectedId'),
          initialSelection: selectedId,
          expandedInsets: EdgeInsets.zero,
          enableFilter: true,
          requestFocusOnTap: true,
          label: const Text('مكان السكن'),
          helperText: places.isEmpty ? 'أضف مكان سكن أولاً من الإعدادات' : null,
          dropdownMenuEntries: [
            for (final place in places)
              DropdownMenuEntry(value: place.id, label: place.name),
          ],
          onSelected: onChanged,
        );
      },
    );
  }
}
