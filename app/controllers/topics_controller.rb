class TopicsController < ApplicationController
  load_and_authorize_resource

  def show
    @topic = Topic.find(params[:id])
    @faqs = @topic.tickets.public.page(params[:page]).per(10)
  end
end
