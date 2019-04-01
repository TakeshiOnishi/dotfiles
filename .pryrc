Pry.config.color = true

# 色設定メソッドの定義
def Pry.set_color sym, color
  CodeRay::Encoders::Terminal::TOKEN_COLORS[sym] = color.to_s
  { sym => color.to_s }
end

Pry.config.prompt = proc do |obj, nest_level, _pry_|
version = ''
version << "Rails#{Rails.version}" if defined? Rails
version << "\001\e[0;31m\002"
version << " [#{RUBY_VERSION}] "
version << "\001\e[0m\002"

"#{version} #{Pry.config.prompt_name}(#{Pry.view_clip(obj)})> "
end
