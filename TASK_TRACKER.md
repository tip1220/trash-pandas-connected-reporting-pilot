# Task Tracker

## Project

Trash Pandas Connected Reporting Pilot

## Last Updated

2026-05-16

## Current Project Status

The Python data generation, synthetic data modeling, quality checks, Tableau-ready export files, Snowflake reporting layer, and connected-reporting documentation refresh are complete.

The current phase is **Tableau Public dashboard build**.

Current phase:

Build the Tableau Public dashboard using the final export files.

Primary dashboard thesis:

Siloed reports show activity. Connected reporting shows decisions.

Snowflake status:

Complete.

Documentation status:

Complete for current pre-Tableau phase.

Tableau status:

Not started.

---

## Completed Work

### 1. Project Direction Reset

Status: Complete

Completed:

- Reframed the project from Trash Pandas CRM Analytics Pilot to Trash Pandas Connected Reporting Pilot
- Shifted the project from “they need a CRM” to “they may need connected reporting”
- Defined the project as a reporting structure proof of concept
- Confirmed the project does not assume internal Trash Pandas data access
- Confirmed public, synthetic, and internal-style data boundaries
- Confirmed the audience is leadership first, then sales, marketing, recruiters, and hiring managers

Key files:

- `README.md`
- `PROJECT_CHARTER.md`
- `BUSINESS_QUESTIONS.md`
- `DATA_SOURCE_MAP.md`
- `DATA_ASSUMPTIONS.md`
- `SYNTHETIC_DATA_PLAN.md`
- `SNOWFLAKE_SCHEMA_PLAN.md`
- `DASHBOARD_PLAN.md`
- `BUILD_ORDER.md`

---

### 2. Connected Reporting Reframe

Status: Complete

Completed:

- Reframed the project around the central thesis: siloed reports show activity, connected reporting shows decisions
- Shifted outward-facing language away from a generic dashboard build and toward a connected reporting proof of concept
- Updated project positioning to show what becomes possible when ticketing, scans, promotions, merch, concessions, group sales, engagement, and CRM follow-up data are analyzed together
- Reframed the project as a solution for growth-market sports organizations that may need practical ways to connect business data across departments
- Updated KPI language to better reflect connected reporting value

Key language:

- Demand Created
- Attendance Converted
- Demand-to-Attendance Conversion
- Lost Attendance Opportunity
- Value After Arrival
- Future Value Pipeline
- Actionable CRM Signals
- Connected Value Score

Key files updated:

- `README.md`
- `PROJECT_CHARTER.md`
- `BUSINESS_QUESTIONS.md`
- `DASHBOARD_PLAN.md`
- `TABLEAU_BUILD_GUIDE.md`
- `sql/05_business_question_queries.sql`

---

### 3. Data Source Map

Status: Complete

Completed:

- Mapped source areas across ticketing, promotions, scans, CRM, group sales, merch, concessions, sponsorship, engagement, and revenue reporting
- Defined source grain
- Defined key fields
- Defined join keys
- Defined reporting purpose
- Separated public, synthetic, and internal-only data types
- Clarified sponsorship as context only, not ROI analysis

Primary file:

- `DATA_SOURCE_MAP.md`

---

### 4. Public Data Foundation

Status: Complete

Completed:

- Built games foundation for 2023-2025 home games
- Confirmed 207 total home games
- Confirmed 69 home games per season
- Built promotion foundation
- Built public attendance foundation
- Matched public attendance where available
- Logged public data sources
- Added public data quality checks
- Added promotion quality checks

Key outputs:

- `data/processed/games_clean.csv`
- `data/processed/promotions_clean.csv`
- `data/processed/attendance_clean.csv`
- `data/public/public_source_log.csv`
- `data/processed/public_data_quality_summary.csv`
- `data/processed/promotion_quality_summary.csv`

Status notes:

- Public attendance is used as an anchor.
- Public attendance is not treated as scanned attendance.
- Unmatched public attendance rows are documented instead of forced.

---

### 5. Synthetic Fan Layer

Status: Complete

Completed:

- Generated 45,000 synthetic fans
- Generated fan segments
- Fixed lifecycle segment logic so each fan has one lifecycle segment
- Confirmed fan segment quality checks pass

Key outputs:

- `data/synthetic/fans.csv`
- `data/synthetic/fan_segments.csv`
- `data/synthetic/fan_generation_summary.csv`
- `data/synthetic/fan_quality_summary.csv`

Key scripts:

- `python/data_generation/01_generate_fans.py`
- `python/quality_checks/04_fan_quality_checks.py`

---

### 6. Synthetic Ticketing Layer

Status: Complete

Completed:

- Generated synthetic ticket orders
- Generated ticket order items
- Generated ticket scans
- Added ticket quality checks
- Added scan quality checks

Key outputs:

- `data/synthetic/ticket_orders.csv`
- `data/synthetic/ticket_order_items.csv`
- `data/synthetic/ticket_scans.csv`
- `data/synthetic/ticket_generation_summary.csv`
- `data/synthetic/ticket_scan_generation_summary.csv`
- `data/synthetic/ticket_quality_summary.csv`
- `data/synthetic/scan_quality_summary.csv`

Key scripts:

- `python/data_generation/02_generate_ticket_orders.py`
- `python/data_generation/03_generate_ticket_scans.py`
- `python/quality_checks/05_ticket_quality_checks.py`
- `python/quality_checks/06_scan_quality_checks.py`

Final modeled totals:

- Ticket orders: 343,165
- Tickets sold: 1,274,234
- Scanned attendance: 1,126,560
- No-show tickets: 147,674

---

### 7. Group Sales Layer

Status: Complete

Completed:

- Generated synthetic group accounts
- Generated synthetic group sales
- Appended group orders, order items, and scans into ticketing layer
- Added group sales quality checks

Key outputs:

- `data/synthetic/group_accounts.csv`
- `data/synthetic/group_sales.csv`
- `data/synthetic/group_sales_generation_summary.csv`
- `data/synthetic/group_quality_summary.csv`

Key scripts:

- `python/data_generation/04_generate_group_sales.py`
- `python/quality_checks/07_group_quality_checks.py`

Final modeled totals:

- Group accounts: 1,200
- Group sales: 3,600
- Group tickets: 190,669
- Group revenue: 2,603,410.24

---

### 8. Merch Layer

Status: Complete

Completed:

- Generated synthetic merch transactions
- Linked 60-75% of merch transactions to `fan_id`
- Added merch quality checks

Key outputs:

- `data/synthetic/merch_transactions.csv`
- `data/synthetic/merch_generation_summary.csv`
- `data/synthetic/merch_quality_summary.csv`

Key scripts:

- `python/data_generation/05_generate_merch_transactions.py`
- `python/quality_checks/08_merch_quality_checks.py`

Final modeled totals:

- Merch transactions: 45,557
- Merch net sales: 1,765,481.28
- Fan match share: 68.43%

---

### 9. Concession Layer

Status: Complete

Completed:

- Generated synthetic concession transactions
- Linked 35-55% of concession transactions to `fan_id`
- Added concession quality checks

Key outputs:

- `data/synthetic/concession_transactions.csv`
- `data/synthetic/concession_generation_summary.csv`
- `data/synthetic/concession_quality_summary.csv`

Key scripts:

- `python/data_generation/06_generate_concession_transactions.py`
- `python/quality_checks/09_concession_quality_checks.py`

Final modeled totals:

- Concession transactions: 314,165
- Concession net sales: 5,570,004.38
- Fan match share: 45.82%

---

### 10. Sponsorship Context Layer

Status: Complete

Completed:

- Generated synthetic sponsorship activations
- Treated sponsorship as context only
- Did not calculate sponsorship ROI
- Added sponsorship quality checks

Key outputs:

- `data/synthetic/sponsorship_activations.csv`
- `data/synthetic/sponsorship_activation_generation_summary.csv`
- `data/synthetic/sponsorship_quality_summary.csv`

Key scripts:

- `python/data_generation/07_generate_sponsorship_activations.py`
- `python/quality_checks/10_sponsorship_quality_checks.py`

Final modeled totals:

- Sponsorship activations: 93
- Games with sponsor activation: 86
- Unique sponsors: 64

---

### 11. Fan Engagement Layer

Status: Complete

Completed:

- Generated synthetic fan engagement rows
- Included email, SMS, web, in-park QR, survey, merch offer, concession offer, group interest, and premium interest signals
- Added fan engagement quality checks

Key outputs:

- `data/synthetic/fan_engagement.csv`
- `data/synthetic/fan_engagement_generation_summary.csv`
- `data/synthetic/fan_engagement_quality_summary.csv`

Key scripts:

- `python/data_generation/08_generate_fan_engagement.py`
- `python/quality_checks/11_fan_engagement_quality_checks.py`

Final modeled totals:

- Fan engagement rows: 135,112
- Unique engaged fans: 20,505
- Average engagement score: 26.54

Status note:

- App, social, and offer-response signals were not modeled for the current build.
- The current build still has enough behavioral signal from email, SMS, QR, survey, web, and offer-click activity.

---

### 12. Follow-Up Opportunity Layer

Status: Complete

Completed:

- Generated follow-up opportunity pool
- Generated CRM follow-up tasks
- Rebalanced CRM queue across service, sales, marketing, and group sales
- Added follow-up quality checks

Key outputs:

- `data/synthetic/follow_up_opportunities.csv`
- `data/synthetic/crm_follow_ups.csv`
- `data/synthetic/follow_up_generation_summary.csv`
- `data/synthetic/follow_up_quality_summary.csv`

Key scripts:

- `python/data_generation/09_generate_follow_up_opportunities.py`
- `python/data_generation/10_rebalance_crm_follow_ups.py`
- `python/quality_checks/12_follow_up_quality_checks.py`

Final modeled totals:

- Follow-up opportunities: 52,416
- CRM follow-up tasks: 15,000
- Service tasks: 5,890
- Sales tasks: 4,000
- Marketing tasks: 4,000
- Group sales tasks: 1,110

---

### 13. Homestand Summary Export

Status: Complete

Completed:

- Built Tableau-ready homestand summary export
- Added quality checks
- Confirmed export reconciles to source files

Key outputs:

- `data/exports/homestand_summary.csv`
- `data/exports/homestand_summary_generation_summary.csv`
- `data/exports/homestand_summary_quality_summary.csv`

Key scripts:

- `python/export_builds/01_build_homestand_summary.py`
- `python/quality_checks/13_homestand_summary_quality_checks.py`

Final modeled totals:

- Homestand rows: 34
- Total games: 207
- Tickets sold: 1,274,234
- Scanned attendance: 1,126,560
- Total revenue indicator: 28,655,060.87

---

### 14. Promotion Scorecard Export

Status: Complete

Completed:

- Built Tableau-ready promotion scorecard export
- Added quality checks
- Added promotion recommendations: return, rework, retire, review

Key outputs:

- `data/exports/promotion_scorecard.csv`
- `data/exports/promotion_scorecard_generation_summary.csv`
- `data/exports/promotion_scorecard_quality_summary.csv`

Key scripts:

- `python/export_builds/02_build_promotion_scorecard.py`
- `python/quality_checks/14_promotion_scorecard_quality_checks.py`

Final modeled totals:

- Promotion rows: 233
- Return recommendations: 6
- Rework recommendations: 47
- Retire recommendations: 7
- Review recommendations: 173
- Average total value index: 43.05

---

### 15. CRM Follow-Up Queue Export

Status: Complete

Completed:

- Built Tableau-ready CRM follow-up queue export
- Fixed entity mapping bug where blank fan/account IDs appeared as NaN
- Added quality checks
- Confirmed fan/account entity logic passes clean

Key outputs:

- `data/exports/crm_follow_up_queue.csv`
- `data/exports/crm_follow_up_queue_generation_summary.csv`
- `data/exports/crm_follow_up_queue_quality_summary.csv`

Key scripts:

- `python/export_builds/03_build_crm_follow_up_queue.py`
- `python/quality_checks/15_crm_follow_up_queue_quality_checks.py`

Final modeled totals:

- Queue rows: 15,000
- Fan tasks: 13,890
- Account tasks: 1,110
- High priority tasks: 13,923
- Medium priority tasks: 1,077
- Total future revenue opportunity: 12,605,270.19
- Average priority score: 93.78

---

### 16. Export Manifest

Status: Complete

Completed:

- Created manifest documenting final dashboard-ready exports
- Defined each export grain, dashboard use, source type, and description

Key output:

- `data/exports/export_manifest.csv`

---

### 17. Snowflake Reporting Layer

Status: Complete

Completed:

- Created Snowflake load guide
- Created Snowflake schema plan
- Created warehouse, database, schemas, file format, and internal stage
- Created raw export tables for the three final reporting exports
- Loaded final exports into Snowflake
- Validated row counts and key totals
- Created analytics views
- Created business-question SQL queries
- Reframed business-question SQL comments and aliases around connected reporting value
- Confirmed Snowflake layer supports the project’s connected reporting story

Key files:

- `SNOWFLAKE_LOAD_GUIDE.md`
- `SNOWFLAKE_SCHEMA_PLAN.md`
- `sql/00_snowflake_setup.sql`
- `sql/01_create_export_tables.sql`
- `sql/02_load_export_tables.sql`
- `sql/03_validate_export_tables.sql`
- `sql/04_create_analytics_views.sql`
- `sql/05_business_question_queries.sql`

Snowflake validation targets:

- Homestand row count: 34
- Promotion scorecard row count: 233
- CRM queue row count: 15,000
- Homestand tickets sold: 1,274,234
- Homestand scanned attendance: 1,126,560
- Homestand total revenue indicator: 28,655,060.87
- CRM future revenue opportunity: 12,605,270.19

---

### 18. Documentation Updates

Status: Complete for current pre-Tableau phase

Completed:

- Updated README around the connected reporting thesis
- Updated dashboard plan around siloed reports becoming actionable insights
- Updated Tableau build guide with connected KPI labels and page-level story
- Updated project charter around connected reporting value
- Updated business questions around the main question: what new decisions become possible when sports business data sources are connected?
- Updated Snowflake business-question SQL comments and aliases around connected reporting language
- Added project requirements document
- Updated build order for Tableau phase
- Added Snowflake schema plan
- Added Snowflake load guide
- Added Snowflake SQL files to repo
- Updated changelog with Snowflake and connected-reporting reframe notes

Key files:

- `README.md`
- `PROJECT_CHARTER.md`
- `BUSINESS_QUESTIONS.md`
- `REQUIREMENTS.md`
- `DASHBOARD_PLAN.md`
- `TABLEAU_BUILD_GUIDE.md`
- `BUILD_ORDER.md`
- `TASK_TRACKER.md`
- `CHANGELOG.md`
- `SNOWFLAKE_LOAD_GUIDE.md`
- `SNOWFLAKE_SCHEMA_PLAN.md`
- `sql/05_business_question_queries.sql`

Still needed after Tableau build:

- Add Tableau Public link
- Add dashboard screenshots
- Add final portfolio polish
- Add final project writeup if needed

---

## Current Required Phase

### Phase 19: Tableau Public Dashboard Build

Status: Next

Goal:

Build the three-page Tableau Public dashboard using the final dashboard-ready export files.

Primary data sources:

1. `data/exports/homestand_summary.csv`
2. `data/exports/promotion_scorecard.csv`
3. `data/exports/crm_follow_up_queue.csv`

Dashboard pages:

1. Connected Homestand Intelligence
2. Promotion Value Scorecard
3. CRM Follow-Up Queue

Status note:

The project has been reframed around connected reporting value.

The Snowflake reporting layer has been created, loaded, validated, queried, and documented.

Tableau Public will use the final CSV exports so the published dashboard remains accessible and portfolio-friendly.

---

## Tableau Phase

### Phase 19: Tableau Public Dashboard Build

Status: Next

Goal:

Build the three-page Tableau Public dashboard around this thesis:

Siloed reports show activity. Connected reporting shows decisions.

Primary data sources:

1. `data/exports/homestand_summary.csv`
2. `data/exports/promotion_scorecard.csv`
3. `data/exports/crm_follow_up_queue.csv`

Dashboard pages:

1. Connected Homestand Intelligence
2. Promotion Value Scorecard
3. CRM Follow-Up Queue

Primary guide:

- `TABLEAU_BUILD_GUIDE.md`

Status note:

Tableau Public will use CSV exports.

Snowflake has already been used as the warehouse/reporting layer, SQL validation layer, analytics view layer, and business-question layer.

---

## Current To-Do List

### Priority 1: Build Tableau Public Dashboard

Status: Next

Primary files:

- `data/exports/homestand_summary.csv`
- `data/exports/promotion_scorecard.csv`
- `data/exports/crm_follow_up_queue.csv`

Dashboard pages:

1. Connected Homestand Intelligence
2. Promotion Value Scorecard
3. CRM Follow-Up Queue

Dashboard thesis:

Siloed reports show activity. Connected reporting shows decisions.

---

### Priority 2: Add Tableau Link to README

Status: Waiting on Tableau dashboard

Tasks:

- Publish Tableau Public workbook
- Copy Tableau Public link
- Add link to README
- Commit README update

---

### Priority 3: Add Dashboard Screenshots

Status: Waiting on Tableau dashboard

Recommended folder:

- `images/`

Suggested files:

- `images/connected_homestand_intelligence.png`
- `images/promotion_value_scorecard.png`
- `images/crm_follow_up_queue.png`

---

### Priority 4: Final Portfolio Polish

Status: Not started

Tasks:

- Add final executive summary
- Add dashboard screenshots
- Add Tableau Public link
- Add Snowflake/SQL summary
- Confirm synthetic data disclaimer is clear
- Confirm no claim of internal Trash Pandas access
- Confirm project framing stays focused on connected reporting, not just dashboard creation

Potential file:

- `PORTFOLIO_WRITEUP.md`

---

### Priority 5: LinkedIn Post

Status: Not started

Potential file:

- `LINKEDIN_POST_DRAFT.md`

Focus:

- Coach-to-analyst story
- Sports business reporting
- Connected data silos
- Snowflake + SQL + Tableau
- GitHub project link
- Tableau dashboard link

---

## Current Build Definition

The current build is complete when:

- Python-generated source and synthetic files exist
- Final exports exist
- Final exports pass quality checks
- Snowflake reporting layer is built
- SQL validation queries pass
- Business-question SQL file exists
- Project documentation is reframed around connected reporting value
- Tableau Public dashboard is published
- README links to Tableau Public
- README clearly explains public vs synthetic data
- README explains Snowflake/SQL reporting layer
- README and dashboard clearly explain the connected-reporting thesis

Current build status:

- Data generation: Complete
- Quality checks: Complete
- Final exports: Complete
- Snowflake reporting layer: Complete
- SQL files: Complete
- Documentation reframe: Complete for pre-Tableau phase
- Tableau dashboard: Not started
- Final portfolio polish: Not started

---

## Next Immediate Step

Build the Tableau Public dashboard.

Start with:

- `TABLEAU_BUILD_GUIDE.md`

Use these final export files:

1. `data/exports/homestand_summary.csv`
2. `data/exports/promotion_scorecard.csv`
3. `data/exports/crm_follow_up_queue.csv`

Build Page 1 first:

- Connected Homestand Intelligence

First KPI sheets:

1. Demand Created
2. Attendance Converted
3. Demand-to-Attendance Conversion
4. Lost Attendance Opportunity
5. Value After Arrival
6. Connected Value Score

Do not change the Snowflake layer unless the dashboard build reveals a field issue.