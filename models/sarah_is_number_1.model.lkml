connection: "snowflakelooker"

# include all the views
#comment

include: "/views/**/*.view"
include: "/stephen.dashboard"
include: "/column.dashboard"
include: "/column_next.dashboard"



datagroup: sarah_is_number_1_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: sarah_is_number_1_default_datagroup

explore: derived_parameter {}

explore: distribution_centers {}

explore: etl_jobs {}

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: users {
    #sql_where: case when {% condition users.sarah_filter %} 'California' {% endcondition %} then ${users.state} IN ('Georgia', 'Adur') else 1=1 end;;
    #fields: []
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
  join: events {
    fields: []
    type: left_outer
    sql_on: ${order_items.id} = ${events.id} ;;
    relationship: many_to_one
    }

}




explore: products {
  # sql_always_where:
  # {% if products.andrea_param._parameter_value == 'blueberries' %} ${products.department} = "blueberries"
  # {% elsif products.andrea_param._parameter_value == 'raspberries' %} ${products.department} = "raspberries"
  # {% else %} 1=1
  # {% endif %};;
  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}
