import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'phone', 'toast' ]

  showPhone() {
    fetch('/showphone')
      .then(response => response.text())
      .then(html => this.phoneTarget.innerHTML = html)
      .then(Stacks.showModal(document.querySelector('#modal-phone')))
  }

  showToast(event) {
    this.toastValue = document.querySelector('#email-sent-toast')

    const wait = (ms) => new Promise(res => setTimeout(res, ms));

    const startAsync = async () => {
      await wait(1500)
      this.toastValue.ariaHidden = 'false'
      await wait(1500)
      document.getElementById('email-form').reset()
      await wait(3000)
      this.toastValue.ariaHidden = 'true'
    }

    startAsync()
  }
}
