module ApplicationHelper
  
  def format_date(date)
    return nil if date.nil?

    date = Time.at(date).to_datetime if date.is_a? Integer

    date.strftime("%b %-d, %Y")
  end

  def format_datetime(date)
    return nil if date.nil?
    
    date.strftime("%b %-d, %Y at %l:%M%P")
  end

  def format_time(date)
    return nil if date.nil?

    date = Time.at(date).to_datetime if date.is_a? Integer

    date.strftime("%l:%M%P")
  end

  def markdown(text, filter_html = false)
    return '' if text.nil?

    options = {
      filter_html:     filter_html,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: '_blank' },
      space_after_headers: true, 
      safe_links_only: true,

      fenced_code_blocks: true
    }
 
    extensions = {
      autolink:           true,
      superscript:        true,
      lax_spacing:        true,
      disable_indented_code_blocks: true,
      tables:             true
    }
 
    renderer = MarkdownRenderer.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)
 
    markdown.render(text).html_safe
  end
end
