connection: "bytecode_looker_bigquery"
include: "/views/*.view.lkml"
include: "/utilities/*.lkml"

access_grant: is_admin {
  allowed_values: ["admin"]
  user_attribute: department
}

datagroup: demo_datagroup {
  sql_trigger: SELECT MAX() WHERE {{ _user_attribute['test_z'] }} = 'abc' ;;
  # max_cache_age: "4 hours"
}

test: count_is_not_negative {
  explore_source: census_business_dynamics {
    column: sum_firms { field: census_business_dynamics.sum_firms }
  }
  assert: count_is_not_negative {
    expression: ${census_business_dynamics.sum_firms} > 0 ;;
  }
}

explore: census_business_dynamics {
  access_filter: {
    field: firms
    user_attribute: id
  }
  persist_with: demo_datagroup
}


# explore: orders {
#   join: customers {
#     sql_on: ${orders.customer_id} = ${customers.id};;
#     type: left_outer
#     relationship: many_to_one
#   }
#   join: accounts {
#     sql_on: ${customers.account_id} = ${accounts.id} ;;
#     type: inner
#     relationship: many_to_one
#   }
# }
