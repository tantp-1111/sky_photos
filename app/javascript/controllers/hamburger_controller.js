import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hamburger"
export default class extends Controller {
  static targets = ["menu"]

  // メニュー外をクリックしたら閉じる（オプション）
  connect() {
    // thisを今のオブジェクトに固定
    this.closeOnClickOutside = this.closeOnClickOutside.bind(this)
  }

  closeOnClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add("hidden")
    }
  }

  toggle() {
    if (this.menuTarget.classList.contains("hidden")) {
      // メニューを開く
      this.menuTarget.classList.remove("hidden")
      document.addEventListener("click", this.closeOnClickOutside)
    } else {
      // メニューを閉じる
      this.menuTarget.classList.add("hidden")
      document.removeEventListener("click", this.closeOnClickOutside)
    }
  }
}
