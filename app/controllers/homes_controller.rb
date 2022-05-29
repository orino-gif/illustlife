class HomesController < ApplicationController
  # User.all # 論理削除済ユーザも含んだ全てのユーザを取得
  # User.only_soft_destroyed # 論理削除済ユーザのみ取得
  
  def index
    # @creators = Creator.all.order(number_of_works: 'DESC')
    @requests = Request.all
    
    @users = User.without_soft_destroyed # 論理削除済ユーザを除外して取得
  end
end
