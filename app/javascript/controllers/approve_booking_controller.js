import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="approve-booking"
export default class extends Controller {
  static targets = ["status", "submit", "decline"]
  connect() {
    console.log("test")
  }

  submit(e){
    e.preventDefault();

    console.log(e.currentTarget)

    fetch(
      e.currentTarget.action,
      {
        method: "PATCH",
        headers: { "Accept": "application/json" },
        body: new FormData(e.currentTarget)
      }
    ).then((response)=>response.json())
    .then((data)=>{
      if (data.success) {
        this.statusTarget.innerHTML = "Status: Confirmed"
        this.submitTarget.style.display = "none";
        this.declineTarget.style.display = "none";
      }
    })
  }


  decline(e){
    e.preventDefault();

    console.log(e.currentTarget)

    fetch(
      e.currentTarget.action,
      {
        method: "PATCH",
        headers: { "Accept": "application/json" },
        body: new FormData(e.currentTarget)
      }
    ).then((response)=>response.json())
    .then((data)=>{
      if (data.success) {
        this.statusTarget.innerHTML = "Status: Declined"
        this.declineTarget.style.display = "none";
        this.submitTarget.style.display = "none";
      }
    })
  }


}
