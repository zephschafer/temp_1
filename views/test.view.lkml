view: test {
  sql_table_name: `bytecode-looker-data-source.looker_scratch.test` ;;
  dimension: years_names {
    hidden: no
    label: "This is a label"
    primary_key: yes
    sql: CONCAT(${year}, ${name_count}) ;;
  }
  dimension_group: current_date {
    type: time
    timeframes: [time, date]
    sql: CURRENT_TIMESTAMP ;;
  }
  dimension: year {
    sql: ${TABLE}.usa_1910_2013_year ;;
  }
  dimension: name_count {
    sql: ${TABLE}.usa_1910_2013_total_names ;;
  }

  measure: count_names {
    type: sum
    drill_fields: [test.nonexistentset*]
    sql: ${name_count} ;;
    link: {
      label: "example"
      url: "https://bytecode.looker.com/dashboards-next/409"
    }
  }

  measure: count_names_unique {
    type: count_distinct
    sql: ${year} ;;
  }

}
