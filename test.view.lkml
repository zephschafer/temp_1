view: test {
  derived_table: {
    sql: SELECT 1 as test_field ;;
  }
  dimension: test_field {
    label: "test"
  }
}
