class NarrationsController < ApplicationController
  before_filter :authentication_required!

  respond_to :html

  def create
    @narration = deck.create_narration(params[:narration].merge(state: Narration::STATES[:not_ready]))
    respond_with(@deck.user, @deck, @narration, status: 202, text: 'accepted')
  end

  protected

  def deck
    @deck ||= current_user.decks.find(params[:deck_id].to_s)
  end
end
