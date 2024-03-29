class IterationController < ApplicationController
  def new
    @project = Project.get(params[:project_id])
    @project_template = ProjectTemplate.project_template
    @iteration = Iteration.new
    render :template => false
  end
  
  def save
    @project = Project.get(params[:project_id])
    iteration = Iteration.new(params[:iteration])
    iteration.file_attachments = params[:attachments] if params[:attachments]
    
    @project.iterations << iteration
    @project.save!
    
    redirect_to(@project)
  end

  def edit
    @project = Project.get(params[:project_id])
    @iteration = @project.iterations[params[:index].to_i]
    render :template => false
  end
  
  def update
    @project = Project.get(params[:project_id])
    iteration = @project.iterations[params[:index].to_i]
    iteration.file_attachments = params[:attachments] if params[:attachments]
    iteration.merge!(params[:iteration])
    
    @project.save!
    redirect_to(@project)
  end
  
  def attachment
    @project = Project.get(params[:project_id])
    iteration = @project.iterations[params[:index].to_i]
    attachment = iteration.file_attachments.find{|attachment| attachment["name"] == "#{params[:name]}.#{params[:format]}"}
    send_data File.read(attachment["location"]), :filename => attachment[:name], :type => attachment["mime_type"]
  end
  
  def remove_attachment
    @project = Project.get(params[:project_id])
    iteration = @project.iterations[params[:index].to_i]
    attachment = iteration.file_attachments.find{|attachment| attachment["name"] == "#{params[:name]}.#{params[:format]}"}
    iteration["attachments"].delete(attachment)
    @project.save!

    request.xhr? ? render(:text => "success") : redirect_to(@project)
  end
end