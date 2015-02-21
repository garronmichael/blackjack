# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    console.log @get('dealerHand').shownScore()
    if @get('playerHand').scores()[0] is 21 or @get('playerHand').scores()[1] is 21
      @get('playerHand').stand()
    @get('playerHand').on('end', =>
      @get('dealerHand').forEach (model) ->
        if model.get('revealed') is false then model.flip()

      if @get('playerHand').bestScore() > @get('dealerHand').bestScore() && @get('playerHand').bestScore() <=21
        console.log 'You won'
      else
        console.log 'You lost'
      )
