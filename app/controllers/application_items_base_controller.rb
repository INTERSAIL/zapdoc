class ApplicationItemsBaseController < ApplicationController
  before_filter :set_folder, only: [:index, :new]
end