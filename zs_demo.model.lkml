connection: "bytecode_looker_bigquery"
include: "views/*.view.lkml"

datagroup: shops_production_default_datagroup {
  sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "4 hours"
}
explore: demo {
  view_name: test
  join: test2 {
    relationship: one_to_one
    sql_on: ${test2.year} = ${test.year} ;;
  }
}
