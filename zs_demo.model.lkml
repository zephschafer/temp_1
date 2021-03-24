connection: "bytecode_looker_bigquery"
include: "views/*.view.lkml"

datagroup: test {
  sql_trigger: SELECT CURRENT_DATE() ;;
  max_cache_age: "4 hours"
}
persist_with: test
explore: demo {
  persist_with: test
  view_name: test
  join: test2 {
    relationship: one_to_one
    sql_on: ${test2.year} = ${test.year} ;;
  }
}
