class Route
  attr_accessor :request, :path_info

  def initialize(request)
    self.request = request
    extract_path_info
  end

  def extract_path_info
    pieces = request.path.split('/')
    x, controller_name, action_name =  pieces.any? ? pieces : ['','','']

    if action_name.nil? and request.get?
      'index'
    elsif action_name.nil? and request.post?
      'create'
    else
      ''
    end

    action_name = 'index' if action_name.nil? && request.get?

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
      [200, {'Content-Type' => 'text/html'}, ["Welcome to geocoder"]]
    else
      if controller
        call_action
      else
        [404, {'Content-Type' => 'text/html'}, ["Page not found"]]
      end
    end
  end

  def build_response(code, headers, body)
    [code, headers, body]
  end



  def call_action
    if controller.respond_to? path_info[:action_name]
      controller.new(request).send(path_info[:action_name])
    else
      raise ActionNotFound.new
    end
  end

  private

  class ActionNotFound < StandardError
  end
end