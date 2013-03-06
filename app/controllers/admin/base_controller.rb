class Admin::BaseController < ApplicationController
  cattr_accessor :look_for_migrations
  @@look_for_migrations = true
  layout 'administration'
  before_filter :login_required, :except => [ :login, :signup ]
  before_filter :look_for_needed_db_updates, :except => [:login, :signup, :update_database, :migrate]
  before_filter :validate_merge, :only => [:merge]

  private
  def look_for_needed_db_updates
    if Migrator.offer_migration_when_available
      redirect_to :controller => '/admin/settings', :action => 'update_database' if Migrator.current_schema_version != Migrator.max_schema_version
    end
  end

  def validate_merge
    if params[:id] == params[:merge_with]
      flash[:error] = "Merged article id #{params[:merge_with]} is not allowed to merge itself"
      redirect_to :action => 'edit', :id => params[:id]
    end
    unless Article.exists? params[:merge_with].to_s
      flash[:error] = "Merged article id #{params[:merge_with]} does not exist"
      redirect_to :action => 'edit', :id => params[:id]
    end
  end
end

