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
  }

  dimension: long_dimension {
    type: string
    sql: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, qui. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, qui.' ;;
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
    drill_fields: [id, name, distribution_centers.id, distribution_centers.name, inventory_items.count]
  }
}
