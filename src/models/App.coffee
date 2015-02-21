# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    if @get('playerHand').scores()[0] is 21 or @get('playerHand').scores()[1] is 21
      @get('playerHand').stand()
    @get('playerHand').on('end', =>
      console.log('end')
      @get('dealerHand').forEach (model) ->
        if model.get('revealed') is false then model.flip()

      if @get('playerHand').scores()[0] / 21 > @get('dealerHand').scores()[0] / 21
        if @get('playerHand').scores()[0] <= 21
          console.log 'You won'
      else if @get('playerHand').scores[1] / 21 > @get('dealerHand').scores()[1] / 21
        if @get('playerHand').scores()[1] <= 21
          console.log 'You won'
      else
        console.log 'You lost'
      )
