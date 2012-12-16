window.home = window.home || {}

window.home.base =
  init: ->
    $('a.sign_in').click (e) ->
      home.base.loginModal()
      e.preventDefault()

  loginModal: () ->
    $('.dialog.login').dialog
      width: 400,
      resizable: false,
      draggable: false,
      modal: true,
      close: (event,ui)->
        $('.ui-dialog').html('')
        $('.dialog.login ul li input').val('')

$(document).ready ->
  home.base.init()
