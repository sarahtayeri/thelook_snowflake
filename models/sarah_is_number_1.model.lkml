connection: "snowflakelooker"

# include all the views
#comment

include: "/views/**/*.view"
include: "/stephen.dashboard"
include: "/column.dashboard"
include: "/column_next.dashboard"
include: "/required_filter.dashboard"
include: "/quickstarts.explore"
include: "/constants_for_model.dashboard"

datagroup: sarah_is_number_1_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: sarah_is_number_1_default_datagroup

explore: derived_parameter {}

explore: distribution_centers {
  access_filter: {
    field: distribution_centers.id
    user_attribute: people_whose_data_i_can_see
  }
}

explore: derived_ua {}

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
  persist_for: "0 seconds"
  sql_always_where: {% condition users.state_filter %} ${users.state} {% endcondition %} ;;

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

explore: extended_events {}

# Place in `sarah_is_number_1` model
explore: +order_items {
    query: test{
      dimensions: [id, status]
      pivots: [status]
      measures: [average]
      filters: [order_items.created_date: "", order_items.delivered_date: ""]
      #timezone: "America/Los_Angeles"
    }
  }

explore: +order_items {
  query: test2{
    dimensions: [id, status]
    pivots: [status]
    measures: [average]
    filters: [order_items.created_date: "", order_items.delivered_date: ""]
    #timezone: "America/Los_Angeles"
  }
}



explore: users {
  sql_always_where: {% if users.state_parameter._is_filtered %} {% condition users.state_parameter %} ${users.state} {% endcondition %} {% else %} ${users.state} = 'Alaska' {% endif %} ;;
  join: events {
    type: left_outer
    relationship: many_to_one
    sql_on: ${events.id} = ${users.id};;
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
