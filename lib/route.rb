class Route
  attr_accessor :request, :path_info
  NOT_FOUND_RESPONSE = [404, {'Content-Type' => 'text/html'}, ["Page not found"]]

  def initialize(request)
    self.request = request
    extract_path_info
  end

  def extract_path_info

    pieces = request.path.split('/')
    x, controller_name, action_name =  pieces.any? ? pieces: ['','','']

    action_name = if action_name.nil? and request.get?
                    'index'
                  elsif action_name.nil? and request.post?
                    'create'
                  else
                    action_name.length > 0 ? action_name : ''
                  end

    if request.path == '/'
      controller_name = 'application'
      action_name = 'welcome'
    end

    self.path_info = {
      controller_name: controller_name.capitalize+'Controller',
      action_name: action_name
    }
  end

  def controller
    begin
      @controller ||= Object.const_get(path_info[:controller_name])
    rescue
      nil
    end
  end

  def process_request
    if request.path == '/'
      [200, {'Content-Type' => 'application/json'}, [{ message: "Welcome to geocoder"}.to_json]]
    else
      if controller
        call_action
      else
        NOT_FOUND_RESPONSE
      end
    end
  end

  def call_action
    controller_instance = controller.new

    if controller_instance.respond_to? path_info[:action_name]
      controller_instance.send(path_info[:action_name], request)
    else
      [ 500, {'Content-Type' => 'application/json'},
        [{error: "Action ##{path_info[:action_name]} is not defined for #{path_info[:controller_name]}"}.to_json]]
    end
  end

  private

  class ActionNotFound < StandardError
  end
end