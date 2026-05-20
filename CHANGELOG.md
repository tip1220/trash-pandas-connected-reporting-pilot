# Changelog

## 2026-05-16

## Connected Reporting Reframe

### Changed

- Reframed the project around the central thesis: siloed reports show activity, connected reporting shows decisions.
- Shifted outward-facing language away from a generic dashboard build and toward a connected reporting proof of concept.
- Updated project positioning to show what becomes possible when ticketing, scans, promotions, merch, concessions, group sales, engagement, and CRM follow-up data are analyzed together.
- Reframed the project as a solution for growth-market sports organizations that may need practical ways to connect business data across departments.
- Updated dashboard page names:
  - Connected Homestand Intelligence
  - Promotion Value Scorecard
  - CRM Follow-Up Queue
- Updated KPI language to better reflect connected reporting value:
  - Demand Created
  - Attendance Converted
  - Demand-to-Attendance Conversion
  - Lost Attendance Opportunity
  - Value After Arrival
  - Future Value Pipeline
  - Actionable CRM Signals
  - Connected Value Score

### Updated

- Updated `README.md` around the connected reporting thesis.
- Updated `PROJECT_CHARTER.md` around connected reporting value.
- Updated `BUSINESS_QUESTIONS.md` around the main question: what new decisions become possible when sports business data sources are connected?
- Updated `DASHBOARD_PLAN.md` around siloed reports becoming actionable insights.
- Updated `TABLEAU_BUILD_GUIDE.md` with connected KPI labels and page-level story.
- Updated `sql/05_business_question_queries.sql` with connected reporting comments, aliases, and query framing.
- Added `REQUIREMENTS.md` as the project requirements document.
- Updated `TASK_TRACKER.md` to reflect the pre-Tableau documentation reframe.
- Updated `BUILD_ORDER.md` to position Tableau Public as the next required phase.

### Notes

- The connected reporting reframe did not require rebuilding the data, Snowflake tables, or Snowflake analytics views.
- The existing data model already supports the new story because it connects ticketing, scans, promotions, merch, concessions, group sales, engagement, and CRM follow-up data.
- The changes were made in the presentation, documentation, query labeling, and dashboard planning layers.

---

## 2026-05-16

## Snowflake Reporting Layer Completed

### Added

- Added Snowflake reporting layer for the Trash Pandas Connected Reporting Pilot.
- Created Snowflake setup SQL:
  - `sql/00_snowflake_setup.sql`
- Created raw export table SQL:
  - `sql/01_create_export_tables.sql`
- Created Snowflake load SQL:
  - `sql/02_load_export_tables.sql`
- Created Snowflake validation SQL:
  - `sql/03_validate_export_tables.sql`
- Created Snowflake analytics views:
  - `sql/04_create_analytics_views.sql`
- Created business-question SQL:
  - `sql/05_business_question_queries.sql`
- Added Snowflake documentation:
  - `SNOWFLAKE_LOAD_GUIDE.md`
  - `SNOWFLAKE_SCHEMA_PLAN.md`

### Snowflake Objects Created

- Warehouse:
  - `TP_REPORTING_WH`
- Database:
  - `TRASH_PANDAS_CONNECTED_REPORTING`
- Schemas:
  - `RAW`
  - `ANALYTICS`
  - `QA`
- Stage:
  - `RAW.TP_EXPORT_STAGE`
- File format:
  - `RAW.CSV_EXPORT_FORMAT`

### Raw Tables Created

- `RAW.HOMESTAND_SUMMARY`
- `RAW.PROMOTION_SCORECARD`
- `RAW.CRM_FOLLOW_UP_QUEUE`

### Analytics Views Created

- `ANALYTICS.V_HOMESTAND_SUMMARY`
- `ANALYTICS.V_PROMOTION_SCORECARD`
- `ANALYTICS.V_CRM_FOLLOW_UP_QUEUE`
- `ANALYTICS.V_EXECUTIVE_HOMESTAND_OVERVIEW`
- `ANALYTICS.V_PROMOTION_RECOMMENDATION_SUMMARY`
- `ANALYTICS.V_CRM_ACTION_BUCKET_SUMMARY`

### Loaded

- Loaded final dashboard-ready exports into Snowflake:
  - `data/exports/homestand_summary.csv`
  - `data/exports/promotion_scorecard.csv`
  - `data/exports/crm_follow_up_queue.csv`

### Validated

- Confirmed Snowflake row counts:
  - `RAW.HOMESTAND_SUMMARY`: 34 rows
  - `RAW.PROMOTION_SCORECARD`: 233 rows
  - `RAW.CRM_FOLLOW_UP_QUEUE`: 15,000 rows
- Confirmed key Snowflake totals:
  - Homestand tickets sold: 1,274,234
  - Homestand scanned attendance: 1,126,560
  - Homestand total revenue indicator: 28,655,060.87
  - CRM future revenue opportunity: 12,605,270.19
- Added validation checks for:
  - duplicate homestand keys
  - duplicate promo IDs
  - duplicate follow-up IDs
  - invalid promotion recommendations
  - invalid CRM entity mapping
  - invalid scan and no-show rates
  - negative revenue values

### Fixed

- Fixed Snowflake table type issue where boolean CSV fields loaded as `True` / `False`, but initial table definitions expected numeric flag values.
- Updated `RAW.PROMOTION_SCORECARD` flag fields to `BOOLEAN`.
- Updated `RAW.CRM_FOLLOW_UP_QUEUE` flag fields to `BOOLEAN`.
- Updated `sql/01_create_export_tables.sql` so the repo matches the actual final export files.

### Changed

- Updated `README.md` with Snowflake reporting layer section.
- Updated `TASK_TRACKER.md` to mark Snowflake reporting layer complete.
- Updated `BUILD_ORDER.md` to make Tableau Public the next required phase.
- Clarified that Tableau Public will use final CSV exports while Snowflake proves the warehouse, SQL validation, analytics view, and business-question layer.

### Notes

- Snowflake is complete for the current build.
- The project now shows a path from Python-generated data to validated CSV exports, Snowflake reporting tables, analytics views, business-question SQL, and Tableau-ready outputs.
- Tableau Public dashboard build is the next phase.

---

## 2026-05-15

## Project Reset

### Changed

- Renamed project direction from CRM Analytics Pilot to Connected Reporting Pilot.
- Updated project focus from a CRM-only dashboard to a connected reporting proof of concept.
- Repositioned the project around the value of connecting separate sports business reports.
- Clarified that the project does not claim internal Trash Pandas data access.
- Clarified public vs synthetic data boundaries.
- Reworked the portfolio story around reporting structure, not system replacement.
- Locked the current build around three final dashboard outputs:
  - Homestand summary
  - Promotion scorecard
  - CRM follow-up queue

### Added

- Added final dashboard-ready export files:
  - `data/exports/homestand_summary.csv`
  - `data/exports/promotion_scorecard.csv`
  - `data/exports/crm_follow_up_queue.csv`
  - `data/exports/export_manifest.csv`
- Added final export generation summaries:
  - `data/exports/homestand_summary_generation_summary.csv`
  - `data/exports/promotion_scorecard_generation_summary.csv`
  - `data/exports/crm_follow_up_queue_generation_summary.csv`
- Added final export quality summaries:
  - `data/exports/homestand_summary_quality_summary.csv`
  - `data/exports/promotion_scorecard_quality_summary.csv`
  - `data/exports/crm_follow_up_queue_quality_summary.csv`

### Final Modeled Output

- Home games modeled: 207
- Homestands modeled: 34
- Promotion rows: 233
- Synthetic fans: 45,000
- Ticket orders: 343,165
- Tickets sold: 1,274,234
- Scanned attendance: 1,126,560
- Merch transactions: 45,557
- Concession transactions: 314,165
- Sponsorship activations: 93
- Fan engagement rows: 135,112
- Follow-up opportunities: 52,416
- CRM follow-up queue rows: 15,000

### Validated

- Confirmed homestand export reconciles to source files.
- Confirmed promotion scorecard export includes recommendation logic:
  - Return: 6
  - Rework: 47
  - Retire: 7
  - Review: 173
- Confirmed CRM queue entity mapping passes fan/account logic.
- Confirmed final export files are ready for Snowflake and Tableau Public.

### Notes

- The project should not be described as a real CRM implementation.
- The project should not claim internal Trash Pandas data access.
- The project should be described as a connected reporting proof of concept using public anchors and synthetic internal-style data.

---

## 2026-05-06

## Earlier CRM Pilot Foundation

### Added

- Created SQL scoring layer during the earlier CRM analytics pilot phase.
- Built CRM scoring views for fan scoring, game performance, group sales opportunities, promo performance, season summary, and CRM action summaries.
- Created Python export script for Tableau-ready CSVs.
- Exported early Tableau-ready CSV files.

### Validated

- Confirmed early fan scoring row counts.
- Confirmed early game-level attendance control totals.
- Confirmed early group sales opportunity outputs.
- Confirmed season-level public attendance summary:
  - 2023: 69 home games, 314,306 attendance
  - 2024: 69 home games, 308,267 attendance
  - 2025: 69 home games, 275,423 attendance

### Notes

- This earlier CRM-focused work was later superseded by the Connected Reporting Pilot direction.
- The useful concept that carried forward was the need to connect fan behavior, ticketing, promotions, group sales, and follow-up action.

---

## 2026-05-05

## Public Schedule, Promotions, and Attendance Foundation

### Added

- Added raw multi-season schedule files for the Rocket City Trash Pandas:
  - `data/raw/schedule_2023.csv`
  - `data/raw/schedule_2024.csv`
  - `data/raw/schedule_2025.csv`
- Added public promotional records files:
  - `data/raw/promotions_2023.csv`
  - `data/raw/promotions_2024.csv`
  - `data/raw/promotions_2025.csv`
- Built promotion files as one row per promo, not one row per game, so games can support multiple promo records.
- Collected public game-log attendance data for 2023, 2024, and 2025.
- Created attendance actuals from public game logs.
- Reconciled public attendance records back to planned schedule game IDs.

### Changed

- Normalized promotion category naming across all promotion files.
- Standardized schedule file headers to support repeatable loading and analysis.
- Built synthetic ticket orders around public attendance anchors instead of arbitrary simulated volume.

### Validated

- Confirmed 207 home attendance records across 2023-2025.
- Confirmed attendance by season:
  - 2023: 69 home games, 314,306 attendance
  - 2024: 69 home games, 308,267 attendance
  - 2025: 69 home games, 275,423 attendance
- Confirmed 207 home games across 2023-2025.
- Confirmed 69 home games per season.

### Notes

- Attendance reconciliation accounts for rainouts, makeups, doubleheaders, and actual game-log dates.
- Public attendance is used as an anchor and is not treated as scanned attendance.
- Synthetic records remain fictional, but they are anchored to public game and attendance context.