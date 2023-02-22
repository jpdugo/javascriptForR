// gio.js
HTMLWidgets.widget({

  name: 'gio',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

        var sel_handle = new crosstalk.SelectionHandle();
        sel_handle.setGroup(x.crosstalk.group);

        var container = document.getElementById(el.id);
        var controller = new GIO.Controller(el);
        controller.addData(x.data);
        controller.init();

        function callback (selectedCountry) {
          sel_handle.set([selectedCountry.ISOCode]);
        }

        controller.onCountryPicked(callback);

        sel_handle.on("change", function(e) {

        // selection comes from another widget
        if (e.sender !== sel_handle) {
          // clear the selection
          // not possible with gio.js
        }
        controller.switchCountry(e.value[0]);
});

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
