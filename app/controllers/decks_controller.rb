class DecksController < ApplicationController
  before_filter :authentication_required!, except: [:index, :show]

  respond_to :html

  def index
    @decks = user.decks
    respond_with(@decks)
  end

  def new
    @deck = current_user.decks.new
    respond_with @deck
  end

  def create
    @deck = current_user.decks.create(params[:deck]) do |instance|
      client = SpeakerDeck.new
      oembed = client.fetch(instance.url, maxwidth: 780) || {}

      instance.title = oembed['title']
      instance.author = oembed['author_name']
      instance.html = oembed['html']
      instance.width = oembed['width']
      instance.height = oembed['width']
    end

    respond_with @deck
  end

  def show
    @deck = user.decks.find_by_id(params[:id].to_s)
    respond_with @deck
  end

  protected

  def user
    @user ||= User.find_by_id(params[:user_id].to_s)
  end
end
