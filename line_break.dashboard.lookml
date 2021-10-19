- dashboard: line_break
  title: a good dashboard
  layout: newspaper
  preferred_viewer: dashboards-next
  embed_style:
    background_color: "#F5F5F5"
    show_title: false
    title_color: "#2B3C49"
    show_filters_bar: false
    tile_text_color: "#2B3C49"
    text_tile_text_color: ''
  elements:
  - title: Untitled
    name: Untitled
    model: sarah_is_number_1
    explore: order_items
    type: looker_grid
    fields: [order_items.status, order_items.count, products.category]
    sorts: [order_items.count desc]
    limit: 500
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
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_fields: []
    y_axes: []
    note_state: collapsed
    note_display: hover
    note_text: "1. hello \n<br> 2. new line \n<br> 3. new line\n"
    listen:
      Status: order_items.status
      Status Param: order_items.status_param
      Category: products.category
      Created Date: order_items.created_date
    row: 0
    col: 0
    width: 8
    height: 6
  - title: Untitled (Copy)
    name: Untitled (Copy)
    model: sarah_is_number_1
    explore: order_items
    type: looker_grid
    fields: [order_items.status, order_items.count]
    sorts: [order_items.count desc]
    limit: 500
    dynamic_fields: [{_kind_hint: dimension, table_calculation: new_calculation, _type_hint: string,
        category: table_calculation, expression: '"Placeholder"', label: New Calculation,
        value_format: !!null '', value_format_name: !!null ''}, {_kind_hint: dimension,
        table_calculation: new_calculation2, _type_hint: string, category: table_calculation,
        expression: '"Placeholder 2"', label: New Calculation2, value_format: !!null '',
        value_format_name: !!null ''}]
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
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_fields: []
    y_axes: []
    listen:
      Status: order_items.status
      Status Param: order_items.status_param
      Category: products.category
      Created Date: order_items.created_date
    row: 0
    col: 8
    width: 8
    height: 6
  filters:
  - name: Status
    title: Status
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
      options: []
    model: sarah_is_number_1
    explore: order_items
    listens_to_filters: []
    field: order_items.status
  - name: Status Param
    title: Status Param
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
      options: []
    model: sarah_is_number_1
    explore: order_items
    listens_to_filters: []
    field: order_items.status_param
  - name: Category
    title: Category
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
      options: []
    model: sarah_is_number_1
    explore: order_items
    listens_to_filters: []
    field: products.category
  - name: Created Date
    title: Created Date
    type: field_filter
    default_value: 2021/09/02
    allow_multiple_values: true
    required: false
    ui_config:
      type: day_picker
      display: inline
      options: []
    model: sarah_is_number_1
    explore: order_items
    listens_to_filters: []
    field: order_items.created_date
