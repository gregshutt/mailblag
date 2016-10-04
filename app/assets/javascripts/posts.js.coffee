$ ->
  # group all images in a post in a gallery
  $('div.post a[data-has-image]').attr('data-gallery', 'abc')

  # bind all lightbox links
  $('div.post a[data-has-image]').click (e) ->
    $(@).ekkoLightbox()
    e.preventDefault()