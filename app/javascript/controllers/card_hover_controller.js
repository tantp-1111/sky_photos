import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["overlay"]

  connect() {
    // 初期状態でオーバーレイを下に隠す
    this.overlayTarget.style.transform = "translateY(100%)"
  }

  mouseEnter() {
    // ホバー時にオーバーレイを上にスライド
    this.overlayTarget.style.transform = "translateY(0%)"
  }

  mouseLeave() {
    // ホバー終了時にオーバーレイを下に戻す
    this.overlayTarget.style.transform = "translateY(100%)"
  }
}