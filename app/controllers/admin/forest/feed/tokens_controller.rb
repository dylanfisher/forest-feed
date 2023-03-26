class Admin::Forest::Feed::TokensController < Forest::Feed::AdminController
  before_action :set_token, only: [:edit, :update, :destroy]

  def index
    @pagy, @tokens = pagy apply_scopes(Forest::Feed::Token).by_id
    authorize @tokens, :admin_index?
  end

  def new
    @token = Forest::Feed::Token.new
    authorize @token
  end

  def edit
    authorize @token
  end

  def create
    @token = Forest::Feed::Token.new(token_params)
    authorize @token

    if @token.save
      redirect_to edit_admin_forest_feed_token_path(@token), notice: 'Token was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @token

    if @token.update(token_params)
      redirect_to edit_admin_forest_feed_token_path(@token), notice: 'Token was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @token
    @token.destroy
    redirect_to admin_forest_feed_tokens_url, notice: 'Token was successfully destroyed.'
  end

  private

  def token_params
    # Add blockable params to the permitted attributes if this record is blockable `**BlockSlot.blockable_params`
    params.require(:token).permit(:service, :user_id, :user_display_name, :code)
  end

  def set_token
    @token = Forest::Feed::Token.find(params[:id])
  end
end
