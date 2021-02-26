const STYLES_URL = 'https://127.0.0.1:8080/styles.css';
const RING_THICKNESS = 10; // (px / 2)


const loadStyles = () => {
  const linkElement = document.createElement('link');
  linkElement.setAttribute('rel', 'stylesheet');
  linkElement.setAttribute('href', STYLES_URL);
  document.getElementsByTagName('head')[0].appendChild(linkElement);
};


const drawVisualization = ( svg, data ) => {
  const pie = d3.pie().value(function(d) { return d; }).sort(null);
  const arcs = pie(data);
  const standardBaselineColor = '#e0e0e0';
  // const standardColor = '#5798d9';
  const coloredValue = d3.interpolateRdYlGn(data[0] / 100);
  const colorScale =
    d3.scaleOrdinal().domain(data).range([
      coloredValue, standardBaselineColor
    ]);
  const radius = 50;
  svg.select('text').text(`${data[0]}%`);
  svg.select('g').selectAll('path')
    .data(arcs)
    .join('path')
      .attr('d', d3.arc()
        .innerRadius(radius - RING_THICKNESS)
        .outerRadius(radius)
      )
      .attr('fill', function(d){
        return (colorScale(d.data));
      });
};


looker.plugins.visualizations.add({

  options: {
    // font_size: {
    //   type: "string",
    //   label: "Font Size",
    //   values: [
    //     {"Large": "large"},
    //     {"Small": "small"}
    //   ],
    //   display: "radio",
    //   default: "large"
    // }
  },

  // Initial state
  create: function(element, config) {

    loadStyles();

    // Layout
    let layoutContainer = element.appendChild(document.createElement('div'));
    layoutContainer.className = 'layout';

    // Individual UI elements
    this._title =
      layoutContainer.appendChild(document.createElement('h3'));
    this._visual =
      layoutContainer.appendChild(document.createElement('div'));
    this._visual.id = 'visual';

    this._svg =
      d3.select('#visual').append('svg')
        .attr('viewBox', '0 0 100 100');

    this._svg.append('text')
      .attr('id', 'label')
      .attr('x', '50%')
      .attr('y', '50%')
      .attr('dominant-baseline', 'middle')
      .attr('text-anchor', 'middle');

    this._svg.append('g')
      .attr('id', 'output')
      .attr('transform', 'translate(50 , 50)');
  },

  // Async render/re-render
  updateAsync: function(data, element, config, queryResponse, details, done) {

    // Clear previous errors if present; throw new one if basic reqs not met
    this.clearErrors();
    if (queryResponse.fields.dimensions.length === 0) {
      this.addError(
        {title: "No dimensions", message: "This chart requires dimensions."}
      );
      return;
    }

    // Grab the first cell of the data
    const firstRow = data[0];
    const sensorName = firstRow[queryResponse.fields.dimensions[0].name];
    const rawPercentage = firstRow[queryResponse.fields.measures[0].name].value;
    const percentage = Math.round(rawPercentage * 100);
    const percentageRemainder = 100 - percentage;

    // Populate UI
    this._title.innerHTML = LookerCharts.Utils.htmlForCell(sensorName);
    drawVisualization(this._svg, [percentage, percentageRemainder]);

    // Apply user preferences from configuration settings
    // if (config.font_size == "small") {
    //   this._textElement.className = "hello-world-text-small";
    // } else {
    //   this._textElement.className = "hello-world-text-large";
    // }

    done();
  }

});
