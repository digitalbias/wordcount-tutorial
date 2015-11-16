WordcountTutorialView = require './wordcount-tutorial-view'
{CompositeDisposable} = require 'atom'

module.exports = WordcountTutorial =
  wordcountTutorialView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @wordcountTutorialView = new WordcountTutorialView(state.wordcountTutorialViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @wordcountTutorialView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'wordcount-tutorial:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @wordcountTutorialView.destroy()

  serialize: ->
    wordcountTutorialViewState: @wordcountTutorialView.serialize()

  toggle: ->
    console.log 'WordcountTutorial was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
