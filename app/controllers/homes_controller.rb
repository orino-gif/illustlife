class HomesController < ApplicationController
  def index
    @cres = Cre.joins(:pfm,:user).order(evl: 'DESC', created_at: 'DESC')
    @ovrs = Ovr.joins(:expor).all
    # selectメソッドでexpor_idの列を取得
    @expors = Expor.where.not(id: Ovr.all.select(:expor_id))
    @char_path_ttls = Char.joins(:path,:ttl).all
    @chars = Char.all
  end
end