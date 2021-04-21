connection: "bytecode_looker_bigquery"
include: "views/*.view.lkml"

datagroup: test {
  sql_trigger: SELECT CURRENT_DATE() ;;
  max_cache_age: "4 hours"
}

access_grant: zs_test {
  allowed_values: ["def"]
  user_attribute: test_z
}

test: count_is_not_negative {
  explore_source: demo {
    column: count_names { field: test.count_names }
  }
  assert: count_is_not_negative {
    expression: ${test.count_names} > 10000000000 ;;
  }
}

persist_with: test
explore: demo {
  persist_with: test
  view_name: test
  join: test2 {
    relationship: one_to_many
    sql_on: ${test2.year} = ${test.year} ;;
  }
}
