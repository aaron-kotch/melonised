import { Controller } from "@hotwired/stimulus"
import { marked } from "marked"

export default class extends Controller {
  static targets = ["source", "output"]

  connect() {
    this.observer = new MutationObserver(() => {
      this.render()
    })

    this.observer.observe(this.sourceTarget, {
      childList: true,
      subtree: true,
      characterData: true
    })

    this.render()
  }

  disconnect() {
    this.observer.disconnect()
  }

  render() {
    const rawText = this.sourceTarget.textContent
    const formatted = marked.parse(rawText, { breaks: true, gfm: true })
    this.outputTarget.innerHTML = formatted
  }
}
