connection: "bytecode_looker_bigquery"
include: "views/*.view.lkml"
# Test Comment Line
explore: test {
  join: test2 {
    relationship: one_to_one
    sql_on: ${test2.year} = ${test.year} ;;
  }
}

#hello, this is a test!
