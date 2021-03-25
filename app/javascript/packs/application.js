require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("chartkick")
require("chart.js")

import { initMapbox } from '../plugins/init_mapbox';

// External imports
import "bootstrap";

// Internal imports
document.addEventListener('turbolinks:load', () => {
  initMapbox();
});



