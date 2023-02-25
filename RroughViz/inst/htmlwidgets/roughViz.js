HTMLWidgets.widget({

  name: 'roughViz',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

      new roughViz.Bar({
          element: '#' + el.id,
          data: x.data
      });

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
