import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="datepicker"
export default class extends Controller {
  static values = {
    price: Number,
    cleaningFee: Number,
    serviceFee: Number,
    unavailableDates: Array
  }

  static targets = [
    'datepicker',
    'startDate',
    'endDate',
    'submit',
    'startDateInput',
    'endDateInput',
    'totalNights',
    'totalNightsPrice',
    'totalPrice',
    // 'freeCancellation'
  ]

  connect() {
    const setDates = this.setDates.bind(this)
    const unavailableDates = this.unavailableDatesValue

    this.picker = new easepick.create({
      element: this.datepickerTarget,
      css: [
        'https://cdn.jsdelivr.net/npm/@easepick/core@1.2.1/dist/index.css',
        'https://cdn.jsdelivr.net/npm/@easepick/range-plugin@1.2.1/dist/index.css',
        'https://cdn.jsdelivr.net/npm/@easepick/lock-plugin@1.2.1/dist/index.css',
      ],
      plugins: ['RangePlugin', 'LockPlugin'],
      RangePlugin: {
        tooltip: true,
      },
      setup(picker) {
        picker.on("select", setDates)
      },
      LockPlugin: {
        filter(fulldate) {
          const date = `${fulldate.getFullYear()}-${('0' + (fulldate.getMonth() + 1)).slice(-2)}-${('0' + fulldate.getDate()).slice(-2)}`
          return unavailableDates.includes(date)
        }
      },
    });
  }

  setDates(e) {
    const endDate = (this.convertDate(e.detail.end))
    const startDate = (this.convertDate(e.detail.start))
    const number_of_nights = ((e.detail.end - e.detail.start)/ (1000 * 3600 * 24))
    const totalNightPrice = number_of_nights * this.priceValue

    this.startDateTarget.innerHTML = startDate
    this.endDateTarget.innerHTML = endDate

    this.startDateInputTarget.value = startDate
    this.endDateInputTarget.value = endDate
    // this.freeCancellationTarget.value = `
    // <i class="fa-regular fa-calendar"></i>
    // <div class="ms-2">
    //   <p class="listing-general-details-title my-0">Free cancellation before ${this.startDate}</p>
    // </div>`

    this.submitTarget.disabled = false;

    this.totalNightsPriceTarget.innerText = `$${totalNightPrice} SGD`;
    this.totalPriceTarget.innerText = `$${(totalNightPrice + this.cleaningFeeValue + this.serviceFeeValue).toFixed(2)} SGD`

    // let start_date = this.convertDate(e.detail.start)
    // let end_date = this.convertDate(e.detail.end)

    // document.querySelector("#start_date_display").innerHTML = this.convertDate(e.detail.start)
    // document.querySelector("#end_date_display").innerHTML = this.convertDate(e.detail.end)

    // console.log(number_of_nights)


    this.totalNightsTarget.innerText = ` X ${number_of_nights} nights`
    // this.freeCancellationTarget.innerHTML = freeCancellationHTML;
    // let price = Number(document.querySelector('[data-datepicker-price-value]').dataset.datepickerPriceValue)
    // let total_price = number_of_nights * price
    // document.querySelector("#total_nights_price").innerText = `$${total_price} SGD`
    // document.querySelector("#total_price").innerText = `$${total_price + 26 + 73} SGD`
    // document.querySelector("#partial-cancellation-date").innerHTML = `${start_date}`
  }

  convertDate(date) {
    var yyyy = date.getFullYear().toString();
    var mm = (date.getMonth()+1).toString();
    var dd  = date.getDate().toString();

    var mmChars = mm.split('');
    var ddChars = dd.split('');

    return yyyy + '-' + (mmChars[1]?mm:"0"+mmChars[0]) + '-' + (ddChars[1]?dd:"0"+ddChars[0]);
  }

   open() {
    this.picker.show();
  }
}
