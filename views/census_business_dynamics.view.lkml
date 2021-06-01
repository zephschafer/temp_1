view: census_business_dynamics {
  sql_table_name: ${raw_census_business_dynamics.SQL_TABLE_NAME} ;;
  dimension_group: year {
    type: time
    timeframes: [raw,year]
    sql: TIMESTAMP(PARSE_DATE("%Y", CAST(${TABLE}.year AS STRING))) ;;
  }
  dimension: firms {
    type: number
  }
  dimension: estabs {
    label: "Establishments"
    type: number
  }
  dimension: emp {
    label: "Employees"
    type: number
  }
  dimension: estabs_entry_rate {
    label: "Entry Rate of Establishments"
    type: number
    value_format_name: decimal_2
  }
  measure: sum_firms {
    type: sum
    sql: ${firms} ;;
    drill_fields: [
      census_business_dynamics.sum_firms,
      census_business_dynamics.year_year,
      census_business_dynamics.avg_entry_rate
    ]
    link: {
      label: "custom graph"
      url: "/explore/zs_demo/census_business_dynamics?fields=census_business_dynamics.sum_firms,census_business_dynamics.year_year,census_business_dynamics.avg_entry_rate&query_timezone=America%2FLos_Angeles&limit=500&vis_config=%7B%0A%20%20%20%20%20%20%22type%22%3A%20%22looker_line%22%2C%0A%20%20%20%20%20%20%22x_axis_gridlines%22%3A%20%22false%22%2C%0A%20%20%20%20%20%20%22y_axis_gridlines%22%3A%20%22true%22%2C%0A%20%20%20%20%20%20%22show_view_names%22%3A%20%22false%22%2C%0A%20%20%20%20%20%20%22show_y_axis_labels%22%3A%20%22true%22%2C%0A%20%20%20%20%20%20%22show_y_axis_ticks%22%3A%20%22true%22%2C%0A%20%20%20%20%20%20%22y_axis_tick_density%22%3A%20%22default%22%2C%0A%20%20%20%20%20%20%22y_axis_tick_density_custom%22%3A%20%225%22%2C%0A%20%20%20%20%20%20%22show_x_axis_label%22%3A%20%22false%22%2C%0A%20%20%20%20%20%20%22show_x_axis_ticks%22%3A%20%22true%22%2C%0A%20%20%20%20%20%20%22y_axis_scale_mode%22%3A%20%22linear%22%2C%0A%20%20%20%20%20%20%22x_axis_reversed%22%3A%20%22false%22%2C%0A%20%20%20%20%20%20%22y_axis_reversed%22%3A%20%22false%22%2C%0A%20%20%20%20%20%20%22plot_size_by_field%22%3A%20%22false%22%2C%0A%20%20%20%20%20%20%22limit_displayed_rows%22%3A%20%22false%22%2C%0A%20%20%20%20%20%20%22legend_position%22%3A%20%22center%22%2C%0A%20%20%20%20%20%20%22point_style%22%3A%20%22none%22%2C%0A%20%20%20%20%20%20%22show_value_labels%22%3A%20%22false%22%2C%0A%20%20%20%20%20%20%22label_density%22%3A%20%2225%22%2C%0A%20%20%20%20%20%20%22x_axis_scale%22%3A%20%22auto%22%2C%0A%20%20%20%20%20%20%22y_axis_combined%22%3A%20%22true%22%2C%0A%20%20%20%20%20%20%22show_null_points%22%3A%20%22true%22%2C%0A%20%20%20%20%20%20%22interpolation%22%3A%20%22linear%22%0A%20%20%20%20%20%20%7D&origin=drill-menu"
    }
  }
  measure: avg_firms {
    type: average
    sql: ${firms} ;;
  }
  measure: avg_entry_rate {
    type: average
    sql: ${estabs_entry_rate} ;;
  }

}
