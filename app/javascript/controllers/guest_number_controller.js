import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="guest-filter"
export default class extends Controller {
  static targets = ["pax", "paxInput", "dropdown"]

  connect() {
    console.log("controller connected");
  }

  add() {
    const pax = parseInt(this.paxTarget.innerText)

    this.paxTarget.innerText = pax + 1 ;
    this.paxInputTarget.value = pax + 1 ;

    console.log(this.paxInputTarget.value);
  }

  minus() {
    const pax = parseInt(this.paxTarget.innerText)

    if (pax > 0) {
      this.paxTarget.innerText = pax - 1 ;
      this.paxInputTarget.value = pax - 1 ;
    }
  }

  drop() {
    this.dropdownTarget.classList.toggle("d-none");
  }
}
