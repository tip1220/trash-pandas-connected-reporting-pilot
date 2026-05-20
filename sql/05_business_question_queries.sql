USE ROLE ACCOUNTADMIN;
USE WAREHOUSE TP_REPORTING_WH;
USE DATABASE TRASH_PANDAS_CONNECTED_REPORTING;

-- 1. What new decisions become possible when homestand data sources are connected?
-- Connects ticket demand, scan conversion, in-park value, CRM opportunity, and recommended focus.

SELECT
    season,
    homestand_id,
    homestand_start_date,
    homestand_end_date,
    game_count,
    opponents,
    tickets_sold AS demand_created,
    scanned_attendance AS attendance_converted,
    scan_rate AS demand_to_attendance_conversion,
    no_show_ticket_quantity AS lost_attendance_quantity,
    no_show_rate AS lost_attendance_opportunity_rate,
    net_ticket_revenue,
    merch_net_sales,
    concession_net_sales,
    in_park_spend_per_scanned_fan AS value_after_arrival_per_fan,
    revenue_per_scanned_fan AS quality_of_attendance,
    future_revenue_opportunity AS future_value_pipeline,
    homestand_total_value_index AS connected_value_score,
    recommended_focus
FROM ANALYTICS.V_HOMESTAND_SUMMARY
ORDER BY
    connected_value_score DESC,
    total_revenue_indicator DESC
LIMIT 10;


-- 2. Which homestands created the strongest value after fans arrived?
-- Connects scan attendance to merch and concession behavior.

SELECT
    season,
    homestand_id,
    homestand_start_date,
    homestand_end_date,
    game_count,
    opponents,
    scanned_attendance AS attendance_converted,
    merch_net_sales,
    concession_net_sales,
    in_park_spend_per_scanned_fan AS value_after_arrival_per_fan,
    revenue_per_scanned_fan AS quality_of_attendance,
    total_revenue_indicator,
    recommended_focus
FROM ANALYTICS.V_HOMESTAND_SUMMARY
ORDER BY
    value_after_arrival_per_fan DESC,
    total_revenue_indicator DESC
LIMIT 10;


-- 3. Which homestands sold tickets but created lost attendance opportunity?
-- Connects ticketing and scan data to show where demand did not convert.

SELECT
    season,
    homestand_id,
    homestand_start_date,
    homestand_end_date,
    game_count,
    opponents,
    tickets_sold AS demand_created,
    scanned_attendance AS attendance_converted,
    no_show_ticket_quantity AS lost_attendance_quantity,
    no_show_rate AS lost_attendance_opportunity_rate,
    follow_up_opportunity_count AS actionable_crm_signals,
    high_priority_opportunity_count AS high_priority_signals,
    crm_follow_up_task_count AS crm_tasks_created,
    future_revenue_opportunity AS future_value_pipeline,
    recommended_focus
FROM ANALYTICS.V_HOMESTAND_SUMMARY
ORDER BY
    lost_attendance_quantity DESC,
    future_value_pipeline DESC
LIMIT 10;


-- 4. Which promotions created enough connected value to return?
-- Connects demand, scan rate, revenue quality, in-park spend, repeat behavior, and recommendation logic.

SELECT
    season,
    game_date,
    opponent,
    day_of_week,
    promo_name,
    promo_category,
    promo_type,
    tickets_sold AS demand_created,
    scanned_attendance AS attendance_converted,
    scan_rate AS demand_to_attendance_conversion,
    revenue_per_scanned_fan AS quality_of_attendance,
    in_park_spend_per_scanned_fan AS value_after_arrival_per_fan,
    repeat_buyer_rate AS repeat_buyer_signal,
    total_value_index AS connected_value_score,
    recommendation,
    recommendation_reason
FROM ANALYTICS.V_PROMOTION_SCORECARD
WHERE LOWER(recommendation) = 'return'
ORDER BY
    connected_value_score DESC,
    quality_of_attendance DESC;


-- 5. Which promotions need to be reworked?
-- Shows promotions that created some value but may need redesign.

SELECT
    season,
    game_date,
    opponent,
    day_of_week,
    promo_name,
    promo_category,
    promo_type,
    scanned_attendance AS attendance_converted,
    scan_rate AS demand_to_attendance_conversion,
    no_show_rate AS lost_attendance_opportunity_rate,
    revenue_per_scanned_fan AS quality_of_attendance,
    in_park_spend_per_scanned_fan AS value_after_arrival_per_fan,
    total_value_index AS connected_value_score,
    recommendation,
    recommendation_reason
FROM ANALYTICS.V_PROMOTION_SCORECARD
WHERE LOWER(recommendation) = 'rework'
ORDER BY
    connected_value_score DESC,
    attendance_converted DESC
LIMIT 25;


-- 6. Which promotions should be retired?
-- Identifies promotions with weaker connected value across attendance, revenue, and follow-up signals.

SELECT
    season,
    game_date,
    opponent,
    day_of_week,
    promo_name,
    promo_category,
    promo_type,
    scanned_attendance AS attendance_converted,
    scan_rate AS demand_to_attendance_conversion,
    no_show_rate AS lost_attendance_opportunity_rate,
    revenue_per_scanned_fan AS quality_of_attendance,
    in_park_spend_per_scanned_fan AS value_after_arrival_per_fan,
    total_value_index AS connected_value_score,
    recommendation,
    recommendation_reason
FROM ANALYTICS.V_PROMOTION_SCORECARD
WHERE LOWER(recommendation) = 'retire'
ORDER BY
    connected_value_score ASC,
    quality_of_attendance ASC;


-- 7. Which promotion categories produced the strongest connected value?
-- Aggregates promotion performance across attendance, conversion, revenue quality, and future opportunity.

SELECT
    promo_category,
    COUNT(*) AS promotion_count,
    ROUND(AVG(total_value_index), 2) AS avg_connected_value_score,
    ROUND(AVG(scanned_attendance), 2) AS avg_attendance_converted,
    ROUND(AVG(scan_rate), 4) AS avg_demand_to_attendance_conversion,
    ROUND(AVG(no_show_rate), 4) AS avg_lost_attendance_opportunity_rate,
    ROUND(AVG(revenue_per_scanned_fan), 2) AS avg_quality_of_attendance,
    ROUND(AVG(in_park_spend_per_scanned_fan), 2) AS avg_value_after_arrival_per_fan,
    ROUND(SUM(future_revenue_opportunity), 2) AS future_value_pipeline
FROM ANALYTICS.V_PROMOTION_SCORECARD
GROUP BY promo_category
ORDER BY
    avg_connected_value_score DESC,
    avg_quality_of_attendance DESC;


-- 8. Which promotions lifted attendance but underperformed on revenue quality?
-- Shows why attendance alone is not enough to evaluate promotion performance.

SELECT
    season,
    game_date,
    opponent,
    day_of_week,
    promo_name,
    promo_category,
    promo_type,
    scanned_attendance AS attendance_converted,
    baseline_scanned_attendance,
    scanned_attendance_lift_vs_slot AS attendance_lift_vs_schedule_slot,
    revenue_per_scanned_fan AS quality_of_attendance,
    baseline_revenue_per_scanned_fan,
    revenue_lift_per_scanned_fan AS revenue_quality_lift,
    total_value_index AS connected_value_score,
    recommendation
FROM ANALYTICS.V_PROMOTION_SCORECARD
WHERE scanned_attendance_lift_vs_slot > 0
  AND revenue_lift_per_scanned_fan < 0
ORDER BY
    attendance_lift_vs_schedule_slot DESC,
    revenue_quality_lift ASC
LIMIT 25;


-- 9. Which promotions created the strongest value after arrival?
-- Connects promotion context to merch and concession behavior.

SELECT
    season,
    game_date,
    opponent,
    day_of_week,
    promo_name,
    promo_category,
    promo_type,
    scanned_attendance AS attendance_converted,
    merch_net_sales,
    concession_net_sales,
    in_park_revenue AS value_after_arrival,
    merch_per_scanned_fan,
    concession_per_scanned_fan,
    in_park_spend_per_scanned_fan AS value_after_arrival_per_fan,
    merch_lift_per_scanned_fan,
    concession_lift_per_scanned_fan,
    total_value_index AS connected_value_score,
    recommendation
FROM ANALYTICS.V_PROMOTION_SCORECARD
ORDER BY
    value_after_arrival_per_fan DESC,
    value_after_arrival DESC
LIMIT 25;


-- 10. Which fans or accounts become actionable when behavior from multiple systems is connected?
-- Connects ticketing, scans, spend, engagement, opportunity scoring, and CRM ownership.

SELECT
    priority_rank,
    entity_type,
    entity_id,
    entity_display_name,
    assigned_team,
    assigned_owner,
    executive_action_bucket,
    priority_score,
    priority_band,
    opportunity_type,
    source_signal,
    suggested_action,
    due_date,
    future_revenue_opportunity AS future_value_pipeline,
    repeat_likelihood_score,
    upgrade_potential_score,
    entity_total_value,
    entity_ticket_revenue,
    entity_in_park_revenue,
    dashboard_filter_label
FROM ANALYTICS.V_CRM_FOLLOW_UP_QUEUE
ORDER BY priority_rank ASC
LIMIT 100;


-- 11. Which CRM action buckets are driving the queue?
-- Shows whether connected reporting is creating recovery, upgrade, retention, or renewal work.

SELECT
    executive_action_bucket,
    SUM(task_count) AS task_count,
    ROUND(SUM(total_future_revenue_opportunity), 2) AS future_value_pipeline,
    ROUND(AVG(avg_priority_score), 2) AS avg_priority_score,
    ROUND(AVG(avg_repeat_likelihood_score), 2) AS avg_repeat_likelihood_score,
    ROUND(AVG(avg_upgrade_potential_score), 2) AS avg_upgrade_potential_score
FROM ANALYTICS.V_CRM_ACTION_BUCKET_SUMMARY
GROUP BY executive_action_bucket
ORDER BY
    task_count DESC,
    future_value_pipeline DESC;


-- 12. Which teams own the follow-up workload?
-- Turns connected insight into operational ownership.

SELECT
    assigned_team,
    SUM(task_count) AS task_count,
    ROUND(SUM(total_future_revenue_opportunity), 2) AS future_value_pipeline,
    ROUND(AVG(avg_priority_score), 2) AS avg_priority_score
FROM ANALYTICS.V_CRM_ACTION_BUCKET_SUMMARY
GROUP BY assigned_team
ORDER BY
    task_count DESC,
    future_value_pipeline DESC;


-- 13. Which teams own each type of CRM action?
-- Shows workload by team, action bucket, and priority band.

SELECT
    assigned_team,
    executive_action_bucket,
    priority_band,
    task_count,
    total_future_revenue_opportunity AS future_value_pipeline,
    avg_priority_score,
    avg_repeat_likelihood_score,
    avg_upgrade_potential_score
FROM ANALYTICS.V_CRM_ACTION_BUCKET_SUMMARY
ORDER BY
    assigned_team,
    executive_action_bucket,
    priority_band;


-- 14. Which hidden-value fans should be reviewed first?
-- Finds fans who may be undervalued if the team only looks at ticket spend.

SELECT
    priority_rank,
    fan_id,
    entity_display_name,
    assigned_team,
    executive_action_bucket,
    priority_score,
    priority_band,
    opportunity_type,
    suggested_action,
    fan_segments,
    fan_ticket_revenue,
    fan_in_park_revenue,
    fan_total_value,
    fan_scan_rate,
    fan_no_show_rate,
    fan_engagement_count,
    future_revenue_opportunity AS future_value_pipeline
FROM ANALYTICS.V_CRM_FOLLOW_UP_QUEUE
WHERE LOWER(entity_type) = 'fan'
  AND fan_hidden_value_flag = TRUE
ORDER BY
    priority_rank ASC
LIMIT 100;


-- 15. Which group accounts should group sales prioritize?
-- Connects account activity, group revenue, scan behavior, renewal status, and future opportunity.

SELECT
    priority_rank,
    account_id,
    account_name,
    account_type,
    account_owner,
    industry,
    city,
    renewal_status,
    assigned_team,
    executive_action_bucket,
    priority_score,
    opportunity_type,
    suggested_action,
    account_group_sale_count,
    account_group_ticket_quantity,
    account_group_revenue,
    account_avg_group_scan_rate,
    account_total_value,
    future_revenue_opportunity AS future_value_pipeline
FROM ANALYTICS.V_CRM_FOLLOW_UP_QUEUE
WHERE LOWER(entity_type) = 'account'
ORDER BY
    priority_rank ASC
LIMIT 100;