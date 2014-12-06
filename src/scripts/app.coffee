# 宗派
denomination = 17

$ '#birthdayForm'
.on 'submit', ->
  $this = $ @
  $result = $ '#result'

  birthday = moment
    year: $this.find('.year').val()
    month: $this.find('.month').val() - 1
    day: $this.find('.day').val()
    hour: 0
    minute: 0
    second: 0
  now = moment
    hour: 0
    minute: 0
    second: 0
  months = now.diff birthday, 'months'

  $result
  .find '.years'
  .text denomination

  $result
  .find '.months'
  .text months - 12 * denomination

  $result.modal()