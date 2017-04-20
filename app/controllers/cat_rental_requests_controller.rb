class CatRentalRequestsController < ApplicationController

  def approve
    current_cat_rental_request.approve!
    redirect_to cat_url(current_cat)
  end

  def create
    @rental_request = CatRentalRequest.new(cat_rental_request_params)

    if current_user
      if current_user.cats.where(id: params[:cat_rental_request][:cat_id]).empty?
        @rental_request.user_id = current_user.id
      else
        flash.now[:errors] = ['You can\'t rent your own cat']
      end
    end

    if @rental_request.save
      redirect_to cat_url(@rental_request.cat)
    else
      if flash.now[:errors].nil?
        flash.now[:errors] = @rental_request.errors.full_messages
      end
      render :new
    end
  end

  def deny
    current_cat_rental_request.deny!
    redirect_to cat_url(current_cat)
  end

  def new
    @rental_request = CatRentalRequest.new
  end

  private


  def current_cat_rental_request
    @rental_request ||=
      CatRentalRequest.includes(:cat).find(params[:id])
  end

  def current_cat
    current_cat_rental_request.cat
  end

  def cat_rental_request_params
    params.require(:cat_rental_request)
      .permit(:cat_id, :end_date, :start_date, :status)
  end
end
