# It runs in all pages
App.pages.home = ($) ->
  App.modules.search($)

# Links a posts
$('.ajax-pagination').delegate 'a', 'click', (e) ->
  self = $(this)
  url = self.attr('href')
  
  if ( url.indexOf( App.baseurl ) isnt -1 || url.substr(0,1) is '?' )
    e.preventDefault()
    content = self.closest('article').find('.content')
    content.animate {opacity:0.4}, ->
      $.get url, {ajax:true}, (response) ->
        content.html(response).animate {opacity:1}

# Search
App.modules.search = ($) ->
  s = $('#s')
  s.parent().submit (e) ->
    e.preventDefault()
  s.keypress (e) ->
    if ( 13 is e.which )
      $.get '//netflixroulette.net/api/api.php', {actor:s.val()}, (r) ->
        $.each r, (i, movie) ->
          console.log movie.show_title
