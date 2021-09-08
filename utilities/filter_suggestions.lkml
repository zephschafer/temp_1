explore: emp_suggestions {}
view: emp_suggestions {
  derived_table: {
    sql_trigger_value: SELECT CURRENT_DATE() ;;
    sql:
      SELECT
        DISTINCT emp AS emp
      FROM ${raw_census_business_dynamics.SQL_TABLE_NAME}
    ;;
  }
  dimension: emp {}
}
