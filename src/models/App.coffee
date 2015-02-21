# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    if @get('playerHand').scores()[0] is 21 or @get('playerHand').scores()[1] is 21
      @get('playerHand').stand()
    console.log(@get('dealerHand').maxScore())
    @get('playerHand').on('end', =>
      @get('dealerHand').forEach (model) ->
        if model.get('revealed') is false then model.flip()
      )
