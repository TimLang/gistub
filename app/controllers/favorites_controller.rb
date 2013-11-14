# -*- encoding : utf-8 -*-
class FavoritesController < ApplicationController

  before_filter :login_required

  respond_to :html

  def create
    @gist = Gist.find_commentable_gist(params[:gist_id], current_user.try(:id))
    fav = Favorite.new
    fav.gist_id = @gist.id
    fav.user_id = current_user.id
    if fav.save
      redirect_to gist_path(@gist.id), notice: '您喜欢这个分享.'
    else
      render action: '../gists/show'
    end
  end

  def destroy
    own_fav = Favorite.where(id: params[:id], user_id: current_user.try(:id)).first
    destroy_and_redirect_to_gist(own_fav, '您取消了喜欢', '没有找到.')
  end

end
