class Module
  def attribute(*args, &block)
    args.each do |arg|
      default=nil
      if arg.is_a?(Hash)
        arg.each_pair { |key,v|
          default=v
          arg=key
        }
      end
      define_method("default_#{arg}"){ default || instance_eval(&block)}
      self.class_eval("def #{arg}; if defined?(@#{arg});  @#{arg}; else; @#{arg}=default_#{arg}; end; end")
      self.class_eval("def #{arg}=(val); @#{arg}=val;end")
      self.class_eval("def #{arg}?;!@#{arg}.nil?;end")
    end
  end
end





