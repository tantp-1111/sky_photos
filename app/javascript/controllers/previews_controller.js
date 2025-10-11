import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // ターゲットの定義
  static targets = ["input", "preview", "image"]
  // デバッグ用のログ出力
  connect() {
    console.log("Preview controller connected")
  }

  preview(event) {
    const file = event.target.files[0]   //選択されたファイルを取得

    if (file) {
      if (file.type.startsWith('image/')) {   // 画像ファイルかどうかを確認
        const reader = new FileReader()

        reader.onload = (e) => {
          this.imageTarget.src = e.target.result   // 画像のsrcに設定
          this.previewTarget.classList.remove('hidden')   // プレビューを表示
        }

        reader.readAsDataURL(file)   // ファイルをData URLとして読み込み
      } else {
        alert('画像ファイルを選択してください。')
        this.inputTarget.value = ''   // 入力フィールドをクリア
      }
    } else {
      this.hidePreview()   // ファイルが選択されていない場合は非表示

    }
  }

  removeImage() {
    this.inputTarget.value = ''  // ファイル入力をクリア
    this.hidePreview()  // プレビューを非表示
  }

  hidePreview() {
    this.previewTarget.classList.add('hidden')  // CSSクラスで非表示
    this.imageTarget.src = ''   // 画像のsrcをクリア
  }
}