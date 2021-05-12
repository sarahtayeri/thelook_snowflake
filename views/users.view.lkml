view: users {
  sql_table_name: "PUBLIC"."USERS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: id_2 {
    type: number
    sql: ${id} ;;
    value_format_name: percent_2
  }

  filter: sarah_filter {
    suggest_dimension: state
    #default_value: "California"
    #sql: {% condition %} ${state} {% endcondition %} ;;
  }

  dimension: goes_with_filter {
    sql: case when {% condition sarah_filter %} 'California' {% endcondition %} then 'CA' else 'whatever' end ;;
  }


  dimension: age {
    type: number
    description: "The age of the user"
    sql: ${TABLE}."AGE" ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}."CITY" ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}."COUNTRY" ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      day_of_week,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."CREATED_AT" ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}."EMAIL" ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}."FIRST_NAME" ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}."GENDER" ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}."LAST_NAME" ;;
  }

  dimension: full_name {
    type: string
    sql: concat(${first_name}, ' ', ${last_name}) ;;
    #html: {{users.first_name._value}} <br> {{users.last_name._value}} ;;
    html: This is my test blah {{users.first_name._value}} <br> {{users.last_name._value}}.;;
  }


  dimension: latitude {
    type: number
    sql: ${TABLE}."LATITUDE" ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}."LONGITUDE" ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}."STATE" ;;
    map_layer_name: us_states
    html:
    {% if state._value =='Aberdeen' %}
    <p style="font-size: 110%; color : #B94C6A">
    <b>19:</b>
    <font color="#888888">
    {{state._rendered_value}}
    </font>
    </p>
    {% else %}
    {{state._rendered_value}}
    {% endif %}



    ;;
  }

  dimension: is_named_sarah {
    type: yesno
    sql: ${first_name}='Sarah' ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}."TRAFFIC_SOURCE" ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}."ZIP" ;;
  }

  dimension: terence {
    type: string
    sql: {% if users.zip._in_query and users.state._in_query %} 'both in the query'
    {% elsif users.zip._in_query %} 'zip in query'
    {% elsif users.state._in_query %} 'state in query'
    {% else %} 'neither in query'
    {% endif %};;
  }

  measure: count {
    type: count
    drill_fields: [id, last_name, first_name, events.count, order_items.count]
  }

  measure: percent {
    type: count_distinct
    sql: ${id} ;;
    value_format_name: percent_2
  }
}
