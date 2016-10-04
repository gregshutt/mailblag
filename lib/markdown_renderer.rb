class MarkdownRenderer < Redcarpet::Render::HTML
  def image(link, title, alt_text)
    %Q(<img src="#{link}" alt="#{alt_text}" class="img-thumbnail"/>)
  end
end