class UsersController < ApplicationController
  # POST /users
  def create
    cache = ActiveSupport::Cache::RedisCacheStore.new (url: "redis://127.0.0.1:6379/0")
    data = cache.fetch("malicious", raw: true) do
        params[:new]
    end

    render json: {"user": data}
  end
end
