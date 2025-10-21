import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // ターゲットの定義
  static targets = ["input", "preview", "image"]
  // デバッグ用のログ出力
  connect() {
    console.log("Preview controller connected")
  }

  currentObjectURL = null

  preview(event) {
    const file = event.target.files[0]
    //選択されたファイルを取得

    if (file) {
      // MIMEタイプで画像ファイルかどうかを確認
      if (file.type.startsWith('image/')) {
        // 既存のオブジェクトURLがあれば解放
        this.revokeCurrentObjectURL()

        // 新しいオブジェクトURLを作成
        this.currentObjectURL = URL.createObjectURL(file)

        this.imageTarget.src = this.currentObjectURL // srcに設定
        this.previewTarget.classList.remove('hidden')  // プレビューを表示
      } else {
        alert('画像ファイルを選択してください。')
        this.inputTarget.value = ''
      }
    } else {
      this.hidePreview()
    }
  }

  removeImage() {
    this.inputTarget.value = ''  // ファイル入力をクリア
    this.hidePreview()  // プレビューを非表示
  }

  hidePreview() {
    this.previewTarget.classList.add('hidden')  // CSSクラスで非表示
    this.imageTarget.src = ''   // 画像のsrcをクリア
    this.revokeCurrentObjectURL()  // オブジェクトURLを解放
  }

  // オブジェクトURLの解放処理
  revokeCurrentObjectURL() {
    if (this.currentObjectURL) {
      URL.revokeObjectURL(this.currentObjectURL)
      this.currentObjectURL = null
    }
  }

  // コントローラーが破棄される時にもクリーンアップ
  disconnect() {
    this.revokeCurrentObjectURL()
  }
}
