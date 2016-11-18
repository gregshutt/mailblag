class @Posts
  constructor: (opts = {}) ->
    $.fn.ekkoLightbox.defaults.left_arrow_class = '.fa .fa-chevron-left'
    $.fn.ekkoLightbox.defaults.right_arrow_class = '.fa .fa-chevron-right'
    $.fn.ekkoLightbox.defaults.loadingMessage = 'Loading...'

    # group all images in a post in a gallery
    $('div.post a[data-has-image]').attr('data-gallery', 'abc').data('gallery', 'abc').attr('data-toggle', 'lightbox')

    # bind all lightbox links
    $('[data-toggle="lightbox"]').click (e) ->
      e.preventDefault()
      $(@).ekkoLightbox()
    
    # load previous and next month calendars
    @calendarData = {}

  loadCalendarMonth: (date) ->
    $.ajax
      url: "/posts/calendar.js"
      data: 
        start_date: date
      method: 'GET'
      dataType: 'html'
      success: (data) ->
        console.log data