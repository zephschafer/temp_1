view: test2 {
  sql_table_name: `bytecode-looker-data-source.looker_scratch.test` ;;
  dimension: years_names {
    hidden: yes
    primary_key: yes
    sql: CONCAT(${year}, ${name_count}) ;;
  }
  dimension: year {
    sql: ${TABLE}.usa_1910_2013_year ;;
  }
  dimension: name_count {
    sql: ${TABLE}.usa_1910_2013_total_names ;;
  }
  measure: count_names {
    type: sum
    sql: ${name_count} ;;
  }
}
