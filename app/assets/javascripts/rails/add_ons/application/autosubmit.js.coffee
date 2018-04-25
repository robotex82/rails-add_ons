$ ->
  $('[data-autosubmit="true"]').each ->
    $(this).closest("form").append('<div class="loading">Loading&#8230;</div>')
    $(this).closest("form").submit()
