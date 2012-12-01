class RankingController < ApplicationController
  def show
    @users_ranking = User.ranking
  end
end
