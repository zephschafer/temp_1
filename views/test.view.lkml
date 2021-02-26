view: test {
  sql_table_name: `bytecode-looker-data-source.looker_scratch.test` ;;
  dimension: years_names {
    hidden: yes
    primary_key: yes
    sql: CONCAT(${year}, ${names}) ;;
  }
  dimension: year {
    sql: ${TABLE}.usa_1910_2013_year ;;
  }
  dimension: names {
    sql: ${TABLE}.usa_1910_2013_total_names ;;
  }
}
