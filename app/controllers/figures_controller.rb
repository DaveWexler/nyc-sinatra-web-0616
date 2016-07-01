class FiguresController < ApplicationController

  get '/figures/new' do
    erb :'figures/new'
  end

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  post '/figures' do
      @figure = Figure.create(name: params[:figure][:name], title_ids: params[:figure][:title_ids], landmark_ids: params[:figure][:landmark_ids])
    if params[:figure][:title] == nil
      title = Title.create(params[:title])
      @figure.titles << title
    end
    if params[:figure][:landmark] == nil
      landmark = Landmark.create(params[:landmark])
      @figure.landmarks << landmark
    end

    erb :'figures/show'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'figures/edit'
  end

  patch '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    if params[:figure][:title] == nil
      title = Title.create(params[:title])
      @figure.titles << title
    end
    if params[:figure][:landmark] == nil
      landmark = Landmark.create(params[:landmark])
      @figure.landmarks << landmark
    end
    @figure.update(name: params[:figure][:name])
    redirect "/figures/#{@figure.id}"
  end

end