connection: "bytecode_looker_bigquery"
include: "views/*.view.lkml"

explore: test {
  join: test2 {
    sql_on: ${test2.year} = ${test.year} ;;
  }
}



# explore: base {
#   join: column_1 {
#     from: all_columns_view
#     sql_on:  ${base.company_id} = ${column_1.company_id}
#               AND ${all_columns_view.column_1} = 'column 1';;
#   }
#   join: column_2 {
#     from: all_columns_view
#     sql_on:  ${base.company_id} = ${column_2.company_id}
#       AND ${all_columns_view.column_2} = 'column 2';;
#   }
#   # .................................
#   # .....one_join_per_column..........
#   # ................
# }

# explore: list_41630 {
#   extends: [base]
#   fields: [list_specific_columns*]
# }
