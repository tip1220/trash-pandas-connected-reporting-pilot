# Requirements

## Project

Trash Pandas Connected Reporting Pilot

## Purpose

This document defines the requirements for the current build of the Trash Pandas Connected Reporting Pilot.

The project shows what a growth-market sports organization can learn when separate business data sources are connected into one reporting layer.

The project does not claim access to internal Trash Pandas data.

The project uses public data where available and synthetic internal-style data where real team system data would normally be required.

---

## Project Thesis

Siloed reports show activity.

Connected reporting shows decisions.

A ticket report can show what was sold.

A scan report can show who showed up.

A promotion report can show what was offered.

A merch or concession report can show what fans spent.

A CRM report can show who needs follow-up.

The value comes when those sources are connected into one reporting layer.

---

## Business Requirements

### BR1: Show value beyond attendance

The project must show that attendance alone does not tell the full business story.

The reporting layer must connect attendance with:

- ticket demand
- scanned attendance
- no-show behavior
- group sales
- merch sales
- concession sales
- fan engagement
- follow-up opportunities

### BR2: Separate demand from attendance conversion

The project must distinguish between tickets sold and scanned attendance.

Required metrics:

- demand created
- attendance converted
- demand-to-attendance conversion
- lost attendance opportunity
- no-show ticket quantity
- no-show rate

### BR3: Show value after fans arrive

The project must show the value created after fans enter the ballpark.

Required metrics:

- merch net sales
- concession net sales
- value after arrival
- in-park spend per scanned fan
- revenue per scanned fan

### BR4: Evaluate promotions beyond crowd size

The project must evaluate promotions using connected business value, not attendance alone.

Promotion evaluation must include:

- tickets sold
- scanned attendance
- scan rate
- no-show rate
- group tickets
- merch lift
- concession lift
- revenue per scanned fan
- repeat buyer rate
- follow-up opportunity
- total value index
- recommendation

### BR5: Turn connected behavior into CRM action

The project must create a prioritized CRM-style follow-up queue.

The queue must show:

- who should be contacted
- why they matter
- what action should happen next
- which team owns the follow-up
- future opportunity value
- priority score
- priority band

### BR6: Identify hidden fan value

The project must show that some fans may be undervalued if the team only looks at ticket spend.

Hidden value should consider:

- ticket spend
- scan reliability
- merch spend
- concession spend
- engagement
- repeat behavior
- family or theme-night behavior

### BR7: Support group account prioritization

The project must include account-level follow-up logic for group sales.

Group account priority should consider:

- group ticket quantity
- group revenue
- scan rate
- renewal status
- upsell opportunity
- account total value
- future revenue opportunity

---

## Data Requirements

### DR1: Public data

The project must use public data where available.

Public data may include:

- season
- game date
- opponent
- home/away flag
- day of week
- promotion name
- promotion category
- announced attendance where available

Public attendance must be treated as an anchor, not as scanned attendance.

### DR2: Synthetic internal-style data

The project must generate synthetic data where real internal team data would normally be required.

Synthetic data includes:

- fan profiles
- fan segments
- ticket orders
- ticket scans
- no-show behavior
- group accounts
- group sales
- merch transactions
- concession transactions
- sponsorship activation context
- fan engagement
- follow-up opportunities
- CRM follow-up tasks

Synthetic data must be clearly documented.

### DR3: Final dashboard-ready exports

The project must produce three final Tableau-ready exports:

| Export | Grain | Dashboard Use |
|---|---|---|
| `homestand_summary.csv` | One row per homestand | Connected Homestand Intelligence |
| `promotion_scorecard.csv` | One row per promotion per game | Promotion Value Scorecard |
| `crm_follow_up_queue.csv` | One row per follow-up task | CRM Follow-Up Queue |

### DR4: Required export location

Final exports must be stored in:

`data/exports/`

Required files:

- `data/exports/homestand_summary.csv`
- `data/exports/promotion_scorecard.csv`
- `data/exports/crm_follow_up_queue.csv`
- `data/exports/export_manifest.csv`

### DR5: Fan-linked spend assumptions

The project must model partial fan matching for in-park spend.

Assumptions:

- 60-75% of merch transactions are linked to `fan_id`
- 35-55% of concession transactions are linked to `fan_id`
- Remaining transactions are tied only to `game_id`

The project must not pretend every in-park transaction can be tied to a known fan.

---

## Snowflake Requirements

### SR1: Snowflake environment

The project must include a Snowflake reporting layer.

Required objects:

- Warehouse: `TP_REPORTING_WH`
- Database: `TRASH_PANDAS_CONNECTED_REPORTING`
- Schemas:
  - `RAW`
  - `ANALYTICS`
  - `QA`

### SR2: Raw tables

The final exports must be loaded into these raw tables:

- `RAW.HOMESTAND_SUMMARY`
- `RAW.PROMOTION_SCORECARD`
- `RAW.CRM_FOLLOW_UP_QUEUE`

### SR3: Analytics views

The project must create analytics views for reporting and SQL analysis.

Required views:

- `ANALYTICS.V_HOMESTAND_SUMMARY`
- `ANALYTICS.V_PROMOTION_SCORECARD`
- `ANALYTICS.V_CRM_FOLLOW_UP_QUEUE`
- `ANALYTICS.V_EXECUTIVE_HOMESTAND_OVERVIEW`
- `ANALYTICS.V_PROMOTION_RECOMMENDATION_SUMMARY`
- `ANALYTICS.V_CRM_ACTION_BUCKET_SUMMARY`

### SR4: Snowflake SQL files

The project must include these SQL files:

| File | Requirement |
|---|---|
| `sql/00_snowflake_setup.sql` | Creates warehouse, database, schemas, file format, and stage |
| `sql/01_create_export_tables.sql` | Creates raw export tables |
| `sql/02_load_export_tables.sql` | Loads final CSV exports into Snowflake |
| `sql/03_validate_export_tables.sql` | Validates row counts, totals, duplicates, and business rules |
| `sql/04_create_analytics_views.sql` | Creates analytics views |
| `sql/05_business_question_queries.sql` | Answers the core business questions with SQL |

### SR5: Snowflake validation targets

The Snowflake validation SQL must confirm:

| Check | Expected Value |
|---|---:|
| Homestand rows | 34 |
| Promotion scorecard rows | 233 |
| CRM queue rows | 15,000 |
| Homestand tickets sold | 1,274,234 |
| Homestand scanned attendance | 1,126,560 |
| Homestand total revenue indicator | 28,655,060.87 |
| CRM future revenue opportunity | 12,605,270.19 |

### SR6: Snowflake validation rules

Validation must also check:

- duplicate homestand keys
- duplicate promo IDs
- duplicate follow-up IDs
- invalid promotion recommendations
- invalid CRM entity mapping
- invalid scan rates
- invalid no-show rates
- negative revenue values

---

## Tableau Requirements

### TR1: Tableau Public dashboard

The project must produce a Tableau Public dashboard using the final CSV exports.

Tableau Public should use CSV exports instead of a live Snowflake connection so the dashboard remains accessible and portfolio-friendly.

### TR2: Dashboard pages

The dashboard must include three pages:

1. Connected Homestand Intelligence
2. Promotion Value Scorecard
3. CRM Follow-Up Queue

### TR3: Dashboard source note

Each dashboard page must include a clear source note:

Public data is used where available. Internal-style ticketing, scan, merch, concessions, engagement, group sales, and CRM fields are synthetic and used only to demonstrate connected reporting structure.

### TR4: Page 1 requirements

Connected Homestand Intelligence must answer:

Which homestands created value across ticket demand, attendance conversion, in-park spend, and follow-up opportunity?

Required KPI labels:

- Demand Created
- Attendance Converted
- Demand-to-Attendance Conversion
- Lost Attendance Opportunity
- Value After Arrival
- Connected Value Score

Required visuals:

- Demand vs Attendance Converted
- Lost Attendance Opportunity by Homestand
- Value After Arrival by Homestand
- Connected Value Ranking
- Recommended Focus Breakdown

### TR5: Page 2 requirements

Promotion Value Scorecard must answer:

Which promotions created value beyond attendance, and should they return, be reworked, retired, or reviewed?

Required KPI labels:

- Promotions Reviewed
- Avg Connected Value Score
- Value After Arrival
- Future Value Pipeline
- Return / Rework Candidates

Required visuals:

- Promotion Decision Mix
- Promotion Value Scorecard
- Connected Value by Promotion Category
- Attendance Lift vs Revenue Lift
- In-Park Spend Lift by Promotion
- Repeat Buyer Signal

### TR6: Page 3 requirements

CRM Follow-Up Queue must answer:

Which fans and accounts become actionable once behavior from multiple systems is connected?

Required KPI labels:

- Actionable CRM Signals
- High Priority Signals
- Future Value Pipeline
- Avg Priority Score
- Fan Opportunities
- Account Opportunities

Required visuals:

- Action Bucket Breakdown
- Team Ownership Workload
- Prioritized Follow-Up Queue
- Hidden Fan Value
- Opportunity Type Breakdown

---

## Documentation Requirements

### DOC1: Required project documentation

The repo must include:

- `README.md`
- `PROJECT_CHARTER.md`
- `BUSINESS_QUESTIONS.md`
- `DATA_SOURCE_MAP.md`
- `DATA_ASSUMPTIONS.md`
- `SYNTHETIC_DATA_PLAN.md`
- `SNOWFLAKE_SCHEMA_PLAN.md`
- `SNOWFLAKE_LOAD_GUIDE.md`
- `DASHBOARD_PLAN.md`
- `TABLEAU_BUILD_GUIDE.md`
- `BUILD_ORDER.md`
- `TASK_TRACKER.md`
- `CHANGELOG.md`
- `REQUIREMENTS.md`

### DOC2: Public vs synthetic data boundary

Documentation must clearly state:

- This project does not use internal Trash Pandas data.
- Public data is used where available.
- Internal-style data is synthetic.
- Synthetic data is used only to demonstrate structure, workflow, and business logic.

### DOC3: Connected reporting framing

Documentation must frame the project around connected reporting, not just dashboard creation.

Required language concepts:

- siloed reports
- connected reporting layer
- demand created
- attendance converted
- value after arrival
- future value pipeline
- actionable CRM signals
- connected value score

---

## Quality Requirements

### QR1: Reproducibility

The repo must include enough documentation and SQL files for another reviewer to understand:

- what was built
- why it was built
- what data is public
- what data is synthetic
- how the final exports were loaded into Snowflake
- how the data was validated
- how the dashboard should be built

### QR2: No false claims

The project must not claim:

- access to internal Trash Pandas systems
- actual team financial data
- actual CRM data
- exact revenue forecasting
- sponsorship ROI
- real operational recommendations for the team

### QR3: Validation before dashboarding

Final exports must be validated before dashboard build.

Validation must include:

- row counts
- key totals
- duplicate checks
- valid recommendation labels
- valid entity mapping
- rate bounds
- non-negative revenue checks

### QR4: Dashboard clarity

Dashboard labels, titles, and tooltips must explain what connected data reveals.

The dashboard should avoid:

- overcomplicated visuals
- fake precision
- too many filters
- unsupported claims
- generic dashboard language

---

## Non-Requirements

The current build does not require:

- real internal Trash Pandas data
- real-time data pipelines
- direct Tableau Public to Snowflake connection
- machine learning models
- sponsorship ROI calculations
- full CRM implementation
- production-grade data infrastructure
- loading every raw and synthetic source table into Snowflake

---

## Acceptance Criteria

The current build is complete when:

- Public data foundation exists
- Synthetic internal-style data exists
- Final dashboard-ready exports exist
- Final exports pass quality checks
- Snowflake reporting layer is created
- Snowflake raw tables are loaded
- Snowflake validation queries pass
- Snowflake analytics views are created
- Business-question SQL file exists
- Tableau Public dashboard is built
- Tableau Public workbook is published
- README includes Tableau Public link
- README clearly explains public vs synthetic data
- README explains the Snowflake reporting layer
- Dashboard screenshots are added to the repo
- Final portfolio summary is added

---

## Current Status

Complete:

- Public data foundation
- Synthetic internal-style data generation
- Export builds
- Export quality checks
- Snowflake setup
- Snowflake raw tables
- Snowflake load process
- Snowflake validation SQL
- Snowflake analytics views
- Business-question SQL
- Connected reporting documentation refresh

Next:

- Build Tableau Public dashboard
- Publish dashboard
- Add Tableau Public link
- Add screenshots
- Complete final portfolio polish