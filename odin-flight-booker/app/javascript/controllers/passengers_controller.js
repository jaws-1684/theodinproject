import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["formContainer", "formTemplate", "passengerForm", "output"]

  connect() {
    this.index = this.passengerFormTargets.length
  }

  add() {
    const clone = this.formTemplateTarget.innerHTML.replace(/__INDEX__/g, this.index)
    this.formContainerTarget.insertAdjacentHTML("beforeend", clone)
    this.index++
    this.outputTarget.textContent = `Passenger ${this.index}`
  }

  remove(event) {
    if (this.passengerFormTargets.length > 1) {
      event.target.closest('[data-passengers-target="passengerForm"]').remove()
    } else {
      alert("At least one passenger is required.")
    }
  }
}
