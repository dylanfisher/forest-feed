class Admin::Forest::Feed::ItemsController < Forest::Feed::AdminController
  before_action :set_item, only: [:edit, :update, :destroy]

  def index
    @pagy, @items = pagy apply_scopes(Forest::Feed::Item).by_post_date
    authorize @items, :admin_index?
  end

  def new
    @item = Forest::Feed::Item.new
    authorize @item
  end

  def edit
    authorize @item
  end

  def create
    @item = Forest::Feed::Item.new(item_params)
    authorize @item

    if @item.save
      redirect_to edit_admin_forest_feed_item_path(@item), notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @item

    if @item.update(item_params)
      redirect_to edit_admin_forest_feed_item_path(@item), notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @item
    @item.destroy
    redirect_to admin_forest_feed_items_url, notice: 'Item was successfully destroyed.'
  end

  def sync
    authorize [:forest, :feed, :item], :sync?

    if Forest::Feed::SyncItemsJob.perform_later
      notice = 'Item sync initiated in a background process. Refresh your browser in a few minutes to view the new items.'
    else
      notice = 'Items failed to sync.'
    end

    redirect_to admin_forest_feed_items_path, notice: notice
  end

  private

  def item_params
    # Add blockable params to the permitted attributes if this record is blockable `**BlockSlot.blockable_params`
    params.require(:item).permit(:service, :user_id, :user_display_name, :service_id, :data)
  end

  def set_item
    @item = Forest::Feed::Item.find(params[:id])
  end
end
