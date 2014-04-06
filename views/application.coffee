$ ->
  options = {
    chart: {
      renderTo: 'container',
      defaultSeriesType: 'column'
    },
    title: {
      text: 'Electricity Charge & Usage'
    },
    xAxis: {
      categories: [],
      labels: {
        rotation: -45,
        align: 'right',
        style: {
          fontSize: '13px'
        }
      }
    },
    yAxis: [
      {
        title: {
          text: 'Charge
          '
        },
        labels: {
          format: '{value} yen'
        }
      },
      {
        title: {
          text: 'Usage'
        },
        labels: {
          format: '{value} kWh'
        },
        opposite: true
      },
    ],
    series: [
      {
        name: 'Charge',
        color: 'blue',
        data: [],
        tooltip: {
          valueSuffix: 'yen'
        }
      },
      {
        name: 'Usage',
        color: '#89A54E',
        data: [],
        tooltip: {
          valueSuffix: 'kWh'
        },
        yAxis: 1
      }
    ]
  }

  $.get('/csv/electricity.csv', (data) ->
    lines = data.split('\n')
    chargeIdx = 0
    usageIdx = 0

    $.each(lines, (lineIdx, line) ->
      return if line == ''
      items = line.split(',')

      if lineIdx == 0
        chargeIdx = items.indexOf('Charge')
        usageIdx = items.indexOf('Usage')
      else
        options.xAxis.categories.push(items[0])
        options.series[0].data.push(parseInt(items[chargeIdx]))
        options.series[1].data.push(parseInt(items[usageIdx]))
    )

    console.log options
    chart = new Highcharts.Chart(options)
  )
