HTMLWidgets.widget({

  name: 'roughViz',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

      new roughViz.Bar({
          element: '#' + el.id,
          data: 'https://raw.githubusercontent.com/jwilber/random_data/master/flavors.csv',
          labels: 'flavor',
          values: 'price'
      });

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
