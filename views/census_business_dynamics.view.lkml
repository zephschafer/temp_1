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
      label: "Show as line"
      url: "
      {% assign vis_config = '{
      \"type\": \"looker_line\",
      \"x_axis_gridlines\": \"false\",
      \"y_axis_gridlines\": \"true\",
      \"show_view_names\": \"false\",
      \"show_y_axis_labels\": \"true\",
      \"show_y_axis_ticks\": \"true\",
      \"y_axis_tick_density\": \"default\",
      \"y_axis_tick_density_custom\": \"5\",
      \"show_x_axis_label\": \"false\",
      \"show_x_axis_ticks\": \"true\",
      \"y_axis_scale_mode\": \"linear\",
      \"x_axis_reversed\": \"false\",
      \"y_axis_reversed\": \"false\",
      \"plot_size_by_field\": \"false\",
      \"limit_displayed_rows\": \"false\",
      \"legend_position\": \"center\",
      \"point_style\": \"none\",
      \"show_value_labels\": \"false\",
      \"label_density\": \"25\",
      \"x_axis_scale\": \"auto\",
      \"y_axis_combined\": \"true\",
      \"show_null_points\": \"true\",
      \"interpolation\": \"linear\"
      }' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}"
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
