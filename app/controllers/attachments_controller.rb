class AttachmentsController < ApplicationController

  before_action :find_attachable

  def destroy
    
  end

private
  
  def attachment_params
    params.require(:attachment).permit(:attachment)
  end

end
