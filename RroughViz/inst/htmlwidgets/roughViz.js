HTMLWidgets.widget({

  name: 'roughViz',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

        let data_main = {
          element: '#' + el.id,
          data: x.data,
          roughness: x.roughness
        };

        let keys = Object.keys(x).slice(3);

        keys.forEach((key, index) => {
            data_main[key] = x[key]
        });

        new roughViz[x.type](data_main);

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
