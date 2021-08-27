view: derived_ua {
  derived_table: {
    sql:
    SELECT * FROM "PUBLIC"."PRODUCTS" WHERE (products."BRAND" ) = {{_user_attributes['first_name']}} LIMIT 5
    ;;
  }


  dimension: id {}
  dimension: brand {}

}
