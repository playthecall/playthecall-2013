window.playTheCall = window.playTheCall or {}
window.playTheCall.worker =
  init: ->
    do playTheCall.worker.verifyTextToTruncate
    do playTheCall.worker.dropDownInit

  dropDownInit: ->
    do playTheCall.worker.dropDownLeave
    do playTheCall.worker.dropDownEnter
    do playTheCall.worker.dropDownClick

  dropDownLeave: ->
    $('.content-header li.settings').mouseleave (e) ->
      drop = $(@).next('ul')
      $(@).removeClass('active')
      $(@).find('ul').fadeOut('fast')

  dropDownEnter: ->
    $('.content-header li.settings').mouseenter (e) ->
      drop = $(@).next('ul')
      $(@).addClass('active')
      $(@).find('ul').fadeIn('fast')

  dropDownClick: ->
    $('.content-header li.settings > a').click (e) ->
      drop = $(@).next('ul')
      $(@).next('ul').fadeToggle()
      $(@).parent().toggleClass('active')
      $(document).click (e) ->
        $(document).unbind('click')
        $('li.settings ul').fadeOut()
        e.preventDefault()
      e.stopPropagation()

  verifyTextToTruncate: ->
    countText = $(".bio").text().length
    if countText >= '200'
      do playTheCall.worker.truncateText
    else
      $(".more").remove()

  truncateText: ->
    $(".bio").addClass("moreText")
    $(".more").live 'click', (e) ->
      window.btnText
      window.btnTextAlt
      e.preventDefault()
      btnText = $(this).html()
      btnTextAlt = $(this).data('text')
      $(this).html(btnTextAlt).data('text',btnText)
      $(".bio").toggleClass("moreText")
      false

$(document).ready ->
  playTheCall.worker.init()
