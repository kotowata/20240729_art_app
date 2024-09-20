module ApplicationHelper
  def page_title(title = "")
    base_title = "ArtSpotly"
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  def default_meta_tags
    {
      site: "Pluspo",
      title: "アートを楽しむためのアプリ",
      reverse: true,
      charset: "utf-8",
      description: "訪れた美術展のポスター写真を投稿して皆でアートを楽しみましょう。",
      keywords: "美術,アート,美術館",
      canonical: request.original_url,
      separator: "|",
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: "website",
        url: request.original_url,
        image: image_url("ogp.jpg"),
        local: "ja-JP"
      },
      twitter: {
        card: "summary_large_image", # Twitterで表示する場合は大きいカードにする
        image: image_url("ogp.jpg")
      }
    }
  end
end
