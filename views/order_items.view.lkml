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

  dimension: lorem_ipsum {
    type: string
    sql: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';;
  }


dimension: events_field {
  sql: ${events.city} ;;
}



  parameter: timeframe_picker {
    label: "Date Granularity"
    type: string
    allowed_value: { value: "Date" }
    allowed_value: { value: "Week" }
    allowed_value: { value: "Month" }
    default_value: "Date"
  }

  dimension: dynamic_timeframe {
    type: string
    label: "Text here {% parameter timeframe_picker %}"
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
    # html: {% if value > 5 %}
    # {{value}} !
    # {% else %}
    # {{value}}
    # {%endif%};;
  }

  dimension: id_2 {
    sql: ${id}*(-1) ;;
    type: number
    html: {{ value | abs }} ;;
  }

  measure: max_id {
    type: max
    sql: ${id} ;;
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
    #sql: case when  ;;
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
    html:  <p style="font-size:50%; text-align:center">{{ rendered_value }}</p> ;;
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

  parameter: zheng {
    type: string
  }

  dimension: zheng_dim {
    type: yesno
    sql: ${status} = {% parameter zheng %} ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  dimension: status_value {
    type: string
    sql: {{ order_items.status._value }} ;;
  }

  dimension: long_values {
    type: string
    sql: case when ${status} = 'Cancelled' then 'This is my super long field name ahhhhhhh' else ${status} end ;;
  }

  parameter: status_param {
    suggest_explore: order_items
    suggest_dimension: status
  }

  dimension: status_catcher {
    type: string
    sql: {% parameter status_param %};;
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

  measure: marc_count {
    type: count_distinct
    sql: ${inventory_item_id} ;;
  }

  measure: count {
    type: count
    #drill_fields: [detail*]
    link: {
      url: "https://www.google.com"
      icon_url:
      "{% if order_items.status._value == 'Complete' %}
      https://logo-core.clearbit.com/looker.com
      {% else %}
      https://logo-core.clearbit.com/google.com
      {% endif %}"
      label: "test"
    }
  }

  measure: count_of_cancelled {
    type: count
    filters: [status: "Cancelled"]
  }
  measure: count_of_complete {
    type: count
    filters: [status: "Complete"]
  }

  dimension: icon {
    sql: 'https://logo-core.clearbit.com/looker.com' ;;
  }

  measure: running_total_count {
    type: running_total
    sql: ${count} ;;
    link: {
      url: "https://google.com"
      icon_url: "https://logo-core.clearbit.com/looker.com"
      label: "test2"
    }
  }

  measure: lauren {
    type: number
    sql: ${count}+${average} ;;
    html: {{order_items.count._value}}  || {{order_items.average._value}};;
  }

  measure: html_cindy {
    type: date
    sql: max(${created_date}) ;;
    html: {% if order_items.created_date._value < order_items.delivered_date._value %}
    <p style="color: red;">{{ rendered_value }}</p>
    {% else %}
    <p style="color: black;">{{rendered_value}}</p>
    {% endif %} ;;
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
    value_format_name: decimal_0
  }

  measure: no_sql_param {
    type: count_distinct
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
