import 'package:go_router/go_router.dart';

import '../../features/aid_types/presentation/pages/aid_types_page.dart';
import '../../features/beneficiaries/presentation/pages/beneficiaries_page.dart';
import '../../features/campaigns/presentation/pages/campaign_details_page.dart';
import '../../features/campaigns/presentation/pages/campaign_wizard_page.dart';
import '../../features/campaigns/presentation/pages/campaigns_list_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/residence_places/presentation/pages/residence_places_page.dart';
import '../../features/villages/presentation/pages/villages_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const DashboardPage()),
    GoRoute(
      path: '/beneficiaries',
      builder: (context, state) => const BeneficiariesPage(),
    ),
    GoRoute(
      path: '/villages',
      builder: (context, state) => const VillagesPage(),
    ),
    GoRoute(
      path: '/residence-places',
      builder: (context, state) => const ResidencePlacesPage(),
    ),
    GoRoute(
      path: '/aid-types',
      builder: (context, state) => const AidTypesPage(),
    ),
    GoRoute(
      path: '/campaigns',
      builder: (context, state) => const CampaignsListPage(),
    ),
    GoRoute(
      path: '/campaigns/new',
      builder: (context, state) => const CampaignWizardPage(),
    ),
    GoRoute(
      path: '/campaigns/:id',
      builder: (context, state) => CampaignDetailsPage(
        campaignId: int.parse(state.pathParameters['id']!),
      ),
    ),
  ],
);
