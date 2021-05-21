connection: "bytecode_looker_bigquery"
include: "views/*.view.lkml"

access_grant: is_admin {
  allowed_values: ["admin"]
  user_attribute: department
}

datagroup: test {
  sql_trigger: SELECT CURRENT_DATE() ;;
  max_cache_age: "4 hours"
}

test: count_is_not_negative {
  explore_source: census_business_dynamics {
    column: sum_firms { field: census_business_dynamics.sum_firms }
  }
  assert: count_is_not_negative {
    expression: ${census_business_dynamics.sum_firms} > 0 ;;
  }
}

explore: census_business_dynamics {}
