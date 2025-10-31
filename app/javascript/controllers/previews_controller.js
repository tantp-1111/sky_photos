import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview", "image"]

  connect() {
    console.log("Preview controller connected")
  }

  async preview(event) {
    const file = event.target.files[0]
    const maxSizeInBytes = 10 * 1024 * 1024 // 10MB
    const validTypes = ["image/jpeg", "image/jpg", "image/png"]

    if (!validTypes.includes(file.type)) {
      alert("JPEG、JPG、PNG形式のファイルを選択してください。")
      this.removeImage()
      return
    }

    if (file.size > maxSizeInBytes) {
      alert("ファイルサイズは10MB以下にしてください。")
      this.removeImage()
      return
    }

    // 圧縮・リサイズ処理
    const compressedFile = await this.compressImage(file, 1024, 0.8) // 最大1024px, JPEG圧縮率80%
    this.updatePreview(compressedFile)
    
    // フォームにセットするため input の files を置き換える
    const dataTransfer = new DataTransfer()
    dataTransfer.items.add(compressedFile)
    this.inputTarget.files = dataTransfer.files
  }

  // Canvas で画像をリサイズ＆圧縮
  compressImage(file, maxSize, quality) {
    return new Promise((resolve, reject) => {
      const img = new Image()
      img.onload = () => {
        let [newWidth, newHeight] = [img.width, img.height]

        // 縦横比を維持して最大サイズに収める
        if (newWidth > newHeight && newWidth > maxSize) {
          newHeight = (maxSize / newWidth) * newHeight
          newWidth = maxSize
        } else if (newHeight > maxSize) {
          newWidth = (maxSize / newHeight) * newWidth
          newHeight = maxSize
        }

        const canvas = document.createElement("canvas")
        canvas.width = newWidth
        canvas.height = newHeight
        const ctx = canvas.getContext("2d")
        ctx.drawImage(img, 0, 0, newWidth, newHeight)

        canvas.toBlob(
          (blob) => {
            // 元のファイル名と MIME タイプを維持した Blob を生成
            const compressedFile = new File([blob], file.name, { type: file.type })
            resolve(compressedFile)
          },
          file.type,
          quality
        )
      }
      img.onerror = reject
      img.src = URL.createObjectURL(file)
    })
  }

  // プレビュー更新
  updatePreview(file) {
    const reader = new FileReader()
    reader.readAsDataURL(file)
    reader.onload = (e) => {
      this.imageTarget.src = e.target.result
      this.previewTarget.classList.remove("hidden")
    }
  }

  removeImage() {
    this.inputTarget.value = null
    this.imageTarget.src = null
    this.previewTarget.classList.add("hidden")
  }

  disconnect() {
    console.log("Preview controller disconnected")
  }
}
