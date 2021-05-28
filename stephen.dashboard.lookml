- dashboard: a_good_snowflake_dashboard
  title: a good snowflake dashboard
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - title: New Tile
    name: New Tile
    model: sarah_is_number_1
    explore: order_items
    type: looker_grid
    fields: [order_items.created_date, order_items.count]
    fill_fields: [order_items.created_date]
    sorts: [order_items.created_date desc]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen: {}
    row: 0
    col: 0
    width: 8
    height: 6
  - title: New Tile (Copy)
    name: New Tile (Copy)
    model: sarah_is_number_1
    explore: order_items
    type: looker_grid
    fields: [order_items.created_date, order_items.count]
    fill_fields: [order_items.created_date]
    sorts: [order_items.created_date desc]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen: {}
    row: 0
    col: 9
    width: 8
    height: 6
