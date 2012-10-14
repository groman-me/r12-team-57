class NarrationsController < ApplicationController
  before_filter :authentication_required!

  respond_to :html

  def create
    attributes = params[:narration].merge(state: Narration::STATES[:not_ready]).
      merge(params.slice('time_code'))
    @narration = deck.create_narration(attributes)
    respond_with(@deck.user, @deck, @narration, status: 202, text: 'accepted')
  end

  protected

  def deck
    @deck ||= current_user.decks.find(params[:deck_id].to_s)
  end
end
