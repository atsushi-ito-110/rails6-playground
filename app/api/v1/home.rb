class V1::Home < Grape::API
  resource :home do
    params do
      requires :hoge, type: Integer, desc: 'ほげです'
    end
    post '/' do
      Rails.logger.info('hoge')
      status :ok
    end
    get '/' do
      Rails.logger.info('hoge')
      status :ok
    end
  end

  # private
  # def logger
  #   Rails.logger
  # end
end
