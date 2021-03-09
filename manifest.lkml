project_name: "zs_test_1"

visualization: {
  id: "donut"
  label: "[DEV ONLY] Donut"
  file: "visualizations/donut.js"
  dependencies: [
    "https://d3js.org/d3.v6.js",
    "https://d3js.org/d3-color.v2.min.js",
    "https://d3js.org/d3-interpolate.v2.min.js",
    "https://d3js.org/d3-scale-chromatic.v2.min.js"
  ]
}


visualization: {
  id: "zs_test"
  label: "ZS Test"
  file: "visualizations/viz_demo_2/dist/bundle.js"
}
