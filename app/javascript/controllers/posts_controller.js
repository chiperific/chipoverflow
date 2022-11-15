import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    id: Number,
    url: String
  }

  upvote() {
    this.urlValue = "/posts/" + this.idValue + "/vote?d=upvoted";

    fetch(this.urlValue)
      .then(response => response.text())
      .then(html => this.element.innerHTML = html)
  }

  downvote() {
    this.urlValue = "/posts/" + this.idValue + "/vote?d=downvoted";

    fetch(this.urlValue)
      .then(response => response.text())
      .then(html => this.element.innerHTML = html)
  }

  bookmark() {
    this.urlValue = "/posts/" + this.idValue + "/bookmark";

    fetch(this.urlValue)
      .then(response => response.text())
      .then(html => this.element.innerHTML = html)
  }
}
