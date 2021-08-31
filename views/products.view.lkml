view: products {
  sql_table_name: "PUBLIC"."PRODUCTS"
    ;;
  drill_fields: [id]


  filter: date_filter {
    type: date
  }

  parameter: number_1 {
    type: number
  }
  parameter: number_2 {
    type: number
  }

  dimension: calculator {
    type: number
    sql: {% parameter number_1 %} + {% parameter number_2 %};;
  }



  measure: sum_in_billions {
    type: sum
    sql: ${cost}*10000 ;;
    value_format: "0.000,,,\"B\""
  }

  measure: sum_of_costs {
    type: sum
    value_format_name: decimal_2
    sql: ${cost} ;;
  }

  measure: for_sankey {
    type: number
    sql: ${count}/${sum_of_costs} ;;
    value_format_name: percent_2
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: format_bug {
    type: number
    sql: ${id};;
    #value_format: "[>=1000]$#,##0,\"K\";[<=-1000]$#,##0,\"K\""
    #value_format: "@{usd_in_thousands_value_format}"
  }

  dimension: brand {
    type: string
    sql: ${TABLE}."BRAND" ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}."CATEGORY" ;;
  }

  dimension: seconds {
    type: number
    sql: 61 ;;
  }

  measure: bug {
    type: number
    sql: ${seconds} / (CAST(86400 AS DOUBLE));;
    value_format: "HH:MM:SS"
  }

  dimension: cost {
    type: number
    value_format_name: usd
    sql: ${TABLE}."COST" ;;
  }

  parameter: vertical_date{
    type: date
  }

  dimension: vertical_date_value {
    type: date
    sql: {% parameter vertical_date %} ;;
  }


  dimension: expense_range {
    type: string
    sql: case when ${cost}<50 then 'cheap'
     when ${cost}<150 and ${cost}>= 50 then 'affordable'
     when ${cost}<250 and ${cost}>= 150 then 'less affordable'
    else 'expensive' end;;
  }

  dimension: over_100 {
    type: string
    sql: case when ${cost}>=100 then 'over 100' else 'under 100' end;;
    html: <p style='color:#57A63A'> {{value}} </p> ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}."DEPARTMENT" ;;
  }

  dimension: distribution_center_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."DISTRIBUTION_CENTER_ID" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
    drill_fields: [department, category]
    #html: {{rendered_value}} ;;
    link: {
      url: "/explore/sarah_is_number_1/order_items?fields=products.name,products.category,products.brand&f[products.name]={{value}}"
      label: "mist test"
      }
  }

  dimension: long_dimension {
    type: string
    sql: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, qui. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, qui.' ;;

  }

  dimension: long_dimension_with_html {
    type: string
    sql: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, qui. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, qui.' ;;
    html: <p style="font-size:50%">{{ rendered_value }}</p> ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}."RETAIL_PRICE" ;;
  }


  measure: sum_with_drill {
    type: sum
    sql: ${cost} ;;
    drill_fields: [retail_price, cost, name]
    link: {
      label: "blah"
      url: "{{link}}&f[products.department]=Women"
    }
  }



  dimension: sku {
    type: string
    sql: ${TABLE}."SKU" ;;
  }

  measure: count {
    type: count
    drill_fields: [category, department, sum_of_costs]

    link: {

      label: "bug1: unable to select series"

      url: "

      {% assign vis_config = '{
      \"x_axis_gridlines\":false,\"y_axis_gridlines\":true,\"show_view_names\":false,\"show_y_axis_labels\":true,\"show_y_axis_ticks\":true,\"y_axis_tick_density\":\"default\",\"y_axis_tick_density_custom\":5,\"show_x_axis_label\":true,\"show_x_axis_ticks\":true,\"y_axis_scale_mode\":\"linear\",\"x_axis_reversed\":false,\"y_axis_reversed\":false,\"plot_size_by_field\":false,\"trellis\":\"\",\"stacking\":\"\",\"limit_displayed_rows\":false,\"legend_position\":\"center\",\"point_style\":\"none\",\"show_value_labels\":false,\"label_density\":25,\"x_axis_scale\":\"auto\",\"y_axis_combined\":true,\"show_null_points\":true,\"interpolation\":\"linear\",\"type\":\"looker_line\",\"series_types\":{},\"defaults_version\":1
      }' %}

      /explore/sarah_is_number_1/products?fields=products.category,products.department,products.sum_of_costs&pivots=products.department&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"

    }


    link: {
      label: "bug2: line vis tooltip flashes"
      url: "
      {% assign vis_config = '{
          \"x_axis_gridlines\":false,\"y_axis_gridlines\":true,\"show_view_names\":false,\"show_y_axis_labels\":true,\"show_y_axis_ticks\":true,\"y_axis_tick_density\":\"default\",\"y_axis_tick_density_custom\":5,\"show_x_axis_label\":true,\"show_x_axis_ticks\":true,\"y_axis_scale_mode\":\"linear\",\"x_axis_reversed\":false,\"y_axis_reversed\":false,\"plot_size_by_field\":false,\"trellis\":\"\",\"stacking\":\"\",\"limit_displayed_rows\":false,\"legend_position\":\"center\",\"point_style\":\"none\",\"show_value_labels\":false,\"label_density\":25,\"x_axis_scale\":\"auto\",\"y_axis_combined\":true,\"show_null_points\":true,\"interpolation\":\"linear\",\"type\":\"looker_line\",\"series_types\":{},\"ordering\":\"none\",\"show_null_labels\":false,\"show_totals_labels\":false,\"show_silhouette\":false,\"totals_color\":\"#808080\",\"defaults_version\":1
     }' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000
      "
    }
  }
}
