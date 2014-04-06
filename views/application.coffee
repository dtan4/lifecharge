$ ->
  options = {
    chart: {
      renderTo: 'container',
      defaultSeriesType: 'column'
    },
    title: {
      text: 'Electricity Charge'
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
    yAxis: {
      title: {
        text: 'Charge'
      }
    },
    legend: {
      enabled: false
    },
    series: [{
      name: 'Charge',
      data: []
    }]
  }

  $.get('/csv/electricity.csv', (data) ->
    lines = data.split('\n')
    chargeIdx = 0

    $.each(lines, (lineIdx, line) ->
      return if line == ''
      items = line.split(',')

      if lineIdx == 0
        chargeIdx = items.indexOf('Charge')
      else
        options.xAxis.categories.push(items[0])
        options.series[0].data.push(parseInt(items[chargeIdx]))
    )

    console.log options
    chart = new Highcharts.Chart(options)
  )
