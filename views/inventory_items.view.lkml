view: inventory_items {
  sql_table_name: "PUBLIC"."INVENTORY_ITEMS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
    #html:<a href="/dashboards/1234"> {{ value }} </a> ;;
    link: {
      label: "Parul"
      url: "/dashboards/1234"
    }
  }



  dimension: blah {
    sql:  12344 ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}."COST" ;;
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
      year
    ]
    sql: ${TABLE}."CREATED_AT" ;;
  }

  measure: daniel_1 {
    type: max
    sql: case when ${product_brand}='Jeans' then 1 end;;
  }

  measure: daniel {
    type: number
    sql:  case when ${product_brand}='Jeans' then ${daniel_1}
    else ${count} end;;
  }

  dimension: product_brand {
    type: string
    sql: ${TABLE}."PRODUCT_BRAND" ;;
  }

  dimension: product_category {
    type: string
    sql: ${TABLE}."PRODUCT_CATEGORY" ;;
  }

  dimension: product_department {
    type: string
    sql: ${TABLE}."PRODUCT_DEPARTMENT" ;;
  }

  dimension: product_distribution_center_id {
    type: number
    sql: ${TABLE}."PRODUCT_DISTRIBUTION_CENTER_ID" ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."PRODUCT_ID" ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}."PRODUCT_NAME" ;;
  }

  dimension: product_retail_price {
    type: number
    sql: ${TABLE}."PRODUCT_RETAIL_PRICE" ;;
    value_format_name: usd
  }

  measure: avg_retail_price {
    type: average
    sql: ${product_retail_price} ;;
    value_format_name: usd
    #html: <p style="font-size:30px"> Title here <br> {{value}} </p> ;;

  }

  dimension: product_sku {
    type: string
    sql: ${TABLE}."PRODUCT_SKU" ;;
  }

  dimension_group: sold {
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
    sql: ${TABLE}."SOLD_AT" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, product_name, products.name, products.id, order_items.count]
    link: {
      url: "/explore/sarah_is_number_1/order_items?fields=inventory_items.count,order_items.id&sorts=inventory_items.count+desc&limit=500"
      label: "conrad"
    }
  }

  measure: david_list {
    type: list
    list_field: product_category
  }



}
