#project_name: "sarah_is_number_1"




# This project
project_name: "sarah_is_number_1"

# The project to import
local_dependency: {
  project: "bitbucket_sarah"
}

constant: usd_in_thousands_value_format {
  value: "[>=1000]$#,##0,\"K\";[<=-1000]$#,##0,\"K\""
}

constant: joel {
  value: "[\"active\", \"deleted\"]"
}
