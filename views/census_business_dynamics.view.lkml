view: census_business_dynamics {
  sql_table_name: ${raw_census_business_dynamics.SQL_TABLE_NAME} ;;
  dimension: string {
    sql: {% assign now_time = "now" | date: "%H:%M"  %} {{ now_time }} ;;
  }

  # sql_table_name: ${raw_census_business_dynamics.SQL_TABLE_NAME} ;;
  dimension: year {
    type: date
    # timeframes: [raw,month,year]
    # sql: '1900-01-01' ;;
    # sql: '1900-01-01' ;;
    # html:
    #   <p>
    #   {% if value == '1900-01-01' %}
    #     formatte_null_value
    #   {% else %}
    #     {{ rendered_value }}
    #   {% endif %}
    #   </p>;;
  }
      # {% if value == '1900-01-01' %}
      #   formatte_null_value
      # {% else %}
      #   {{ rendered_value }}
      # {% endif %}


  dimension: year_clean {
    sql: TIMESTAMP(PARSE_DATE("%Y", CAST(${TABLE}.year AS STRING))) ;;
  }



  dimension: firms {
    type: number
    link: {
      label: "
      {% if _user_attributes['test_z'] == 'xyz' %} Link
      {% else %}
      {% endif %}
      "
      url: "www.google.com/{{ value }}"
    }
  }
  dimension: estabs {
    label: "Establishments"
    type: number
    html: "<br><br><br><br><br><br><br><br><br><br>{{ value }}<br><br>" ;;
  }
  dimension: emp_display {
    label: "Employees Display"
    type: string
    sql: ${TABLE}.emp ;;
    value_format_name: decimal_0
  }
  dimension: emp {
    label: "Employees"
    type: string
    # suggest_explore: emp_suggestions
    # suggest_dimension: emp_suggestions.emp
    sql: MD5(CAST(${emp_display} AS STRING)) ;;
    html: {{ emp_display._value }} ;;
  }
  dimension: estabs_entry_rate {
    label: "Entry Rate of Establishments"
    type: number
    value_format_name: decimal_2
    html: <p style="text-align:center">{{ rendered_value }}</p> ;;
  }
  dimension: customer_name {
    sql: "John Smith" ;;
    html: <p style="text-align:center">{{ value }}</p> ;;
  }
  dimension: customer {
    sql: ${estabs_entry_rate} ;;
    html: <p style="text-align:center">{{ rendered_value }}</p> ;;
  }
  measure: count {
    type: count
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
    label: "Average firms"
    type: average
    sql: ${firms} ;;
    value_format_name: decimal_0
    # html: <p style="text-align:center">{{ rendered_value }}</p> ;;
  }
  measure: avg_entry_rate {
    label: "Average Entry Rate"
    type: average
    sql: ${estabs_entry_rate} ;;
    html:
    {% if value > 10' %}
      <p style="background-color: lightblue; text-align:center">{{ rendered_value }}</p>
    {% else %}
      <p style="background-color: orange; text-align:center">{{ rendered_value }}</p>
    {% endif %}
    ;;
    value_format_name: usd_0
  }

}
