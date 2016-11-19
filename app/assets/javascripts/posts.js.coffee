class @Posts
  constructor: (opts = {}) ->
    @calendarDate = new Date(opts.startDate)

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

    @loadCalendarMonth(@nextMonth(@calendarDate))
    @loadCalendarMonth(@prevMonth(@calendarDate))

    # bind the month links
    $('div.archive a[data-click]').on 'click', (e) => @onMonthClick(e)

  loadCalendarMonth: (date, replaceCalendar = false) ->
    dateString = date.toLocaleDateString()

    $.ajax
      url: "/posts/calendar.js"
      data: 
        start_date: dateString
      method: 'GET'
      dataType: 'html'
      success: (data) =>
        @calendarData[dateString] = data

        if replaceCalendar
          @replaceCalendar(data, date)

  onMonthClick: (e) ->
    e.preventDefault()

    if $(e.target).data('click') == 'calendar-prev'
      date = @prevMonth(@calendarDate)
      nextDate = @prevMonth(date)
    else if $(e.target).data('click') == 'calendar-next'
      date = @nextMonth(@calendarDate)
      nextDate = @nextMonth(date)
    else
      throw "Unknown click type #{$(e.target).data('click')}"

    cachedData = @getCachedCalendarData(date)
    if cachedData?
      @replaceCalendar(cachedData, date)
    else
      @loadCalendarMonth(date, true)

    # cache the month forward
    @loadCalendarMonth(nextDate)

  replaceCalendar: (html, date) ->
    $('div.archive').html(html)
    @calendarDate = date
    $('div.archive a[data-click]').on 'click', (e) => @onMonthClick(e)

  nextMonth: (date) ->
    nextMonth = new Date(date)
    nextMonth.setDate(1)
    nextMonth.setMonth(date.getMonth() + 1)

    nextMonth

  prevMonth: (date) ->
    prevMonth = new Date(date)
    prevMonth.setDate(1)
    prevMonth.setMonth(date.getMonth() - 1)

    prevMonth

  getCachedCalendarData: (date) ->
    @calendarData[date.toLocaleDateString()]