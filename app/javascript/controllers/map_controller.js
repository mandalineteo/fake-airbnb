import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl' // Don't forget this!

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  // CONTROLLER
  // data-controller='map'

  // TARGETS
  // data-map-target='target-name'

  // VALUES
  // data-map-markers-value='<%= @marker %>'

  // ACTIONS
  // data-action=[event]->[controller-name]#[action-name]

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this.#addMarkerToMap()
    this.#fitMapToMarker()
  }

  #addMarkerToMap() {
    // console.log(this.markersValue);
    this.markersValue.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat(marker)
        .addTo(this.map)
    })
  }

  #fitMapToMarker() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0})
  }
}
