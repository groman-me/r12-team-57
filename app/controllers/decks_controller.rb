class DecksController < ApplicationController
  before_filter :authentication_required!, except: [:index, :show]

  respond_to :html

  def index
    @decks = user.decks
    respond_with current_user, @decks
  end

  def new
    @deck = current_user.decks.new
    respond_with @deck.user, @deck
  end

  def create
    @deck = current_user.decks.create_from_oembed_deck(params[:deck])
    respond_with @deck.user, @deck
  end

  def show
    @deck = user.decks.find(params[:id].to_s)
    respond_with @deck.user, @deck
  end

  protected

  def user
    @user ||= User.find(params[:user_id].to_s)
  end
end
