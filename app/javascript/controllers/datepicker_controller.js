import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="datepicker"
export default class extends Controller {
  static values = {
    price: Number,
  }

  connect() {
    this.picker = new easepick.create({
      element: document.getElementById('datepicker'),
      css: [
        'https://cdn.jsdelivr.net/npm/@easepick/core@1.2.1/dist/index.css',
        'https://cdn.jsdelivr.net/npm/@easepick/range-plugin@1.2.1/dist/index.css',
      ],
      plugins: ['RangePlugin'],
      RangePlugin: {
        tooltip: true,
      },
      setup(picker) {
        picker.on("select", (e)=>{
          function convertDate(date) {
            var yyyy = date.getFullYear().toString();
            var mm = (date.getMonth()+1).toString();
            var dd  = date.getDate().toString();

            var mmChars = mm.split('');
            var ddChars = dd.split('');

            return yyyy + '-' + (mmChars[1]?mm:"0"+mmChars[0]) + '-' + (ddChars[1]?dd:"0"+ddChars[0]);
          }


          console.log(e.detail)

          document.querySelector("#start_date").value = convertDate(e.detail.start)
          document.querySelector("#end_date").value = convertDate(e.detail.end)

          let start_date = convertDate(e.detail.start)
          let end_date = convertDate(e.detail.end)

          document.querySelector("#start_date_display").innerHTML = convertDate(e.detail.start)
          document.querySelector("#end_date_display").innerHTML = convertDate(e.detail.end)

          let number_of_nights = ((e.detail.end - e.detail.start)/ (1000 * 3600 *24))
          console.log(number_of_nights)


          document.querySelector("#no_of_nights").innerText = ` X ${number_of_nights} nights`
          let price = Number(document.querySelector('[data-datepicker-price-value]').dataset.datepickerPriceValue)
          let total_price = number_of_nights * price
          document.querySelector("#total_nights_price").innerText = `$${total_price} SGD`
          document.querySelector("#total_price").innerText = `$${total_price + 26 + 73} SGD`
          document.querySelector("#reserve").disabled = false;
          document.querySelector("#partial-cancellation-date").innerHTML = `${start_date}`
        })
      }
    });
  }

   open() {
    this.picker.show();
  }
}
