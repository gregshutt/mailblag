class MarkdownRenderer < Redcarpet::Render::HTML
  def image(link, title, alt_text)
    # add img-thumbnail class to images
    %Q(<img src="#{link}" alt="#{alt_text}" class="img-thumbnail"/>)
  end

  def link(link, title, content)
    # check for links with images
    has_image = false
    if content =~ /<img/
      has_image = true
    end

    %Q(<a href="#{link}" title="#{title}" #{has_image ? 'data-has-image=true' : ''}>#{content}</a>)
  end
end