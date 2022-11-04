import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    id: Number,
    baseUrl: String,
    url: String
  }

  connect() {
    this.baseUrlValue = "/posts/" + this.idValue
  }


  upvote() {
    this.urlValue = this.baseUrlValue + "/vote?d=upvoted";

    fetch(this.urlValue)
      .then(response => response.text())
      .then(html => this.element.innerHTML = html)
  }

  downvote() {
    this.urlValue = this.baseUrlValue + "/vote?d=downvoted";

    fetch(this.urlValue)
      .then(response => response.text())
      .then(html => this.element.innerHTML = html)
  }

  bookmark() {
    this.urlValue = this.baseUrlValue + "/bookmark";

    fetch(this.urlValue)
      .then(response => response.text())
      .then(html => this.element.innerHTML = html)
  }
}
