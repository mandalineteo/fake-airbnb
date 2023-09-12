import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-filter"
export default class extends Controller {
  static targets = ["banner"]

  connect() {
    console.log("filter controller connected");
  }

  appear () {
    this.bannerTarget.classList.toggle("d-none");
  }
}
