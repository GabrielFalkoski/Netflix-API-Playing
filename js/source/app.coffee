# It runs in all pages
App.pages.home = ($) ->
  # Links a posts
  $('.show-more').on 'click', (e) ->
    e.preventDefault()
    App.moviesPage++
    App.modules.templateMovies(App.moviesPage)
    $('input', $(this)).attr('checked', false)
    $('.show-more').fadeOut() if App.moviesPage == App.moviesPagesTotal

  s = $('#s')
  s.parent().submit (e) ->
    e.preventDefault()
    s.focusout()
  .keypress (e) ->
    if ( 13 is e.which )
      App.modules.searchMovies(s.val())
    if ( s.val().length > 5 )
      App.modules.searchMovies(s.val())
   
  $.template 'movieTemplate', App.movieMarkup
  
  App.modules.sortMovies($)

# Search
App.modules.searchMovies = (val) ->
  $.ajax
    method: "GET"
    url: '//netflixroulette.net/api/api.php' 
    data:
      actor:val
  .done (r) ->
    movies = jQuery('#movies')
    movies.empty()
    App.modules.showMovies(r)
    $('#sort-movies').fadeIn 400, ->
      $('input', $(this)).attr('checked', false)
      $('.show-more').fadeIn()
  .fail (r) ->
    alert r.responseJSON.message
  .always () ->

# Sort
App.modules.sortMovies = ($) ->
  $("#movies").mixItUp
    layout:
      containerClass: 'list'

# Movies
App.modules.showMovies = (data) ->
  count = data.length
  i = 1
  l = Math.ceil(count / 5)
  App.moviesPagesTotal = l
  while i <= l
    f = i-1
    s = if i == l then count else i*5 
    this.showMovies[i] = data.slice(f*5,s)
    i++
  App.moviesPage = 1
  App.modules.templateMovies(1)

App.modules.templateMovies = (page) ->
  console.log page
  $.tmpl('movieTemplate', App.modules.showMovies[page]).appendTo '#movies'