module BooksHelper
  # アフィリエイトリンクを生成
  def afilink(book)
    ret = link_to image_tag(book.image_url || "now_printing.png", {size: Settings.system[:image][:thumbnail][:size]}), book.default_url, {target: "_blank"}
    ret += " "
    ret += link_to "Amazon", book.amazon_url, {target: "_blank"} if book.amazon_url.present? 
    ret += " "
    ret +=link_to "楽天", book.url, {target: "_blank"} if book.url.present? 

    ret
  end
end
