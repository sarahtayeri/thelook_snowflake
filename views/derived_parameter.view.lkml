view: derived_parameter {
  derived_table: {
    sql: SELECT
      order_items."DELIVERED_AT" AS "order_items.delivered_date"
    FROM "PUBLIC"."ORDER_ITEMS" AS order_items

    WHERE ((( order_items."DELIVERED_AT"  ) >= ((CONVERT_TIMEZONE('America/Los_Angeles', 'UTC', CAST({% parameter date_parameter %} AS TIMESTAMP_NTZ)))) AND ( order_items."DELIVERED_AT"  ) < ((CONVERT_TIMEZONE('America/Los_Angeles', 'UTC', CAST(DATEADD('day', 1, {% parameter date_parameter %}) AS TIMESTAMP_NTZ))))))

    GROUP BY 1;;
  }



  dimension: date {
    type: date
    sql: ${TABLE}."order_items.delivered_date" ;;
  }

  parameter: date_parameter {
    type: date_time
  }

}
