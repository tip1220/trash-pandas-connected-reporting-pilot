# Trash Pandas Connected Reporting Pilot

## Project Purpose

The Trash Pandas Connected Reporting Pilot is a sports business analytics proof-of-concept that shows what a growth-market sports organization can learn when separate business data sources are connected into one reporting layer.

The project does not claim access to internal Trash Pandas data.

It uses public data where available and clearly labeled synthetic internal-style data where real team system data would normally be required.

The goal is to demonstrate how leadership, sales, marketing, promotions, service, and group sales teams could make better decisions when ticketing, scans, promotions, group sales, merch, concessions, fan engagement, and CRM follow-up data are analyzed together instead of separately.

## One-Sentence Pitch

This project uses Python, Snowflake, SQL, and Tableau Public to model how a sports organization could move from siloed business reports to a connected reporting layer that reveals demand, attendance conversion, in-park value, promotion impact, and priority follow-up opportunities.

## Business Problem

Sports organizations often have useful data spread across separate systems, departments, and workflows.

A team may have separate reports for:

- ticketing
- promotions
- scanned attendance
- group sales
- merch sales
- concession sales
- sponsorship activations
- fan engagement
- CRM follow-up

Each report can answer one narrow question.

Ticketing can show what was sold.

Scans can show who showed up.

Promotions can show what was offered.

POS data can show what fans spent.

CRM data can show who needs follow-up.

But when those reports stay separate, leadership may miss the full business story.

A promotion may sell tickets, but that does not automatically mean it created strong scanned attendance, in-park spend, repeat buyers, or follow-up opportunity.

A homestand may draw a crowd, but that does not automatically mean it created strong total value.

A fan may look average in ticketing data but become valuable once merch, concessions, attendance behavior, and engagement are connected.

This project demonstrates what a connected reporting structure could look like.

## Main Business Question

What new decisions become possible when separate sports business data sources are connected into one reporting layer?

## Supporting Business Questions

1. Which homestands created value across demand, attendance conversion, in-park spend, and follow-up opportunity?
2. Which games or homestands sold tickets but underperformed on attendance conversion?
3. Which average-attendance games created strong value after fans arrived?
4. Which promotions created value beyond attendance?
5. Which promotions should return, be reworked, retired, or reviewed?
6. Which promotions lifted attendance but underperformed on revenue quality?
7. Which promotions created wallets, not just crowds?
8. Which fans or accounts should receive follow-up first?
9. Which fans are undervalued if the team only looks at ticket spend?
10. Which group accounts are highest priority for renewal or upsell?
11. Which no-show buyers are worth recovering?
12. Which teams own the next action?
13. Which data sources need to be connected to answer these questions consistently?

## Primary Audience

The dashboard and reporting structure are designed for:

1. Leadership and executives
2. Sales and marketing teams
3. Promotions staff
4. Group sales and service teams
5. Business intelligence / analytics teams
6. Recruiters and hiring managers reviewing the portfolio project

## Project Scope

The current build focuses on 2023-2025 Trash Pandas home games only.

The project is not a full CRM replacement.

It is not a real-time data pipeline.

It is not a machine learning project.

It is not a sponsorship ROI model.

It is a connected reporting proof-of-concept.

## Current Build Focus

The current build focuses on three dashboard outputs:

1. Connected Homestand Intelligence
2. Promotion Value Scorecard
3. CRM Follow-Up Queue

These outputs show the reporting path from:

- what happened
- what worked
- who needs action next

## Technology Stack

- Python: data cleaning, synthetic data generation, export builds, quality checks
- Snowflake: cloud reporting warehouse and SQL validation layer
- SQL: table creation, validation, analytics views, and business-question queries
- Tableau Public: dashboard visualization
- CSV files: source and export format
- GitHub: project documentation and version control
- VS Code: file editing

## Snowflake Architecture

The current Snowflake build uses one warehouse-style reporting database:

- Warehouse: `TP_REPORTING_WH`
- Database: `TRASH_PANDAS_CONNECTED_REPORTING`
- Schemas:
  - `RAW`
  - `ANALYTICS`
  - `QA`

The current build loads the final dashboard-ready exports into RAW tables:

- `RAW.HOMESTAND_SUMMARY`
- `RAW.PROMOTION_SCORECARD`
- `RAW.CRM_FOLLOW_UP_QUEUE`

The current build creates reporting-ready analytics views:

- `ANALYTICS.V_HOMESTAND_SUMMARY`
- `ANALYTICS.V_PROMOTION_SCORECARD`
- `ANALYTICS.V_CRM_FOLLOW_UP_QUEUE`
- `ANALYTICS.V_EXECUTIVE_HOMESTAND_OVERVIEW`
- `ANALYTICS.V_PROMOTION_RECOMMENDATION_SUMMARY`
- `ANALYTICS.V_CRM_ACTION_BUCKET_SUMMARY`

Future Snowflake expansion could add full source-layer modeling across public and synthetic source files, but the current build only needs the final reporting exports.

## Public Data

Public data may include:

- game dates
- season
- opponent
- home/away flag
- day of week
- promotion names
- promotion categories
- announced attendance where available

Public data is used as the external anchor.

Public attendance is not treated as scanned attendance.

Public data is not assumed to be complete, perfect, or formatted consistently.

## Synthetic Data

Synthetic data is generated for internal-style fields such as:

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

Synthetic data is clearly labeled and documented.

Synthetic data is used only where internal business data would normally be required.

## Fan-Linked Spend Assumption

The project models partial fan-level matching for merch and concession purchases.

Assumptions:

- 60-75% of merch transactions are linked to `fan_id`
- 35-55% of concession transactions are linked to `fan_id`
- Remaining transactions are tied only to `game_id`

This avoids pretending every in-park purchase can be matched to a fan.

## Connected Reporting Logic

The project connects business data at three levels.

### Game-Level Connections

Games connect to:

- promotions
- public attendance
- ticket orders
- ticket scans
- group sales
- merch transactions
- concession transactions
- sponsorship context
- fan engagement
- follow-up opportunities

This creates homestand and promotion insight.

### Fan-Level Connections

Fans connect to:

- ticket orders
- ticket scans
- merch transactions
- concession transactions
- engagement behavior
- segments
- follow-up opportunities
- CRM tasks

This creates fan value and follow-up insight.

### Account-Level Connections

Group accounts connect to:

- group sales
- ticket orders
- renewal signals
- upsell signals
- CRM tasks

This creates account prioritization insight.

## Core Decision Outputs

The project produces three dashboard-ready outputs.

### 1. Connected Homestand Intelligence

This output helps leadership see which homestands created value across:

- demand created
- attendance converted
- demand-to-attendance conversion
- lost attendance opportunity
- value after arrival
- revenue per scanned fan
- future value pipeline
- connected value score
- recommended focus

### 2. Promotion Value Scorecard

This output helps leadership and promotions teams evaluate whether promotions should:

- return
- be reworked
- be retired
- be reviewed

Promotion decisions are based on connected value, not attendance alone.

### 3. CRM Follow-Up Queue

This output helps sales, marketing, service, and group sales teams identify:

- who to contact
- why they matter
- what action should happen next
- which team owns the follow-up
- what future opportunity exists

## Promotion Recommendation Labels

Promotions are classified as:

- Return
- Rework
- Retire
- Review

The recommendation is based on connected value, not attendance alone.

## Connected Value Definition

Connected value includes:

- ticket sales
- scanned attendance
- scan rate
- no-show rate
- group sales
- merch spend
- concession spend
- repeat buyer signal
- engagement signal
- follow-up opportunity

The project uses index-based scoring instead of claiming exact financial truth.

## Total Revenue Indicator

Total revenue indicator combines synthetic ticket, merch, and concession revenue signals.

It is not actual team financial reporting.

It is a portfolio metric used to show how connected reporting could support better decisions.

## Future Value Pipeline

Future value pipeline is shown as a modeled opportunity signal, not a precise revenue forecast.

It considers:

- repeat likelihood
- recent attendance
- ticket spend
- merch and concession behavior
- group or corporate fit
- engagement signal
- upgrade potential
- renewal or upsell logic

## Repeat Likelihood

Repeat likelihood is rule-based, not machine-learning based.

It considers:

- recency
- frequency
- promotion or theme affinity
- engagement behavior
- scan reliability

## No-Show Recovery Logic

The project focuses on recovering valuable no-shows, not every no-show.

A no-show buyer becomes a recovery target when they:

- purchased a ticket
- did not scan
- have prior value
- have engagement history
- show premium, group, or repeat buyer behavior

One-time buyers with no prior value are excluded unless they bought premium or group tickets.

## Sponsorship Scope

Sponsorship is included as business context only.

The project does not claim to calculate sponsorship ROI.

Sponsorship ROI would require internal contract terms, fulfillment details, impression data, partner objectives, and activation-specific outcomes.

## What This Project Is Not

This project is not:

- a replacement for the team's existing systems
- a claim of internal Trash Pandas data access
- a real CRM implementation
- a real-time reporting pipeline
- a machine learning project
- an exact revenue forecast
- a sponsorship ROI model
- a claim that the team lacks data
- a claim that the team lacks reporting capability

## Portfolio Story

This project shows how a sports organization could move from scattered reports to a connected reporting layer.

The value is not just the dashboard.

The value is the structure.

Public data and synthetic internal-style data are generated, staged, validated, loaded into Snowflake, organized into analytics views, queried with SQL, and visualized in Tableau Public.

The project demonstrates how a team could connect the data it may already have so leaders can see:

- what created demand
- what converted into attendance
- what created value after arrival
- what created future opportunity
- who needs action next

## Project Success Criteria

The project is successful if it clearly shows:

1. What new decisions become possible when sports business data sources are connected
2. Which homestands created connected value across demand, attendance, spend, and opportunity
3. Which promotions created value beyond attendance
4. Which fans and accounts deserve follow-up
5. Which games or homestands had demand, conversion, spend, or follow-up gaps
6. How Snowflake can support a connected sports business reporting layer
7. How SQL can validate and query the reporting layer
8. How Tableau can turn that layer into executive-ready reporting