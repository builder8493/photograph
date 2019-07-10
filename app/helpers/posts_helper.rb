module PostsHelper
  def render_with_hashtags(content)
    content.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) {|word|
      link_to word, hashtag_post_path("#{word.delete("#").delete("＃")}"), class: "hashtag"}.html_safe
  end
end
