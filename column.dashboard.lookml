- dashboard: new_col_for_lookml
  title: new col for lookml
  layout: newspaper
  preferred_viewer: dashboards
  elements:
  - title: New Tile
    name: New Tile
    model: sarah_is_number_1
    explore: order_items
    type: looker_grid
    fields: [inventory_items.cost, inventory_items.created_date, inventory_items.created_month,
      inventory_items.created_quarter, inventory_items.created_time, inventory_items.created_week,
      inventory_items.created_year, inventory_items.id, inventory_items.product_brand,
      inventory_items.product_category, inventory_items.product_department, inventory_items.product_distribution_center_id,
      inventory_items.product_id, inventory_items.product_name, inventory_items.product_retail_price,
      inventory_items.product_sku]
    sorts: [inventory_items.created_date desc]
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
    series_types: {}
    defaults_version: 1
    row: 0
    col: 0
    width: 18
    height: 11
