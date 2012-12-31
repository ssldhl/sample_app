class FormsController < ApplicationController
 before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def create
  	 @form = current_user.forms.build(params[:form])
    if @form.save
      flash[:success] = "Form created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'search/index'
    end
  end

  def destroy
    @form.destroy
    redirect_back_or root_path
  end

  private

    def correct_user
      @form = current_user.forms.find_by_id(params[:id])
      redirect_to root_path if @form.nil?
    end
end