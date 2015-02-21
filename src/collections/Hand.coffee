class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    if @minScore() < 21
      @add(@deck.pop())
    if @minScore() > 21
      @stand()
  ,
  stand: ->
    @trigger('end', @)

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  shownScore: -> @reduce (score, card) ->
    result = score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  minScore: -> @reduce (score, card) ->
    score + card.get 'value'
  , 0

  maxScore: ->
    @reduce (sum, card) ->
      sum + if card.get('rankName') is 'Ace' then card.get('value') + 10 else card.get 'value'
    , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    scores = []
    scores.push(@shownScore())
    if @shownScore() < (@shownScore() + 10 * @hasAce())
      scores.push( @shownScore() + 10 * @hasAce() )
    return scores

    # [@shownMinScore(), @shownMinScore() + 10 * @hasAce()]

  bestScore: ->
    if @maxScore() <= 21
      return @maxScore()
    else
      return @minScore()


