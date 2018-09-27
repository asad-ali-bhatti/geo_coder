class Application
  def call(env)
  end

  class << self
    def settings
      @settings ||= { port: 3000 }
    end

    def config(&block)
      yield self
    end

    def set(setting, value)
      settings[setting.to_sym] = value
    end

    def get(setting)
      settings[setting]
    end
  end
end