import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'modalParent', 'phone' ]

  showPhone() {
    fetch('/showphone')
      .then(response => response.text())
      .then(html => this.phoneTarget.innerHTML = html)
      .then(Stacks.showModal(document.querySelector('#modal-base')))
  }
}
