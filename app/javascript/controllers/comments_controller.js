import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    id: Number,
    post: Number,
    baseUrl: String,
    url: String
  }

  static targets = [ 'vote', 'flag' ]

  connect() {
    this.baseUrlValue = "/posts/" + this.postValue + "/comments/" + this.idValue
  }

  vote() {
    this.urlValue = this.baseUrlValue + "/vote"

    fetch(this.urlValue)
      .then(response => response.text())
      .then(html => this.voteTarget.innerHTML = html)
  }

  flag() {
    this.urlValue = this.baseUrlValue + "/flag"

    fetch(this.urlValue)
      .then(response => response.text())
      .then(html => this.flagTarget.innerHTML = html)
  }
}
