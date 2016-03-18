require "pry"
class LinksController < ApplicationController
  before_action :auth_user, only: [:edit, :new, :show, :destroy]
  before_action :set_link, only: [:edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token

  # GET /links
  # GET /links.json
  def index
    @links = Link.all
  end

  # GET /links/1
  # GET /links/1.json
  def show
    @link = Link.find_by_slug(params[:slug])

    if @link.nil? || @link.active == false
      short_url = ENV["BASE_URL"] + params[:slug]
      flash[:error] = "The Url '#{short_url}' has been disabled or deleted"
      redirect_to root_path
      return
    end

    @link.clicks += 1
    @link.save

    redirect_to @link.given_url
  end

  # GET /links/new
  def new
    @link = Link.new
    @links = Link.order(clicks: :desc)

    unless session[:user_id].nil?
      @links = Link.where(user_id: session[:user_id]).order(clicks: :desc)
    end
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)
    @link.user_id = session[:user_id]

    respond_to do |format|
      if @link.save
        format.html do
          redirect_to root_path,
                      notice: "Short Url is '#{@link.display_slug}'"
        end
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html do
          redirect_to new_link_path,
                      notice: "Link was successfully updated."
        end
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html do
        redirect_to root_path,
                    notice: "Link was successfully deleted."
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def link_params
    params.require(:link).permit(:given_url, :slug, :active)
  end

  def auth_user
    @current_user = User.find(session[:user_id]) unless session[:user_id].nil?
  end
end
