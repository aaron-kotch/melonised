import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // We use a tiny timeout to ensure the browser has rendered the initial state
    // before we apply the transform that triggers the animation.
    setTimeout(() => {
      this.element.classList.remove("translate-x-[150%]")
      this.element.classList.add("translate-x-0")
    }, 10)

    // Optional: Auto-slide out after 4 seconds
    setTimeout(() => { this.dismiss() }, 4000)
  }

  dismiss() {
    this.element.classList.add("translate-x-[150%]")
    
    // Completely remove from DOM after the slide-out animation finishes
    setTimeout(() => {
      this.element.remove()
    }, 500)
  }
}