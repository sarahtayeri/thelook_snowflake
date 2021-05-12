view: order_items {
  sql_table_name: "PUBLIC"."ORDER_ITEMS"
    ;;
  drill_fields: [id]

  filter: doug {
    suggest_explore: events
    suggest_dimension: events.browser
  }


  parameter: select_1 {
    allowed_value: {
      value: "average"
      label: "Average"
    }
    allowed_value: {
      value: "status_filtered"
      label: "Status Filtered"
    }
  }

  dimension: users_field {
    type: string
    sql: ${users.first_name} ;;
  }

  measure: selected {
    label_from_parameter: select_1
    type: number
    sql: CASE
          WHEN {% parameter select_1 %} = 'average' THEN ${average}
          WHEN {% parameter select_1 %} = 'status_filtered' THEN ${status_filtered} END;;
  }




  parameter: timeframe_picker {
    label: "Date Granularity"
    type: string
    allowed_value: { value: "Date" }
    allowed_value: { value: "Week" }
    allowed_value: { value: "Month" }
    allowed_value: { value: "YTD" }
    default_value: "Date"
  }

  dimension: dynamic_timeframe {
    type: string
    sql:
    CASE
    WHEN {% parameter timeframe_picker %} = 'Date' THEN ${order_items.created_date}
    WHEN {% parameter timeframe_picker %} = 'Week' THEN ${order_items.created_week}
    WHEN {% parameter timeframe_picker %} = 'Month' THEN ${order_items.created_month}
    END ;;
  }

  dimension: ytd {
    type: yesno
    sql: case when MONTH(${created_date}) <= MONTH(CURRENT_DATE()) then ${created_date} else null end;;
  }






  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      month_name,
      year
    ]
    sql: ${TABLE}."CREATED_AT" ;;
  }

  dimension: test_created_month {
    type: string
    sql: ${created_month_name} ;;
    html: {{value}} * ;;
  }


  dimension: view_name {
    sql: {{ _view._name }} ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."DELIVERED_AT" ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."INVENTORY_ITEM_ID" ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}."ORDER_ID" ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."RETURNED_AT" ;;
  }

  dimension: sale_price {
    type: number
    value_format_name: usd_0
    sql: ${TABLE}."SALE_PRICE" ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."SHIPPED_AT" ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
    link: {
      label: "test"
      url: "https://dcl.dev.looker.com/dashboards-next/938?Second={{value}}"
    }
  }

  dimension: status_2 {
    type: string
    sql: 'hello';;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."USER_ID" ;;
  }

  parameter: measure_selector {
    type: unquoted
    allowed_value: {
      label: "Count"
      value: "count"
    }
    allowed_value: {
      label: "Dollar"
      value: "dollar"
    }
  }

  measure: selector {
    type: number
    label_from_parameter: measure_selector
    sql: {% if measure_selector._parameter_value == 'count' %}
    ${count}
    {% else %}
    ${average_sale_price}
    {% endif %};;
    html: {% if measure_selector._parameter_value == 'count' %}
    {{count._rendered_value}}
    {% else %}
    {{average_sale_price._rendered_value}}
    {% endif %};;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;
    value_format_name: usd
  }

  filter: status_filter {
    suggest_dimension: status
  }

  dimension: status_satisfies_filter {
    type: yesno
    hidden: yes
    sql: {% condition status_filter %} ${status} {% endcondition %} ;;
  }

  measure: status_filtered {
    type: count
    filters: [status_satisfies_filter: "yes"]
    value_format_name: usd
  }

  measure: average {
    type: average
    sql: ${id} ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      inventory_items.product_name,
      inventory_items.id,
      users.last_name,
      users.first_name,
      users.id
    ]
  }
}
