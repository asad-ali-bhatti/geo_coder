class ProjectsController < ApplicationController
  def index(request)
    [200, {'Content-Type' => 'application/json'}, [{name: 'project1'}.to_json]]
  end
end