view: order_items {
  sql_table_name: "PUBLIC"."ORDER_ITEMS"
    ;;
  drill_fields: [id]

  filter: doug {
    suggest_explore: events
    suggest_dimension: events.browser
  }

  filter: timothy {
    type: date
    default_value: "2018"
    sql:{% condition %} ${created_date} {% endcondition %} ;;
  }

  dimension: timothy_dim {
    sql: ${returned_date} > {% date_end timothy %} ;;
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


dimension: events_field {
  sql: ${events.city} ;;
}

filter: gal_filter {
  type: date
}


dimension: gal_test {
  type: yesno
  sql: ${created_date} > {% date_start gal_filter %} ;;
}


dimension: gal_middle {
  sql: {% date_start gal_filter %} ;;
}

dimension: gal_test2 {
  type: string
  sql: {% if created_date._value > gal_middle._value %} 'yes' {% else %} 'no' {% endif %};;
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
    value_format_name: usd
  }

  dimension_group: created {
    convert_tz: no
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
  }

  dimension: status_value {
    type: string
    sql: {{ order_items.status._value }} ;;
  }


  measure: mike_test {
    type: number
    sql: 1 ;;
    html: {% if order_items.status._value == 'Cancelled' %} {{order_items.if_1._value}}
    {% elsif order_items.status._value == 'Complete' %} {{order_items.if_2._value}}
    {% else %} 123
    {% endif %};;
  }

  measure: if_1 {
    type: number
    sql: ${count}/${average} ;;
  }

  measure: if_2 {
    type: number
    sql: ${average}/${count} ;;
  }

  dimension: long_values {
    type: string
    sql: case when ${status} = 'Cancelled' then 'This is my super long field name ahhhhhhh' else ${status} end ;;
  }

  parameter: status_param {
    allowed_value: {
      value: "complete"
      label: "complete"
    }
    allowed_value: {
      value: "cancelled"
      label: "cancelled"
    }
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

  measure: sum_sale_price {
    type: sum
    sql: ${sale_price} ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
    # html: {% if order_items.status._value == 'Complete' %}
    # <p style="color: red;">{{ rendered_value }}</p>
    # {% else %}
    # <p style="color: black;">{{rendered_value}}</p>
    # {% endif %}
    # ;;
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


view: +order_items {

  measure: average {
    hidden: yes
  }
}
