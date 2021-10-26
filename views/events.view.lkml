view: events {

  #sql_table_name: "PUBLIC"."EVENTS"
  sql_table_name: @{table_name}
    ;;
  drill_fields: [id]


  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
    #group_label: "test1"
  }



  dimension: browser {
    type: string
    sql: ${TABLE}."BROWSER" ;;
    #group_label: "test1"
  }

  dimension: city {
    #label: "@{first_name}"
    type: string
    sql: ${TABLE}."CITY" ;;
  }

  dimension: city_type {
    type: string
    sql: TYPEOF(${TABLE}."CITY") ;;
  }



  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}."COUNTRY" ;;
  }

  dimension: kevin_test {
    type: string
    sql: CONCAT(${city}, '_', ${country}) ;;
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

  measure: ugly {
    type: string
    sql: concat(max(${created_date}), ${count}) ;;
    html: {{created_date._value}}
    <br>
    {{count._value}}
    ;;
  }

  dimension_group: created_plus_1_hr {
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
    sql: DATEADD(hour, 1, ${TABLE}."CREATED_AT") ;;
  }

  dimension: date_diff {
    type: number
    sql: DATEDIFF(day, ${created_date}, ${created_plus_1_hr_date}) ;;
  }

  dimension: event_type {
    type: string
    sql: ${TABLE}."EVENT_TYPE" ;;
  }

  dimension: ip_address {
    type: string
    sql: ${TABLE}."IP_ADDRESS" ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}."LATITUDE" ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}."LONGITUDE" ;;
  }

  dimension: os {
    type: string
    sql: ${TABLE}."OS" ;;
  }

  dimension: sequence_number {
    type: number
    sql: ${TABLE}."SEQUENCE_NUMBER" ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}."SESSION_ID" ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}."STATE" ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}."TRAFFIC_SOURCE" ;;
  }

  dimension: uri {
    type: string
    sql: ${TABLE}."URI" ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."USER_ID" ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}."ZIP" ;;
  }

  measure: count {
    type: count
    #drill_fields: [id, users.last_name, users.first_name, users.id]
    link: {
      label: "link"
      url: "https://dcl.dev.looker.com/dashboards-next/123"
    }
    }
}


view: +events {
  dimension: included_in_refinemenet {
    sql: ${zip} ;;
  }
}
