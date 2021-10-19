#project_name: "sarah_is_number_1"


constant: usd_in_thousands_value_format {
  value: "[>=1000]$#,##0,\"K\";[<=-1000]$#,##0,\"K\""
}

constant: joel {
  value: "[\"active\", \"deleted\"]"
}

constant: first_name {
  value: "{{_user_attributes['first_name']}}"
}


constant: model_constant {
  value: "sarah_is_number_1"
}

constant: default_value_constant {
  value: "Cancelled, Shipped"
}

constant: table_name {
  value: "\"PUBLIC\".\"EVENTS\""
}
