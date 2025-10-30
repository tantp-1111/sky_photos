import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // ターゲットの定義
  static targets = ["input", "preview", "image"]
  // デバッグ用のログ出力
  connect() {
    console.log("Preview controller connected")
  }

  preview(event) {
    const file = event.target.files[0]
    const maxSizeInBytes = 10 * 1024 * 1024 // 10MB
    const validTypes = ["image/jpeg", "image/jpg", "image/png"]

    // MIMEタイプのチェック
    if (!validTypes.includes(file.type)) {
      alert("JPEG、JPG、PNG形式のファイルを選択してください。")
      // 不正なファイル形式の場合のアラート表示
      this.removeImage()
      return
    }
    // ファイルサイズのチェック
    if (file.size < maxSizeInBytes ) {
      const reader = new FileReader()
      //readerをfilereaderオブジェクトとして定義
      reader.readAsDataURL(file)
      // ファイルをデータURLとして読み込む
      reader.onload = (e) => {
        // readerにファイル読み込み完了時の処理を定義
        this.imageTarget.src = e.target.result
        // 読み込んだデータをプレビュー画像のsrcに設定,e.targetでイベントを発生させたFilereaderオブジェクトを取得
        this.previewTarget.classList.remove("hidden")
        // プレビューエリアのhiddenクラスを削除して表示
      }
    } else {
      alert("ファイルサイズは10MB以下にしてください。")
      // ファイルが大きすぎる場合のアラート表示
      this.removeImage()
    }
  }

  // 画像削除処理
  removeImage() {
    this.inputTarget.value = null
    this.imageTarget.src = null
    this.previewTarget.classList.add("hidden")
  }

  // デバッグ用
  disconnect() {
    this.revokeCurrentObjectURL()
    console.log("Preview controller disconnected")
  }
}