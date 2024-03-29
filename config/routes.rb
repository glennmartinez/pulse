ActionController::Routing::Routes.draw do |map|
  map.resources :project
  map.close_project '/project/close/:id', :controller => :project, :action => :close
  map.reopen_project '/project/reopen/:id', :controller => :project, :action => :reopen
  map.list_closed_projects 'projects/all/closed', :controller => :projects, :action => :list_closed_projects
  map.export_project_as_csv '/project/:id/export', :controller => :project, :action => :export_as_csv
  map.export_project_dashboard_as_csv '/dashboard/:date/export', :controller => :dashboard, :action => :export_to_csv
  map.export_metrics_view_to_csv '/metrics_view/:metric/:from_date/:to_date', :controller => :metrics, :action => :export_to_csv
  map.new_iteration '/project/:project_id/new_iteration', :controller  => :iteration, :action  => :new
  map.save_iteration '/project/:project_id/save_iteration', :controller => :iteration, :action => :save
  map.edit_iteration '/project/:project_id/edit_iteration/:index', :controller => :iteration, :action => :edit
  map.update_iteration '/project/:project_id/update_iteration/:index', :controller => :iteration, :action => :update

  map.iteration_attachment '/project/:project_id/iteration/:index/:name.:format', :controller => :iteration, :action => :attachment
  map.remove_iteration_attachment '/project/:project_id/iteration/:index/remove/:name.:format', :controller => :iteration, :action => :remove_attachment

  map.dashboard_for_a_date '/dashboard/week_ending', :controller => :dashboard, :action => :index
  map.metric_view '/metric', :controller => :metrics, :action => :index 
  
  map.root :controller => :dashboard, :action => :index
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
